create or replace PROCEDURE          sp_AcceptDeposit
(
in_depositSeq   IN      number,
in_manangerId   IN      varchar2,
in_executeMoney IN      number,
in_memo         IN      varchar2,    
out_errorCd     OUT     varchar2 ,
out_message     OUT     varchar2)
IS

/******************************************************************************
   NAME:       sp_AcceptDeposit
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019-03-07   Administrator       1. Created this procedure.

   NOTES:TEST SQL
set serveroutput on;
Declare
in_depositSeq           number(20,0);
in_manangerId         varchar2(20);
in_executeMoney      number(21,2);
in_memo             varchar2(200);
out_errorCd         varchar2(200);
out_message         varchar2(200);

begin

in_depositSeq := 12;
in_manangerId :='ShrubAdmin';
in_executeMoney :=20000000;
in_memo :='';


sp_AcceptDeposit(in_depositSeq,in_manangerId,in_executeMoney ,in_memo,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE('out_errorCd：' ||out_errorCd || ' out_message：' ||out_message);
end;


select * from custbalance;

select a.*,to_char(executetime,'HH:MI') from DepositWithDrawInfo a;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_AcceptDeposit
      Sysdate:         2019-03-07
      Date and Time:   2019-03-07, 오후 2:33:32, and 2019-03-07 오후 2:33:32
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

    v_korTime               date;
    v_recordcount           number(10,0);
    v_reuestMoney           number(21,2);
    v_userId                varchar2(20);
    v_sts                   varchar2(4);
    v_bonus                 number(21,2);
    v_bonusSource           varchar2(15);
    v_bonusType             varchar2(4);
    v_bonusCntOfThisMnth    number(5,0);
    v_bonusCntPerMonth      number(5,0);
    v_bonusRate             number(10,3);
    v_bonusMaxMoney         number(21,2);
    v_bonusMoneyOfThisMnth  number(21,2);
    v_firstDeposit          number(21,2);
    --v_processing            varchar2(1);
    
    
BEGIN
    
   
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
    BEGIN                /*1 관리자 계정 정상여부를 확인 합니다*/    
        SELECT COUNT(UserId) into v_recordcount
            FROM UserInfo
        WHERE UserId = in_manangerId AND UserType IN ('0002','0010') AND Active = 'Y';
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0009';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 입금처리 불가 합니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
    END;
    
    BEGIN                /*2 요청금액과 승인금액 일치여부 확인합니다  */
        SELECT COUNT(1) INTO v_recordcount                 
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq;
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0012';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;            
        END IF;
        
        SELECT RequestMoney,UserId,Sts,BonusMoney,BonusSource,BonusType 
                into v_reuestMoney,v_userId,v_sts,v_bonus,v_bonusSource,v_bonusType 
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq;
        IF v_reuestMoney <> in_executeMoney  THEN
            out_errorCd := '0010';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 입금처리 불가 합니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
    
        IF v_sts <> '0001'  THEN
            out_errorCd := '0011';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;        
       
    END;
    
    BEGIN                /* 입금요청 승인처리*/
        
        /*4.0 고객 Balance LOCK*/
        BEGIN
            SELECT COUNT(1)
                    INTO v_recordcount
                FROM CustBalance
                WHERE UserId = v_userId;
            
        END;
        
        /*4.1고객 Balance Update*/
        BEGIN                       
             /*insert*/    
            IF(v_recordcount = 0) THEN         
              
                INSERT INTO CustBalance (UserId, FirstDeposit, Principal, PrincipalGuarantee, AddupDeposit,AddupBonus)                
                VALUES (v_userId,in_executeMoney,in_executeMoney,'0',in_executeMoney,v_bonus);
            /*update*/  
            ELSE
                SELECT FirstDeposit
                    INTO v_firstDeposit
                FROM CustBalance
                     WHERE UserId = v_userId
                        FOR UPDATE WAIT 2;
                     
                IF v_firstDeposit = 0 THEN
                    v_firstDeposit := in_executeMoney;
                END IF;/*Rllback 처리에  FirstDeposit 로직 */
                
                UPDATE CustBalance
                SET                 
                    Principal = Principal + in_executeMoney,                
                    AddupDeposit = AddupDeposit + in_executeMoney, 
                    AddupBonus = AddupBonus + v_bonus,
                    FirstDeposit = v_firstDeposit
                WHERE
                  UserId = v_userId;
            END IF;
        END;  
        
        BEGIN            /*4.2 입금상태 변경*/
            SELECT Sts
                INTO v_sts 
            FROM DepositWithDrawInfo
                WHERE AccessSeq = in_depositSeq                    
                    FOR UPDATE WAIT 2;
                    
            UPDATE DepositWithDrawInfo
            SET          
                ExecuteTime = v_korTime, 
                ExecuteMoney = in_executeMoney, 
                Sts = '0002',           
                MgmtMemo = in_memo, 
                MgmtUserId = in_manangerId
            WHERE
                AccessSeq = in_depositSeq;      
        END;
      
       /*4.3 Event Bonus 사용완료 처리*/
        BEGIN           
            IF (v_bonusSource IS NOT NULL) AND v_bonusType = '0002'  THEN
                /*4.3.1이미 적용 Bonus Count*/                
                SELECT count(BonusMoney),nvl(sum(BonusMoney),0) INTO v_bonusCntOfThisMnth,v_bonusMoneyOfThisMnth
                    FROM DepositWithDrawInfo 
                WHERE UserId = v_userId
                    AND BonusMoney > 0 
                    AND  Sts = '0002'  /*Statues ('0001'시청,'0002'승인)*/
                    /*AND BonusType := '0002'*/
                    AND BonusSource = v_bonusSource;
                
                /*4.3.2Event의 허용Bonus Count*/
                SELECT TO_NUMBER(DECODE(COUNT(1),0,0,MAX(A))),TO_NUMBER(DECODE(COUNT(1),0,0,MAX(B))),TO_NUMBER(DECODE(COUNT(1),0,0,MAX(C))) 
                        INTO v_bonusRate, v_bonusCntPerMonth, v_bonusMaxMoney                        
                    FROM  EventDetail
                WHERE EventId = v_bonusSource;
                DBMS_OUTPUT.PUT_LINE(' v_bonusCntOfThisMnth : ' ||v_bonusCntOfThisMnth ||' v_bonusCntPerMonth : ' ||v_bonusCntPerMonth 
                        ||' v_bonusMoneyOfThisMnth : ' ||v_bonusMoneyOfThisMnth ||' v_bonusMaxMoney : ' ||v_bonusMaxMoney );
                /*4.3.3Event Bonus사용완료처리*/
                IF (v_bonusCntOfThisMnth + 1 >= v_bonusCntPerMonth ) OR (v_bonusMoneyOfThisMnth + v_bonus >= v_bonusMaxMoney)THEN
                    SELECT  DECODE(EventId,NULL,NULL,EventId) INTO v_bonusSource
                    FROM CustEvent                            
                        WHERE UserId = v_userId AND EventId = v_bonusSource
                            FOR UPDATE WAIT 2; 
                    UPDATE CustEvent SET
                        Used = 'Y'
                    WHERE
                        UserId = v_userId AND EventId = v_bonusSource;
                END IF;
            END IF;   
        END;
      
        COMMIT;
        out_errorCd := '0000';
        out_message := spr_GetErrorKRName(out_errorCd);   
    
    END;  

   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       ROLLBACK;   
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm;
       DBMS_OUTPUT.PUT_LINE('sp_AcceptDeposit 실행 시 에러발생');
       
END sp_AcceptDeposit;


create or replace PROCEDURE          sp_BatchCheckLimit 
(
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2
)
 IS
/******************************************************************************
   NAME:       sp_BatchCheckLimit
   PURPOSE: 韩国股票的限制交易及自动增发处理 

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/04/27   sjh-home       1. Created this procedure.

   NOTES:
    SET serveroutput ON;
    DECLARE
    
    out_errorCd                 varchar2(4);
    out_message                 varchar2(200);
    BEGIN
    
    sp_BatchCheckLimit(out_errorCd,out_message);
    DBMS_OUTPUT.PUT_LINE(out_errorCd || out_message);
    END;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_BatchCheckLimit
      Sysdate:         2019/04/27
      Date and Time:   2019/04/27, 오후 5:34:13, and 2019/04/27 오후 5:34:13
      Username:        sjh-home (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime                       date;
v_localTime                     date;               
v_itemId                        varchar2(12);
v_marketId                      varchar2(4);
v_tradable                      varchar2(1);
v_newcap                        number(21,0);
v_oldcap                        number(21,0);

v_newBasic                      number(21,2);
v_oldBasic                      number(21,2);
v_oldClosePrice                 number(21,2);    
v_oldTradeAmt                   number(21,3);    
v_oldTradeMoney                 number(21,2);
v_oldLimitHigh                  number(21,2);
v_oldLimitLow                   number(21,2);   
v_timezone                      number(10,0);

v_value1                        varchar(30);
v_value2                        varchar(30);
v_value3                        varchar(30);
v_value4                        varchar(30);
v_act1                          varchar(30);
v_act2                          varchar(30);
--v_act3                          varchar(30);
v_act4                          varchar(30);
v_act5                          varchar(30);
v_act6                          varchar(30);
v_act7                          varchar(30);
v_act8                          varchar(30);

v_limitHigh                     varchar(30);
v_limitHighValue                varchar(30);

v_limitLow                      varchar(30);
v_limitLowValue                 varchar(30);

--v_memo                          varchar(300);
v_strStatememo                  varchar2(200);
v_strConstmemo                  varchar2(200);

type cur is ref cursor;  
c_itemsCur                      cur;
--v_strItems                      varchar2(500);
v_noDataItems                   varchar2(2000);

BEGIN
    v_timezone := 9;
    v_marketId:= 10;
    v_noDataItems := '';
    SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    usp_getMarketSetting(v_marketId,'InvestLimit1',v_value1,v_value2,v_value3,v_value4,v_act1);
    usp_getMarketSetting(v_marketId,'InvestLimit2',v_value1,v_value2,v_value3,v_value4,v_act2);
    --usp_getMarketSetting(v_marketId,'InvestLimit3',v_value1,v_value2,v_value3,v_value4,v_act3);
    usp_getMarketSetting(v_marketId,'InvestLimit4',v_value1,v_value2,v_value3,v_value4,v_act4);
    usp_getMarketSetting(v_marketId,'InvestLimit5',v_value1,v_value2,v_value3,v_value4,v_act5);
    usp_getMarketSetting(v_marketId,'InvestLimit6',v_value1,v_value2,v_value3,v_value4,v_act6);
    usp_getMarketSetting(v_marketId,'InvestLimit7',v_value1,v_value2,v_value3,v_value4,v_act7);
    usp_getMarketSetting(v_marketId,'InvestLimit8',v_value1,v_value2,v_value3,v_value4,v_act8);
    usp_getMarketSetting(v_marketId,'InvestLimit8',v_value1,v_value2,v_value3,v_value4,v_act8);
    usp_getMarketSetting(v_marketId,'OverHLimitRef',v_limitHighValue,v_value2,v_value3,v_value4,v_limitHigh);
    usp_getMarketSetting(v_marketId,'OverLLimitRef',v_limitLowValue,v_value2,v_value3,v_value4,v_limitLow);
    
    DELETE FROM LimitItems WHERE TRADEDATE = TO_CHAR(v_korTime ,'YYYY-MM-DD');
         
    OPEN c_itemsCur FOR SELECT A.Marketid,
                       A.Itemid,
                       A.Tradable,
                       B.Capitalization Newcap,
                       B.BasicPrice Newbasic,
                       B.Statememo,
                       B.Constmemo,
                       C.Capitalization Oldcap,
                       C.LimitHigh,
                       C.LimitLow,
                       C.BasicPrice oldBase,
                       C.Lastprice,
                       C.TradeAmt,
                       C.TradeMoney
                  FROM TRADEITEMS A
                       LEFT JOIN Itemdetail B
                          ON A.Marketid = B.Marketid AND A.Itemid = B.Itemid AND B.Recordday = TO_CHAR(v_korTime ,'YYYY-MM-DD')
                       LEFT JOIN Itemdetail C
                          ON A.Marketid = C.Marketid AND A.Itemid = C.Itemid AND C.Recordday = TO_CHAR(v_korTime - 1,'YYYY-MM-DD')
                 WHERE A.MARKETID = v_marketId;
        LOOP
            FETCH c_itemsCur INTO v_marketId,v_itemId,v_tradable,v_newcap,v_newBasic,v_strStatememo,v_strConstmemo,v_oldcap,v_oldLimitHigh,v_oldLimitLow,v_oldBasic,v_oldClosePrice,v_oldTradeAmt,v_oldTradeMoney;    
                  EXIT WHEN c_itemsCur%NOTFOUND;
                  IF v_strStatememo IS NULL OR v_strConstmemo IS NULL OR v_newBasic IS NULL OR v_oldClosePrice IS NULL THEN
                    v_noDataItems:= v_noDataItems || v_itemId || ',';
                    continue;
                  END IF;
                      
                  IF v_act1 = 'Y' AND instr(v_strStatememo,'거래정지') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0001'/*거래정지*/,v_korTime);
                  ELSIF v_act2 = 'Y' AND instr(v_strStatememo,'관리종목') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0002'/*관리종목*/,v_korTime);
                  ELSIF v_act4 = 'Y' AND instr(v_strStatememo,'정리매매') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0004'/*정리매매*/,v_korTime);   
                  ELSIF v_act5 = 'Y' AND instr(v_strConstmemo,'투자경고') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0005'/*투자경고*/,v_korTime);  
                  ELSIF v_act6 = 'Y' AND instr(v_strConstmemo,'투자주의') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0006'/*투자주의*/,v_korTime);  
                  ELSIF v_act7 = 'Y' AND instr(v_strConstmemo,'투자위험') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0007'/*투자위험*/,v_korTime);                                                     
                  ELSIF v_act8 = 'Y' AND instr(v_strConstmemo,'투자주의환기') >0 THEN
                            INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0008'/*투자주의환기*/,v_korTime);           
                  END IF;
                      
                  IF v_limitHigh = 'Y' AND  (v_oldClosePrice >=  v_oldLimitHigh OR  v_oldClosePrice >= v_oldBasic * (1+ to_number(v_limitHighValue) / 100) )THEN
                        INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0020'/*전일상한가*/,v_korTime);
                                    
                  END IF;
                  
                  IF v_limitLow = 'Y' AND  (v_oldClosePrice <=  v_oldLimitLow OR  v_oldClosePrice <= v_oldBasic * (1 - to_number(v_limitLowValue) / 100) ) THEN
                        INSERT INTO LimitItems (TradeDate,ItemId,MarketId, LimitType,ReleaseDate) 
                                VALUES (TO_CHAR(v_korTime,'YYYY-MM-DD'), v_itemId,v_marketId,'0021'/*전하상한가*/,v_korTime);
                                    
                  END IF;
                  
       END LOOP;   
    CLOSE c_itemsCur;
    
    IF v_noDataItems IS NULL OR LENGTH(v_noDataItems) = 0 THEN           
        COMMIT;
    ELSE
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd) || v_noDataItems ;
       ROLLBACK;
    END IF;
    
   EXCEPTION
     WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_BatchCheckLimit 실행 시 에러발생');
END sp_BatchCheckLimit;

create or replace PROCEDURE          sp_BatchOffering
(
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2
)
 IS
/******************************************************************************
   NAME:       sp_BatchOffering
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/05/06   sjh-home       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_BatchOffering
      Sysdate:         2019/05/06
      Date and Time:   2019/05/06, 오후 3:43:25, and 2019/05/06 오후 3:43:25
      Username:        sjh-home (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime                       date;
v_localTime                     date; 
v_positionSeq                   number(21,0);              
v_itemId                        varchar2(12);
v_marketId                      varchar2(4);


v_closedAmt                     number(21,3);
v_holdAmt                       number(21,3);
v_lockedAmt                     number(21,3);
v_addupOpenAmt                  number(21,3);
v_avgPrice                      number(21,2);
v_newcap                        number(21,0);
v_oldcap                        number(21,0);

v_newBasic                      number(21,2);
v_oldBasic                      number(21,2);
v_oldClosePrice                 number(21,2);    
v_oldTradeAmt                   number(21,3);    
v_oldTradeMoney                 number(21,2);
v_oldLimitHigh                  number(21,2);
v_oldLimitLow                   number(21,2);   
v_timezone                      number(10,0);

v_value1                        varchar(30);
v_value2                        varchar(30);
v_value3                        varchar(30);
v_value4                        varchar(30);
v_act1                          varchar(30);
v_act2                          varchar(30);
--v_act3                          varchar(30);
v_act4                          varchar(30);
v_act5                          varchar(30);
v_act6                          varchar(30);
v_act7                          varchar(30);
v_act8                          varchar(30);

v_limitHigh                     varchar(30);
v_limitHighValue                varchar(30);

v_limitLow                      varchar(30);
v_limitLowValue                 varchar(30);

--v_memo                          varchar(300);
--v_strStatememo                  varchar2(200);
--v_strConstmemo                  varchar2(200);

type cur1 is ref cursor;  
c_positionsCur                      cur1;
type cur2 is ref cursor;  
c_orderPairsCur                      cur2;
--v_strItems                      varchar2(500);
v_noDataItems                   varchar2(2000);
v_offerRate                     number(10,4);
v_newHoldAmt                    number(10,3);
v_orderPairSeq                  number(21,0);
v_orderId                       number(21,0);
v_openAmt                       number(21,3);
v_closeAmt                      number(21,3);
v_openPrice                     number(21,2);

BEGIN
    v_timezone := 9;
    v_marketId:= 10;
    v_noDataItems := '';
    SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    usp_getMarketSetting(v_marketId,'InvestLimit1',v_value1,v_value2,v_value3,v_value4,v_act1);
    usp_getMarketSetting(v_marketId,'InvestLimit2',v_value1,v_value2,v_value3,v_value4,v_act2);
    --usp_getMarketSetting(v_marketId,'InvestLimit3',v_value1,v_value2,v_value3,v_value4,v_act3);
    usp_getMarketSetting(v_marketId,'InvestLimit4',v_value1,v_value2,v_value3,v_value4,v_act4);
    usp_getMarketSetting(v_marketId,'InvestLimit5',v_value1,v_value2,v_value3,v_value4,v_act5);
    usp_getMarketSetting(v_marketId,'InvestLimit6',v_value1,v_value2,v_value3,v_value4,v_act6);
    usp_getMarketSetting(v_marketId,'InvestLimit7',v_value1,v_value2,v_value3,v_value4,v_act7);
    usp_getMarketSetting(v_marketId,'InvestLimit8',v_value1,v_value2,v_value3,v_value4,v_act8);
    usp_getMarketSetting(v_marketId,'InvestLimit8',v_value1,v_value2,v_value3,v_value4,v_act8);
    usp_getMarketSetting(v_marketId,'OverHLimitRef',v_limitHighValue,v_value2,v_value3,v_value4,v_limitHigh);
    usp_getMarketSetting(v_marketId,'OverLLimitRef',v_limitLowValue,v_value2,v_value3,v_value4,v_limitLow);
    
    DELETE FROM LimitItems WHERE TRADEDATE = TO_CHAR(v_korTime ,'YYYY-MM-DD');



         
    OPEN c_positionsCur FOR SELECT A.POSITIONSEQ,
                       A.AvgPrice, Closed, HoldAmt, Locked, AddupOpenAmt,
                       --AddupOpenMoney,
                       -- AddupCloseAmt, AddupCloseMoney, AddupGuarantee,
                       -- AddMarginPlace, AddupReurnMoney, AddupReturnProfit, MgmtLock, ReturnType 
                       B.Capitalization Newcap,
                       B.BasicPrice Newbasic,
                       --B.Statememo,
                       --B.Constmemo,
                       C.Capitalization Oldcap,
                       C.LimitHigh,
                       C.LimitLow,
                       C.BasicPrice oldBase,
                       C.Lastprice,
                       C.TradeAmt,
                       C.TradeMoney
                  FROM POSITIONS A
                       JOIN Itemdetail B
                          ON A.Marketid = B.Marketid AND A.Itemid = B.Itemid AND B.Recordday = TO_CHAR(v_korTime ,'YYYY-MM-DD')
                       JOIN Itemdetail C
                          ON A.Marketid = C.Marketid AND A.Itemid = C.Itemid AND C.Recordday = TO_CHAR(v_korTime - 1,'YYYY-MM-DD')
                  WHERE B.BASICPRICE <> C.LASTPRICE AND B.BASICPRICE IS NOT NULL AND C.LASTPRICE IS NOT NULL
                       AND B.Capitalization <> C.Capitalization
                       AND A.CLOSED <>'Y' AND A.HoldAmt>0;
        LOOP
            FETCH c_positionsCur INTO v_positionSeq,v_avgPrice,v_closedAmt,v_holdAmt,v_lockedAmt,v_addupOpenAmt,v_newcap,v_newBasic,v_oldcap,v_oldLimitHigh,v_oldLimitLow,v_oldBasic,v_oldClosePrice,v_oldTradeAmt,v_oldTradeMoney;    
                  EXIT WHEN c_positionsCur%NOTFOUND;
                IF ( v_oldClosePrice IS NOT NULL AND v_newBasic IS NOT NULL AND v_newBasic != v_oldClosePrice) THEN
                    v_offerRate := round(v_oldClosePrice / v_newBasic,2); 
                    v_holdAmt := v_newHoldAmt * v_offerRate;
                    
                    OPEN c_orderPairsCur FOR SELECT OrderPairSeq, OrderId, PositionSeq, OpenAmt, OpenPrice, CloseAmt 
                                                    FROM OrderPairsInfo
                                                WHERE PositionSeq = v_positionSeq AND OpenOrderType = '0001' AND OpenAmt > CloseAmt;
                          LOOP
                                FETCH c_orderPairsCur INTO v_orderPairSeq,v_orderId,v_openAmt,v_closeAmt,v_openPrice;
                                    EXIT WHEN c_orderPairsCur%NOTFOUND;
                          END LOOP;
                    CLOSE c_orderPairsCur;
                    
                END IF;
                  
       END LOOP;   
    CLOSE c_positionsCur;
    
    IF v_noDataItems IS NULL OR LENGTH(v_noDataItems) = 0 THEN           
        COMMIT;
    ELSE
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd) || v_noDataItems ;
       ROLLBACK;
    END IF;
    
   EXCEPTION
     WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_BatchCheckLimit 실행 시 에러발생');
END sp_BatchOffering;

create or replace PROCEDURE          sp_checkLossCut (
in_brrwId           IN          number,
out_errorCd         OUT         varchar2,
out_message         OUT         varchar2
)IS
/******************************************************************************
   NAME:       sp_checkLossCut
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/04/15   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_checkLossCut
      Sysdate:         2019/04/15
      Date and Time:   2019/04/15, 오후 4:53:50, and 2019/04/15 오후 4:53:50
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime                       date;
v_localTime                     date;

v_orderId                       number(20,0);    
v_positionSeq                   number(20,0);
v_brrwId                        number(20,0);
v_userId                        varchar2(12);
v_itemId                        varchar2(12);
v_marketId                      varchar2(4);
v_positionType                  varchar2(4);
v_tradeType                     varchar2(4);
v_orderType                     varchar2(4);
v_orderPrice                    number(21,2);
v_orderAmt                      number(21,3);
v_executedType                  varchar2(4);     
v_placeType                     varchar2(4);
--v_openClose                     varchar2(4);
v_returnType                    varchar2(4);
--v_overRate                      number(21,2);
--v_overCloseType                 varchar2(4);
           
v_margin                        number(21,2);
v_usableMarginPlace             number(21,2);
--v_recordCnt                     number(20,0);
--v_shortSellAllow                varchar2(10);
--v_marketShortSellAllow          varchar2(1);
--v_itemShortSellAllow            varchar2(1);
--v_vipShortSellAllow             varchar2(1);    
--v_tradable                      varchar2(1);
v_timezone                      number(5,0);    
--v_minBrrwRateOfMarket           number(5,0);
--v_maxBrrwRateOfMarket           number(5,0);
v_addupGuarantee                number(21,3);
v_addupWithdrawGuarantee        number(21,3);
v_profit                        number(21,3);
v_addupFee                      number(21,3);
v_tradebleAmt                   number(21,3);
v_value0                        varchar(30);
v_value1                        varchar(30);
v_value2                        varchar(30);
v_value3                        varchar(30);
v_lossCutPcnt                   varchar(30);
v_memo                          varchar(300);
v_strPositions                  varchar2(500);
 
cursor c_openOrders  is SELECT orderId FROM ORDERS    WHERE BrrwId = in_brrwId AND OpenClose = '0001' AND sts = '0001';
--cursor c_positions is SELECT PositionSeq FROM POSITIONS WHERE BrrwId = in_brrwId AND (HoldAmt - locked) > 0;
type cur is ref cursor;  
c_positions cur;
--  cursor c_positions   is SELECT PositionSeq FROM POSITIONS WHERE BrrwId = in_brrwId AND (HoldAmt - locked) > 0;
BEGIN
   SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
   SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
   
   /*Check lostCut Condition*/
   BEGIN
        SELECT SUM( 
                CASE  WHEN P.PositionType = '0002' THEN
                   AddupOpenMoney - AddupCloseMoney - p.HoldAmt*DECODE(r.Price,null,p.AvgPrice,r.Price)
                                       
                ELSE
                   AddupCloseMoney + p.HoldAmt*DECODE(r.Price,null,p.AvgPrice,r.Price) - AddupOpenMoney
                END) AS TMP INTO v_margin
                    
        FROM Positions p left join RealtimePrice r
                ON  p.ItemId= r.ItemId AND p.MarketId =r.MarketId
            WHERE p.BrrwId= in_brrwId                
                AND p.HoldAmt > 0 ;
        SELECT UserId,AddupPrincipalGuarantee, AddupWithdrawGuarantee,  AddupCloseProfit, AddupLossCutFee+ AddupCloseFee + AddupMgmtFee + AddupTradeFee + AddupTradeTax+ AddupOverNightFee 
               INTO v_userId,v_addupGuarantee,v_addupWithdrawGuarantee,v_profit,v_addupFee
            FROM BorrowInfo 
        WHERE BrrwId= in_brrwId ;
        
        usp_getOperationSetting('LossCutPcnt',v_value0,v_value1,v_value2,v_value3);    
        usp_getUserSetting(v_userId,'LossCutPcnt',v_lossCutPcnt);    
        IF v_lossCutPcnt IS NULL THEN
           v_lossCutPcnt := v_value0;
        END IF;
        IF (v_addupGuarantee + v_profit + v_margin - v_addupWithdrawGuarantee - v_addupFee ) > v_addupGuarantee * to_number(v_lossCutPcnt) THEN
            RETURN;
        END IF;
   END;
   
   UPDATE  BorrowInfo SET
        Returned = 'W' /*等待Postion Close 完成*/
   WHERE BrrwId= in_brrwId ;
       
        
   /* 전 지정가 Order취소 후 Positions 반대 매매처리 */
   /*取消所有未执行状态的Order(指定价格)况*/
   BEGIN
        
        OPEN c_openOrders; 
        LOOP
            FETCH c_openOrders INTO v_orderId;
            EXIT WHEN c_openOrders%notfound; 
                sp_RejectOrder(v_orderId,'0004',null,out_errorCd,out_message);
            END LOOP;   
        CLOSE c_openOrders;   
                
   END;
   
   BEGIN
        
        v_strPositions:= 'SELECT PositionSeq FROM POSITIONS WHERE BrrwId = '|| in_brrwId || ' AND (HoldAmt - locked) > 0 ';
        
        --SELECT UserId INTO v_userId FROM Borrowinfo where brrwId = in_brrwId;
        --usp_getUserOverSetting(v_userId, v_overRate, v_overCloseType, out_errorCd,out_message);
        
        
        
        
        OPEN c_positions for v_strPositions; 
        LOOP
            FETCH c_positions INTO v_positionSeq;
            EXIT WHEN c_positions%notfound;            
            
                SELECT          UserId,     MarketId, ItemId,  BrrwId， PositionType,  HoldAmt - Locked , PlaceType,  PositionType, ReturnType
                       INTO   v_userId,   v_marketId, v_itemId,v_brrwId,v_positionType,v_tradebleAmt    ,v_placeType,v_positionType,v_returnType
                FROM Positions 
                    WHERE PositionSeq = v_positionSeq
                    FOR UPDATE NOWAIT;  
                IF v_positionType = '0001' THEN
                    v_orderType := '0002';
                ELSE
                    v_orderType := '0001';
                END IF;
                  
                v_tradeType := '0002'; /*시장가*/
                v_executedType := '0005' ;/*'0001' /고객/ '0003' /이익스탑/ '0004' /손실스탑/ ELSE 0002 장마감,0005 LossCut,0006 BrrwReturn,0007 오버낫초과,0008 오버낫 마감,0010 관리자 */
                v_orderAmt := v_tradebleAmt;
                SELECT DECODE(COUNT(1),0,0.99,Price) INTO v_orderPrice FROM RealtimePrice WHERE MARKETID = v_marketId AND ItemId = v_itemId;
                sp_PlaceOrder(v_userId,v_itemId,v_marketId,v_brrwId,v_positionType,v_tradeType,v_orderType,v_orderPrice,v_orderAmt,v_executedType,v_placeType,v_memo,out_errorCd,out_message);
                    
            END LOOP;   
        CLOSE c_positions; 
        
                   
   END;
   
   COMMIT; 
   
   EXCEPTION
    WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_checkLossCut 실행 시 에러발생');
END sp_checkLossCut;

create or replace PROCEDURE          sp_CheckPreOrder 
(
in_preOrderId       IN          number,
out_errorCd         OUT         varchar2,
out_message         OUT         varchar2
)IS 
/******************************************************************************
   NAME:       sp_CheckPreOrder
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/04/17   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_CheckPreOrder
      Sysdate:         2019/04/17
      Date and Time:   2019/04/17, 오후 4:00:52, and 2019/04/17 오후 4:00:52
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime                       date;
v_localTime                     date;

 
--v_orderId                       number(20,0);    
v_positionSeq                   number(20,0);
v_brrwId                        number(20,0);
v_userId                        varchar2(12);
v_itemId                        varchar2(12);
v_marketId                      varchar2(4);
v_positionType                  varchar2(4);
v_tradeType                     varchar2(4);
v_orderType                     varchar2(4);
--v_orderPrice                    number(21,2);
--v_orderAmt                      number(21,3);
v_executedType                  varchar2(4);     
v_placeType                     varchar2(4);
v_crossType                     varchar2(4);
v_returnType                    varchar2(4);
v_tradebleAmt                   number(21,2);

           
v_preOrderPrice                 number(21,2);
v_price                         number(21,2);
v_recordCnt                     number(20,0);
--v_shortSellAllow                varchar2(10);
--v_marketShortSellAllow          varchar2(1);
--v_itemShortSellAllow            varchar2(1);
--v_vipShortSellAllow             varchar2(1);    
--v_tradable                      varchar2(1);
v_timezone                      number(5,0);    
--v_minBrrwRateOfMarket           number(5,0);
--v_maxBrrwRateOfMarket           number(5,0);
v_priceTime                     date;
v_realtimeDelay                 varchar(30);
v_value1                        varchar(30);
v_value2                        varchar(30);
v_value3                        varchar(30);
v_memo                          varchar(100);
BEGIN
    BEGIN    
        SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
        SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    END;
    BEGIN
        /*기본정보 가지오기*/
        SELECT PO.PositionSeq, PO.CrossType, PO.OrderPrice ,    P.UserId,     P.MarketId, P.ItemId,  P.BrrwId，P.HoldAmt - P.Locked , P.PlaceType,  P.PositionType, P.ReturnType ,R.price, DECODE(R.priceTime,NULL,NULL, R.priceTime)                 
                INTO v_positionSeq, v_crossType, v_preOrderPrice, v_userId,   v_marketId, v_itemId,  v_brrwId,    v_tradebleAmt    ,v_placeType,    v_positionType, v_returnType ,v_price, v_priceTime
            FROM Positions P LEFT JOIN PreOrders PO ON  P.PositionSeq = PO.PositionSeq LEFT JOIN RealTimePrice R ON  P.ItemId = R.ItemId AND P.MarketId = R.MarketId
        WHERE PreOrderId = in_preOrderId ;
        
        SELECT COUNT(MarketId) INTO v_recordCnt 
            FROM TradingTimeInfo 
        WHERE    MarketId = v_marketId
            AND to_date(to_char(v_localTime,'hh24:mi'),'hh24:mi') >= to_date(to_char(LocalOpenTime,'hh24:mi'),'hh24:mi')
            AND to_date(to_char(v_localTime,'hh24:mi'),'hh24:mi') <= to_date(to_char(LocalCloseTime,'hh24:mi'),'hh24:mi')                
            AND MgmtType = '0001';                            /*거래시간 내에 만 Order 생성*/
        
        IF(v_recordCnt = 0 ) THEN
            out_errorCd := '0030';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
        
        IF (v_priceTime IS NULL) THEN
            out_errorCd := '0056';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN; 
        END IF;
       
        /*가격 Update시간 1분 전 이며 거래 안 합니다*/
        usp_getOperationSetting('RealtimeDelay',v_realtimeDelay,v_value1,v_value2,v_value3);
        
        IF ROUND(TO_NUMBER(v_korTime - v_priceTime) * 24 * 60 * 60) > TO_NUMBER(v_realtimeDelay) THEN
            out_errorCd := '0057';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;  
        END IF;
            
    END;
   
    BEGIN
        IF v_crossType = '0001' AND v_price < v_preOrderPrice THEN
            RETURN;
        ELSIF v_crossType = '0002' AND v_price > v_preOrderPrice THEN
            RETURN;
        END IF;
    END;
    BEGIN
        /*多*/
        IF v_positionType = '0001' THEN
            v_orderType := '0002';
            IF v_crossType = '0001' THEN
                v_executedType := '0003'; /*이익스탑*/
            ELSE
                v_executedType := '0004'; /*손실스탑*/
            END IF;
        /*空*/
        ELSE
            v_orderType := '0001';
            IF v_crossType = '0002' THEN
                v_executedType := '0003'; /*이익스탑*/
            ELSE
                v_executedType := '0004'; /*손실스탑*/
            END IF;
        END IF;
        v_tradeType := '0002'; /*시장가*/        
        sp_PlaceOrder(v_userId,v_itemId,v_marketId,v_brrwId,v_positionType,v_tradeType,v_orderType,v_preOrderPrice,v_tradebleAmt,v_executedType,v_placeType,v_memo,out_errorCd,out_message); 
    END;
   EXCEPTION
    WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_CheckPreOrder 실행 시 에러발생');
END sp_CheckPreOrder;

create or replace PROCEDURE          sp_ClosePositionsOfBrrw 
(
in_brrwId           IN          number,
in_executedType     IN          varchar2,/*0005 LostCut , 0006Return Brrw*/
out_errorCd         OUT         varchar2,
out_message         OUT         varchar2
)IS 
/******************************************************************************
   NAME:       sp_ClosePositionsOfBrrw
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019-04-09   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_ClosePositionsOfBrrw
      Sysdate:         2019-04-09
      Date and Time:   2019-04-09, 오전 9:12:42, and 2019-04-09 오전 9:12:42
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime                       date;
v_localTime                     date;

v_orderId                       number(20,0);    
v_positionSeq                   number(20,0);
v_brrwId                        number(20,0);
v_userId                        varchar2(12);
v_itemId                        varchar2(12);
v_marketId                      varchar2(4);
v_positionType                  varchar2(4);
v_tradeType                     varchar2(4);
v_orderType                     varchar2(4);
v_orderPrice                    number(21,2);
v_orderAmt                      number(21,3);
v_executedType                  varchar2(4);     
v_placeType                     varchar2(4);
--v_openClose                     varchar2(4);
v_returnType                    varchar2(4);
--v_overRate                      number(21,2);
--v_overCloseType                 varchar2(4);
           
--v_usableForTrade                number(21,2);
v_usableMarginPlace             number(21,2);
--v_recordCnt                     number(20,0);
--v_shortSellAllow                varchar2(10);
--v_marketShortSellAllow          varchar2(1);
--v_itemShortSellAllow            varchar2(1);
--v_vipShortSellAllow             varchar2(1);    
--v_tradable                      varchar2(1);
v_timezone                      number(5,0);    
--v_minBrrwRateOfMarket           number(5,0);
--v_maxBrrwRateOfMarket           number(5,0);

v_tradebleAmt                   number(21,3);
--v_value1                        varchar(30);
--v_value2                        varchar(30);
--v_value3                        varchar(30);
v_memo                          varchar(300);
--v_strPositions                  varchar2(500);
 
cursor c_openOrders  is SELECT orderId FROM ORDERS    WHERE BrrwId = in_brrwId AND OpenClose = '0001' AND sts = '0001';
cursor c_positions is SELECT PositionSeq FROM POSITIONS WHERE BrrwId = in_brrwId AND (HoldAmt - locked) > 0;
--type cur is ref cursor;  
--c_positions cur;
--  cursor c_positions   is SELECT PositionSeq FROM POSITIONS WHERE BrrwId = in_brrwId AND (HoldAmt - locked) > 0;
BEGIN
   SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
   SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
   IF in_executedType NOT IN ('0005','0006') THEN
        RETURN;
   END IF; 
   
   UPDATE  BorrowInfo SET
        Returned = 'W' /*等待Postion Close 完成*/
   WHERE BrrwId= in_brrwId ;
   
   /*전체 반대매매경우 진행주 Open오더 취소 처리*/
   /*整个贷款都清仓情况*/
   BEGIN
        
        OPEN c_openOrders; 
        LOOP
            FETCH c_openOrders INTO v_orderId;
            EXIT WHEN c_openOrders%notfound; 
                sp_RejectOrder(v_orderId,'0004',null,out_errorCd,out_message);
            END LOOP;   
        CLOSE c_openOrders;   
                
   END;
   
    BEGIN
        
        --v_strPositions:= 'SELECT PositionSeq FROM POSITIONS WHERE BrrwId = in_brrwId AND (HoldAmt - locked) > 0';
        
        --SELECT UserId INTO v_userId FROM Borrowinfo where brrwId = in_brrwId;
        --usp_getUserOverSetting(v_userId, v_overRate, v_overCloseType, out_errorCd,out_message);
        OPEN c_positions; 
        LOOP
            FETCH c_positions INTO v_positionSeq;
            EXIT WHEN c_positions%notfound;            
            
                SELECT          UserId,     MarketId, ItemId,  BrrwId， PositionType,  HoldAmt - Locked , PlaceType,  PositionType, ReturnType
                       INTO   v_userId,   v_marketId, v_itemId,v_brrwId,v_positionType,v_tradebleAmt    ,v_placeType,v_positionType,v_returnType
                FROM Positions 
                    WHERE PositionSeq = v_positionSeq
                    FOR UPDATE NOWAIT;  
                IF v_positionType = '0001' THEN
                    v_orderType := '0002';
                ELSE
                    v_orderType := '0001';
                END IF;
                  
                v_tradeType := '0002'; /*시장가*/
                v_executedType := in_executedType ;/*'0006';/*'0001' /고객/ '0003' /이익스탑/ '0004' /손실스탑/ ELSE 0002 장마감,0005 LossCut,0006 BrrwReturn,0007 오버낫초과,0008 오버낫 마감,0010 관리자 */
                v_orderAmt := v_tradebleAmt;
                SELECT DECODE(COUNT(1),0,0.99,Price) INTO v_orderPrice FROM RealtimePrice WHERE MARKETID = v_marketId AND ItemId = v_itemId;
                sp_PlaceOrder(v_userId,v_itemId,v_marketId,v_brrwId,v_positionType,v_tradeType,v_orderType,v_orderPrice,v_orderAmt,v_executedType,v_placeType,v_memo,out_errorCd,out_message);             
              
                    
            END LOOP;   
        CLOSE c_positions; 
                   
   END;
    COMMIT; 
   
   EXCEPTION
    WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('SP_ClosePositionsOfBrrw 실행 시 에러발생');
END SP_ClosePositionsOfBrrw;

create or replace PROCEDURE          sp_ExecuteOrder
(
in_orderId      IN      number,
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2
)IS

/******************************************************************************
   NAME:       sp_ExecuteOrder
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/20   Administrator       1. Created this procedure.

   NOTES:TEST SQL
   
   SET serveroutput ON;
    DECLARE
    in_orderId                  number(21,0); 
    out_errorCd                 varchar2(4);
    out_message                 varchar2(200);
    BEGIN
    in_orderId := 1;
    sp_ExecuteOrder(in_orderId,out_errorCd,out_message);
    DBMS_OUTPUT.PUT_LINE(out_errorCd || out_message);
    END;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_ExecuteOrder
      Sysdate:         2019/03/20
      Date and Time:   2019/03/20, 오후 12:45:22, and 2019/03/20 오후 12:45:22
      Username:        Administrator (in TOAD Options, Procedure Editor)
      Table Name:       (in the "New PL/SQL Object" dialog)

******************************************************************************/
v_korTime               date;
v_localTime             date;
v_marketOpenTime        varchar2(20); 
v_marketCloseTime       varchar2(20);
v_recordCnt             number(10,0);
v_recordCnt2            number(10,0);
v_realTimeDelay         number(10,0);

v_positionSeq           number(20,0);
v_brrwId                number(20,0);
v_orderTransId          number(20,0);
v_orderExcutSeq         number(20,0);
v_itemId                varchar2(20);
v_marketId              varchar2(4);    
v_positionType          varchar2(4);
v_tradeType             varchar2(4);
v_orderType             varchar2(4);
v_orderPrice            number(21,2);
v_orderAmt              number(21,3);
v_sts                   varchar2(4);
v_executedType          varchar2(4);
v_placeType             varchar2(4);
v_openClose             varchar2(4);

v_price                 number(21,3);
v_updateTime            date;
v_priceTime             date;
v_returnType            varchar2(4);
v_avgPrice              number(21,2);

v_tradable              varchar2(1);
--v_itemShortSellAllow    varchar2(1);
v_timezone              number(10,0);
v_marginPlace           number(21,2); 
v_closed                varchar2(1);


v_userId                 varchar2(20);
v_tradeTaxRate           number(10,4);  
v_tradeFeeRate           number(10,4);  
v_mgmtFeeRate            number(10,4);  
v_closeFeeRate           number(10,4);  
v_lossCutFeeRate         number(10,4);  
v_overNight              varchar2(1);
v_overNightFeeRate       number (10,4); 
v_overNightMaxDay        number(5,0);  
v_overNightFreeDay       number(5,0);  
v_lossCutFree            varchar2(1);
v_lossCutRateMin         number(10,4);  
v_lostCutRateMax         number(10,4);  
v_shortSellAllow         varchar2(1);
v_bonusRate              number(10,4);  
v_bonusCntPerMonth       number(5,0);  
v_bonusActive            varchar2(1);
v_bonusMaxMoney          number(21,2);  
v_maxBrrwCnt             number(5,0);  
v_maxBrrwRate            number(10,0);  
v_maxBrrwMoney           number(21,2);  
v_membershipDay          number(5,0);  
v_profitInvestActive     varchar2(1);
v_lossCutPcnt            number(10,4);  
v_vipTypeId              varchar2(10);
v_vipId                  varchar2(20);
v_specialVip             varchar2(20);
   


v_tradeFeeMode          varchar2(4);
v_tradeTaxMode          varchar2(4);
v_mgmtFeeMode           varchar2(4);

v_tradeTax              number(21,2);
v_tradeFee              number(21,2);
v_mgmtFee               number(21,2);
v_closeFee              number(21,2);
v_lossCutFee            number(21,2);
--v_overNightFee          number(21,2);
v_tradeMoney            number(21,2);

v_addupBonus            number(21,2);
v_addupUsedBonus        number(21,2);
v_bonusMoney            number(21,2);
v_bonusTemp             number(21,2);

v_locked                number(21,3);
--v_processing            varchar2(1);
v_sortType              varchar2(4);    
--v_orderRecord           varchar2(400);
--v_amtRecord             varchar2(400);
--v_closeRecord           varchar2(400);
--v_priceRecord           varchar2(400);
--v_outOrderRecord        varchar2(400);
--v_outAmtRecord          varchar2(400);
--v_outCloseRecord        varchar2(400);
--v_outPriceRecord        varchar2(400);   
v_releaseMoney          number(21,2); 
v_releaseProfit         number(21,2); 

v_holdAmtBfr            number(21,2);
v_avgPriceBfr           number(21,2);
v_holdAmtAft            number(21,3);
v_avgPriceAft           number(21,2);
v_addupReurnMoneyBfr    number(21,2);
v_addupReturnProfitBfr  number(21,2);



v_addupReurnMoney       number(21,2); 
v_addupReturnProfit     number(21,2);
v_addupOpenMoney        number(21,2); 
v_addupCloseMoney       number(21,2);
v_addupOpenAmt          number(21,3); 
v_addupCloseAmt         number(21,3);

v_temp1                 number(21,0);  
v_temp2                 number(21,0);
v_tmpAmt                number(21,3);
v_curCloseAmt           number(21,3);
v_curReleaseProfit      number(21,3);
v_curReleaseMoney       number(21,3);

--v_value0                varchar2(30);
v_value1                varchar2(30);
v_value2                varchar2(30);
v_value3                varchar2(30);

v_strOrderPair          varchar2(500);
v_tempOrderId           number(20,0);
v_tempOpenAmt           number(21,3);
v_tempOpenPrice         number(21,2);
v_tempCloseAmt          number(21,3);
type cur is ref cursor;  
c_orderPair cur;
BEGIN
    
    SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;      
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    v_sts :='0001';
    /* 1.Order 정보가지오기*/
    BEGIN                                                                        
        SELECT COUNT(0) INTO v_recordCnt FROM Orders WHERE OrderId = in_orderId;
        IF v_recordCnt = 0 THEN                   
            out_errorCd := '0052';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
        
        
        SELECT ItemId, MarketId, O.BrrwId, PositionType, TradeType, OrderType, OrderPrice, OrderAmt, Sts, ExecutedType,PlaceType,B.UserId,OpenClose
                INTO v_itemId, v_marketId, v_brrwId, v_positionType,v_tradeType, v_orderType, v_orderPrice, v_orderAmt,v_sts ,v_executedType ,v_placeType,v_userId,v_openClose
            FROM Orders O ,BorrowInfo B
        WHERE OrderId = in_orderId
            AND O.BrrwId = B.BrrwId;
        SELECT TimeZone INTO v_timezone FROM market WHERE MarketId = v_marketId;   
        IF v_sts NOT IN ('0001','0005') THEN            /*'0001요청','0005Rollback'*/
            out_errorCd := '0059';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
    END;
     
    /* 2.거래가능시간확인*/
    BEGIN                                                                        
        /*고객요청Order*/
        v_recordCnt := 0;
        IF v_executedType ='0001' /*고객*/ OR v_executedType ='0003' /*이익스탑*/ OR v_executedType ='0004' /*손실스탑*/ THEN
            SELECT COUNT(MarketId),DECODE(COUNT(1),0,'N',MAX(LocalOpenTime)),DECODE(COUNT(1),0,'N',MAX(LocalCloseTime)) INTO v_recordCnt,v_marketOpenTime ,v_marketCloseTime 
                FROM TradingTimeInfo
            WHERE    MarketId = v_marketId
                AND to_date(to_char(v_localTime,'hh24:mi:ss'),'hh24:mi:ss') >= to_date(to_char(LocalOpenTime,'hh24:mi:ss'),'hh24:mi:ss')
                AND to_date(to_char(v_localTime,'hh24:mi:ss'),'hh24:mi:ss') <= to_date(to_char(LocalCloseTime,'hh24:mi:ss'),'hh24:mi:ss')               
                AND MgmtType = '0001';
                
            SELECT COUNT(MarketId) INTO v_recordCnt2 
                FROM TradingTimeInfo
            WHERE    MarketId = v_marketId
                AND to_date(to_char(v_localTime,'hh24:mi:ss'),'hh24:mi:ss') >= to_date(to_char(LocalOpenTime,'hh24:mi:ss'),'hh24:mi:ss')
                AND to_date(to_char(v_localTime,'hh24:mi:ss'),'hh24:mi:ss') <= to_date(to_char(LocalCloseTime,'hh24:mi:ss'),'hh24:mi:ss')                
                AND MgmtType = '0002';
                
            IF v_recordCnt = 0  OR (v_recordCnt = 1 AND v_recordCnt2 = 1) THEN
                out_errorCd := '0053';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
        /* ELSE 0002 장마감,0005 LossCut,0007 오버낫초과,0008 오버낫 마감,0010 관리자 */
        
        END IF;        
    END;
    
    
    /* 3.현제 거래제한조건으로 거래가능 여부 재 확인 */
    BEGIN                                                                        
    
        SELECT DECODE(COUNT(1),0,'N',MAX(Tradable))--,  DECODE(COUNT(1),0,'N',MAX(ShortSellAllow))
                INTO v_tradable--,v_itemShortSellAllow
            FROM TradeItems
        WHERE ItemId = v_itemId 
            AND MarketId = v_marketId;
            
        SELECT COUNT(ItemId) INTO v_recordCnt
            FROM LimitItems     
        WHERE ItemId = v_itemId 
            AND MarketId = v_marketId
            AND Tradedate = to_char(v_korTime,'YYYY/MM/DD');
            
        /*거래불가 시 거부처리*/        
        IF  v_tradable = 'N' OR v_recordCnt>0 THEN        
            sp_RejectOrder(in_orderId,'0004',null,out_errorCd,out_message);
            out_errorCd := '0054';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;            
        END IF; 
        
    END;
    
    /* 4.중복 채결 확인(OrderTrans 준제 여부)*/
    BEGIN                                                                        
        
        SELECT COUNT(OrderId) INTO v_recordCnt FROM OrderTrans WHERE Orderid = in_orderId AND TransType !='0004' /*Rollback*/;
        IF ( v_recordCnt>1) THEN       
            out_errorCd := '0055';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN; 
        END IF;
    END;
    
     /* 5.채결시간관 가격 도달여부 Check*/
    BEGIN                                                                        
        
        Select COUNT(ItemId),DECODE(COUNT(1),0,'N',MAX(Price)), DECODE(COUNT(1),0,NULL,MAX(UpdateTime)), DECODE(COUNT(1),0,NULL,MAX(PriceTime))
                INTO v_recordCnt,v_price,v_updateTime,v_priceTime
            FROM RealtimePrice
        WHERE ItemId = v_itemId 
            AND MarketId = v_marketId;
            
        IF (v_recordCnt = 0 ) THEN
            INSERT INTO RealtimePrice (ItemId, MarketId)
                VALUES (v_itemId,v_marketId);
            Commit;
            out_errorCd := '0056';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;  
        END IF;
        
        IF (v_priceTime IS NULL) THEN
            out_errorCd := '0056';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN; 
        END IF;
       
        /*가격 Update시간 1분 전 이며 거래 안 합니다*/
        usp_getOperationSetting('RealtimeDelay',v_realtimeDelay,v_value1,v_value2,v_value3); 
        
        IF v_executedType ='0001' /*고객*/ OR v_executedType ='0003' /*이익스탑*/ OR v_executedType ='0004' /*손실스탑*/ THEN
            IF ROUND(TO_NUMBER(v_korTime - v_priceTime) * 24 * 60 * 60) > TO_NUMBER(v_realtimeDelay) THEN
                out_errorCd := '0057';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;  
            END IF;
        ELSE
            /*Case trade in day 나제거래 경우market 만 적요 */
            v_temp1 := TO_NUMBER(v_localTime - to_date(to_char(v_localTime,'yyyyMMDD')||' '||v_marketCloseTime,'yyyyMMDD hh24:mi:ss')) * 24 * 60 /*장 마감 호 시간 */;
            v_temp2 := TO_NUMBER(v_priceTime - to_date(to_char(v_korTime,'yyyyMMDD')||' '||v_marketCloseTime,'yyyyMMDD hh24:mi:ss')) * 24 * 60 /*최신가격과  장니감 시간에 차이 */;
            IF v_temp1 > 50 /* 장 마감 */ THEN            
                out_errorCd := '0057';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            ELSIF v_temp1 > 0 AND ROUND(TO_NUMBER(v_korTime - v_updateTime) * 24 * 60 * 60) > v_realtimeDelay THEN  /*경신시간 지연*/
                out_errorCd := '0057';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            ELSIF v_temp1 > 0 AND abs(v_temp2) > 10 THEN  /*경신시간 지연*/
                out_errorCd := '0057';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN; 
            END IF;
        END IF;
        
               
    END;
    /*지정가 도달여부*/
    BEGIN  
        IF (v_orderType = '0001')/*지정가*/ THEN
            /*지정가 미달시 채결 안 합 */
            IF(v_tradeType='0001' AND v_orderPrice<v_price)/*매입 가격 미달*/  
                    OR (v_tradeType='0002' AND v_orderPrice>v_price)/*매수 가격 미달*/  THEN
                out_errorCd := '0058';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN; 
            END IF;        
        END IF; 
    END;
    
    /*실시간거래 조건 Check*/
     BEGIN  
        DBMS_OUTPUT.PUT_LINE('실시간거래 조건 Check');
        /*上一次成交交易太少*/
    END;
    
    /* 6.채결처리 Process*/
    BEGIN                        
           
        v_closed := 'N';
        v_releaseProfit := 0;
        v_tradeMoney := round(v_price * v_orderAmt,2);
        usp_getUserPlace(v_userId,  v_tradeTaxRate, v_tradeFeeRate , v_mgmtFeeRate, v_closeFeeRate, v_lossCutFeeRate , v_overNight, v_overNightFeeRate , v_overNightMaxDay, v_overNightFreeDay 
            , v_lossCutFree  , v_lossCutRateMin  , v_lostCutRateMax , v_shortSellAllow , v_bonusRate , v_bonusCntPerMonth , v_bonusActive , v_bonusMaxMoney , v_maxBrrwCnt,v_maxBrrwRate 
            , v_maxBrrwMoney , v_membershipDay , v_profitInvestActive  ,v_lossCutPcnt, v_vipTypeId , v_vipId , v_specialVip , out_errorCd , out_message);
      
       /*step 1 . update order status for processing*/
        SELECT OrderId INTO v_value1 FROM orders WHERE  OrderId = in_orderId
                    FOR UPDATE NOWAIT;        
        
        /*SETP2 GET OR RENEW Position INFO*/
        BEGIN
            SELECT COUNT(ItemId) 
                        INTO v_recordCnt 
                    FROM Positions 
                WHERE MarketId = v_marketId
                    AND ItemId = v_itemId
                    AND PositionType = v_positionType
                    AND BrrwId = v_brrwId
                    AND Closed = 'N'
                    AND PlaceType = v_placeType;
            
            v_sortType := null;
            IF v_recordCnt > 1 THEN
                ROLLBACK;
                out_errorCd := '0060';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);                
                RETURN;     
            ELSIF v_recordCnt = 1 THEN         
                
                /*Posiont 정보가지오기(준제여부 포함)*/
                SELECT PositionSeq ,Locked,HoldAmt,AddupReurnMoney, AddupReturnProfit,AvgPrice,AddupOpenAmt, AddupOpenMoney, AddupCloseAmt, AddupCloseMoney,ReturnType
                       INTO v_positionSeq ,v_locked,v_holdAmtBfr,v_addupReurnMoney,v_addupReturnProfit,v_avgPrice,v_addupOpenAmt, v_addupOpenMoney, v_addupCloseAmt, v_addupCloseMoney,v_returnType
                    FROM Positions 
                WHERE MarketId = v_marketId
                    AND ItemId = v_itemId
                    AND PositionType = v_positionType
                    AND BrrwId = v_brrwId
                    AND Closed = 'N'
                    AND PlaceType = v_placeType;
                    
                IF v_holdAmtBfr = v_locked AND v_orderAmt = v_locked THEN
                        v_closed := 'Y';
                END IF;
                
                IF v_locked < v_orderAmt THEN
                    ROLLBACK;
                    sp_RejectOrder(in_orderId,'0004',null,out_errorCd,out_message);
                    out_errorCd := '0043';
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);                    
                    RETURN;                             
                END IF;
                
                --v_holdAmtBfr :=0;
                v_avgPriceBfr:= v_avgPrice ;                
                --v_holdAmtAft := v_orderAmt;           
                --v_avgPriceAft  := v_price;        
                v_addupReurnMoneyBfr  := v_addupReurnMoney;  
                v_addupReturnProfitBfr  := v_addupReturnProfit;
                
            ELSIF v_recordCnt = 0 THEN
                v_holdAmtBfr :=0;
                v_avgPriceBfr:=0;                
                v_holdAmtAft := v_orderAmt;           
                v_avgPriceAft  := v_price;        
                v_addupReurnMoneyBfr  :=0;  
                v_addupReturnProfitBfr  :=0;
                
                SELECT SEQ_Positions.NEXTVAL INTO v_positionSeq FROM DUAL;
               
                
                /*v_sortType: Order Close시 원금반환 및 마진계산 방식 가지오기*/ 
                BEGIN    
                        
                    usp_getFundReturnType(v_userId,v_returnType);                    
                    /*v_sortType : Order Close 순서*/
                    IF v_returnType = '0001' THEN
                        v_sortType := '0001';
                    ELSIF v_returnType = '0002' THEN
                        v_sortType := '0002';
                    ELSIF v_positionType = '0001' AND v_returnType = '0003'/*미지운선*/ THEN
                        v_sortType := '0004'/*가격 역순*/;       
                    ELSIF v_positionType = '0002' AND v_returnType = '0003'/*미지운선*/ THEN
                        v_sortType := '0003'/*가격 정순*/;
                    ELSE
                        v_sortType := '0001';
                    END IF;                        
                END;               
            END IF;           
        END;
       
        
        
        /*SETP3 마진사용 할당*/
        BEGIN                                         
            /*평가마진 투자 경우 마진사용 할당*/    
            IF v_placeType = '0002' THEN
                /*동일대출로 보유 Position 숫*/    
                SELECT SUM(ItemId) INTO v_recordCnt2
                    FROM Positions 
                WHERE BrrwId = v_brrwId
                    AND Closed = 'N'
                    AND PlaceType = '0001';
                                    
                IF v_recordCnt2 > 0 THEN
                    v_marginPlace := round(v_tradeMoney/v_recordCnt2,2);
                    UPDATE Positions SET
                        AddMarginPlace = AddMarginPlace + v_marginPlace                
                    WHERE  BrrwId = v_brrwId
                        AND Closed = 'N'
                        AND PlaceType = '0001';
                END IF;
            END IF;
         END;
        
        
        /*Step4 수수료과 Bonus계산*/
        BEGIN
            
            usp_getOperationSetting('TradeFeeMode',v_tradeFeeMode,v_value1,v_value2,v_value3);    
            usp_getOperationSetting('TradeTaxMode',v_tradeTaxMode,v_value1,v_value2,v_value3);
            usp_getOperationSetting('MgmtFeeMode',v_mgmtFeeMode,v_value1,v_value2,v_value3);
            
            IF v_openClose = '0001' AND (v_tradeFeeMode = '0001' OR v_tradeFeeMode = '0003') THEN
                v_tradeFee :=  round(v_tradeMoney * v_tradeFeeRate / 100,2);
            ELSIF v_openClose = '0001' THEN
                v_tradeFee :=  0;
            ELSIF v_openClose = '0002' AND (v_tradeFeeMode = '0002' OR v_tradeFeeMode = '0003') THEN
                v_tradeFee :=  round(v_tradeMoney * v_tradeFeeRate / 100,2);
            ELSIF v_openClose = '0002' THEN
                v_tradeFee :=  0;
            END IF;
            
            IF v_openClose = '0001' AND (v_tradeTaxMode = '0001' OR v_tradeTaxMode = '0003') THEN
                v_tradeTax :=  round(v_tradeMoney * v_tradeTaxRate / 100,2);
            ELSIF v_openClose = '0001' THEN
                v_tradeTax :=  0;
            ELSIF v_openClose = '0002' AND (v_tradeTaxMode = '0002' OR v_tradeTaxMode = '0003') THEN
                v_tradeTax :=  round(v_tradeMoney * v_tradeTaxRate / 100,2);
            ELSIF v_openClose = '0002' THEN
                v_tradeTax :=  0;
            END IF;
            
            IF v_openClose = '0001' AND (v_mgmtFeeMode = '0001' OR v_mgmtFeeMode = '0003') THEN
                v_mgmtFee :=  round(v_tradeMoney * v_mgmtFeeRate / 100,2);
            ELSIF v_openClose = '0001' THEN
                v_mgmtFee :=  0;
            ELSIF v_openClose = '0002' AND (v_mgmtFeeMode = '0002' OR v_mgmtFeeMode = '0003') THEN
                v_mgmtFee :=  round(v_tradeMoney * v_mgmtFeeRate / 100,2);
            ELSIF v_openClose = '0002' THEN
                v_mgmtFee :=  0;
            END IF;
            
            v_closeFee := 0;
            v_lossCutFee := 0;
            IF v_openClose = '0002' THEN            
                IF v_executedType ='0002'  /*장마감*/ OR v_executedType ='0007'  /*오버낫초과*/ OR v_executedType ='0008'  /*오버낫 만기*/  OR  v_executedType ='0005'   /*LossCut*/  THEN
                    v_closeFee := round(v_tradeMoney * v_closeFeeRate / 100,2);
                END IF;   
                
                IF v_executedType ='0005'   /*LossCut*/  THEN
                    v_lossCutFee := round(v_tradeMoney * v_lossCutFeeRate / 100,2);
                END IF;
            END IF;           
           
             
            SELECT AddupBonus,AddupUsedBonus INTO v_addupBonus , v_addupUsedBonus
                FROM CustBalance
            WHERE UserId = v_userId;
            
            v_bonusMoney :=  0;
            IF (v_addupBonus - v_addupUsedBonus) > 0 THEN
                
                v_bonusTemp := v_addupBonus - v_addupUsedBonus;
                
                /*bonus로 거래수수료 대체*/
                IF v_bonusTemp > v_tradeFee AND  v_tradeFee > 0 THEN                
                    v_bonusMoney := v_bonusMoney + v_tradeFee;                
                    v_bonusTemp := v_bonusTemp - v_tradeFee;
                    v_tradeFee := 0;
                ELSIF(v_bonusTemp > 0 AND v_bonusTemp < v_tradeFee) THEN
                    v_bonusMoney := v_bonusMoney + v_bonusTemp;                
                    v_tradeFee := v_tradeFee - v_bonusTemp;   
                    v_bonusTemp := 0;
                END IF; 
                
                 /*bonus로 거래세 대체*/
                IF v_bonusTemp > v_tradeTax AND  v_tradeTax > 0 THEN                
                    v_bonusMoney := v_bonusMoney + v_tradeTax;                
                    v_bonusTemp := v_bonusTemp - v_tradeTax;
                    v_tradeTax := 0;
                ELSIF(v_bonusTemp > 0 AND v_bonusTemp < v_tradeTax) THEN
                    v_bonusMoney := v_bonusMoney + v_bonusTemp;                
                    v_tradeTax := v_tradeTax - v_bonusTemp;   
                    v_bonusTemp := 0;
                END IF; 
                
                 /*bonus로 취급수수료 대체*/
                IF v_bonusTemp > v_mgmtFeeMode AND  v_mgmtFeeMode > 0 THEN                
                    v_bonusMoney := v_bonusMoney + v_mgmtFeeMode;                
                    v_bonusTemp := v_bonusTemp - v_mgmtFeeMode;
                    v_mgmtFeeMode := 0;
                ELSIF(v_bonusTemp > 0 AND v_bonusTemp < v_mgmtFeeMode) THEN
                    v_bonusMoney := v_bonusMoney + v_bonusTemp;                
                    v_mgmtFeeMode := v_mgmtFeeMode - v_bonusTemp;   
                    v_bonusTemp := 0;
                END IF; 
                
                 /*bonus로 마감수수료 대체*/
                IF v_bonusTemp > v_closeFee AND  v_closeFee > 0 THEN                
                    v_bonusMoney := v_bonusMoney + v_closeFee;                
                    v_bonusTemp := v_bonusTemp - v_closeFee;
                    v_closeFee := 0;
                ELSIF(v_bonusTemp > 0 AND v_bonusTemp < v_closeFee) THEN
                    v_bonusMoney := v_bonusMoney + v_bonusTemp;                
                    v_closeFee := v_closeFee - v_bonusTemp;   
                    v_bonusTemp := 0;
                END IF; 
                
                 /*bonus로 거래세 대체*/
                IF v_bonusTemp > v_lossCutFee AND  v_lossCutFee > 0 THEN                
                    v_bonusMoney := v_bonusMoney + v_lossCutFee;                
                    v_bonusTemp := v_bonusTemp - v_lossCutFee;
                    v_lossCutFee := 0;
                ELSIF(v_bonusTemp > 0 AND v_bonusTemp < v_lossCutFee) THEN
                    v_bonusMoney := v_bonusMoney + v_bonusTemp;                
                    v_lossCutFee := v_lossCutFee - v_bonusTemp;   
                    v_bonusTemp := 0;
                END IF; 
            END IF;    
        END;
        
        /*SETP5  insert/update position*/    
        BEGIN 
            v_releaseProfit:=0; 
            v_releaseMoney := 0; 
            /*Insert Position*/            
            IF  v_recordCnt = 0 THEN  /* (최초)open order*/
                v_holdAmtBfr := 0; 
                
                /*Order 순서하기*/                
                --usp_sortOrderRecord(v_sortType ,'','' ,'' ,'' ,v_orderAmt ,v_price ,v_outOrderRecord,v_outAmtRecord ,v_outCloseRecord ,v_outPriceRecord );                
                INSERT INTO Positions  ( PositionSeq,BrrwId,   ItemId,   MarketId,   PositionType,   OpenOrderId,   OpenDate,OpenTime,
                            AvgPrice,   Closed,   HoldAmt,   AddupOpenAmt,   AddupOpenMoney,   AddupCloseAmt,   AddupCloseMoney,   AddupGuarantee,   AddMarginPlace,PlaceType ,ReturnType) 
                    VALUES   (v_positionSeq,    v_brrwId,  v_itemId,  v_marketId,  v_positionType,   in_orderId,  TO_CHAR(v_korTime, 'YYYY/MM/DD') , TO_CHAR(v_korTime, 'hh24:mi:ss'),
                            v_price,       'N',    v_orderAmt,  v_orderAmt,   v_tradeMoney,       0         ,          0       ,               0 ,           0     ,v_placeType,v_returnType);
                INSERT INTO OrderPairsInfo (OrderPairSeq,OrderId, PositionSeq,OpenAmt, OpenPrice,   CloseAmt)
                    VALUES(seq_OrderPairsInfo.nextval,in_orderId,v_positionSeq,v_orderAmt,v_price,0); 
 
            /*update Position*/
            ELSE  
                SELECT PositionSeq INTO v_value1 FROM Positions WHERE PositionSeq = v_positionSeq
                    FOR UPDATE NOWAIT;          
                /* (추가)open order*/
                IF v_openClose = '0001' THEN
                     /*Order 순서하기*/
                    --usp_sortOrderRecord(v_sortType ,v_orderRecord,v_amtRecord ,v_closeRecord ,v_priceRecord ,v_orderAmt ,v_price ,v_outOrderRecord,v_outAmtRecord ,v_outCloseRecord ,v_outPriceRecord );
                    
                    UPDATE Positions SET
                        AvgPrice = ROUND((AddupOpenMoney  + v_tradeMoney) / (AddupOpenAmt + v_orderAmt ),2) ,
                        HoldAmt = HoldAmt + v_orderAmt,
                        AddupOpenAmt = AddupOpenAmt + v_orderAmt,
                        AddupOpenMoney = AddupOpenMoney + v_tradeMoney
                        --OrderRecord = OrderRecord + v_outOrderRecord,
                        --AmtRecord = AmtRecord + v_outAmtRecord,
                        --CloseRecord = CloseRecord + v_outCloseRecord,
                        --PriceRecord = PriceRecord + v_outPriceRecord                        
                    WHERE PositionSeq = v_positionSeq ;
                    INSERT INTO OrderPairsInfo (OrderId, PositionSeq,OpenAmt, OpenPrice,   CloseAmt)
                        VALUES(in_orderId,v_positionSeq,v_orderAmt,v_price,0); 
                        
                
                                
                    v_holdAmtAft  := v_holdAmtBfr + v_orderAmt;           
                    v_avgPriceAft := ROUND((v_addupOpenMoney  + v_tradeMoney) / (v_addupOpenAmt + v_orderAmt ),2) ;        
                    
                
                /* close order*/
                ELSE
                
                   /*close Order의 반환담보금과마진  계산*/                     
                    BEGIN                     
                       
                        
                        
                        IF v_sortType = '0001'      /*선입Order 우선 처리*/THEN
                            v_strOrderPair := 'SELECT OrderId, OpenAmt, OpenPrice, CloseAmt  FROM OrderPairsInfo WHERE PositionSeq = '|| v_positionSeq ||' AND OpenAmt > CloseAmt ORDER BY ORDERID ASC';
                        ELSIF v_sortType = '0002'   /*후입Order 우선 처리*/THEN 
                            v_strOrderPair := 'SELECT  OrderId,OpenAmt, OpenPrice, CloseAmt FROM OrderPairsInfo WHERE PositionSeq = '|| v_positionSeq ||' AND OpenAmt > CloseAmt ORDER BY ORDERID DESC';
                        ELSIF v_sortType = '0003'   /*마진높은Order 우선 처리*/THEN
                            IF v_positionType = '0001' THEN
                                v_strOrderPair := 'SELECT  OrderId,OpenAmt, OpenPrice, CloseAmt FROM OrderPairsInfo WHERE PositionSeq = '|| v_positionSeq ||' AND OpenAmt > CloseAmt ORDER BY OPENPRICE DESC , ORDERID ASC';
                            ELSE
                                v_strOrderPair := 'SELECT  OrderId,OpenAmt, OpenPrice, CloseAmt FROM OrderPairsInfo WHERE PositionSeq = '|| v_positionSeq ||' AND OpenAmt > CloseAmt ORDER BY OPENPRICE ASC , ORDERID ASC';
                            END IF;
                        ELSE                        /*마진낮은Order우선 처리*/
                            IF v_positionType = '0001' THEN
                                v_strOrderPair := 'SELECT  OrderId,OpenAmt, OpenPrice, CloseAmt FROM OrderPairsInfo WHERE PositionSeq = '|| v_positionSeq ||' AND OpenAmt > CloseAmt ORDER BY OPENPRICE ASC , ORDERID ASC';
                            ELSE
                                v_strOrderPair := 'SELECT  OrderId,OpenAmt, OpenPrice, CloseAmt FROM OrderPairsInfo  WHERE PositionSeq = '|| v_positionSeq ||'AND OpenAmt > CloseAmt ORDER BY OPENPRICE DESC , ORDERID ASC';
                            END IF;
                        END IF;
                        
                        
                        v_releaseProfit:=0; 
                        v_releaseMoney := 0; 
                        v_tmpAmt := v_orderAmt;
                        v_tempOrderId := 0;
                        v_tempOpenAmt :=0;
                        v_tempOpenPrice :=0;
                        v_tempCloseAmt :=0;
                        OPEN c_orderPair FOR v_strOrderPair; 
                        LOOP
                            FETCH c_orderPair INTO v_tempOrderId,v_tempOpenAmt,v_tempOpenPrice,v_tempCloseAmt;    
                                  EXIT WHEN c_orderPair%notfound;
                                  EXIT WHEN v_tmpAmt <= 0;
                                IF v_tmpAmt > (v_tempOpenAmt - v_tempCloseAmt) THEN
                                    v_curCloseAmt := v_tempOpenAmt - v_tempCloseAmt;
                                    IF v_positionType = '0001' THEN  
                                        v_curReleaseProfit :=  ROUND(v_curCloseAmt * v_price - v_curCloseAmt * v_tempOpenPrice,2);                                        
                                    ELSE                                        
                                        v_curReleaseProfit :=  ROUND(v_curCloseAmt * v_tempOpenPrice - v_curCloseAmt * v_price,2);
                                    END IF;
                                    
                                    v_releaseProfit := v_releaseProfit + v_curReleaseProfit ;
                                    v_tmpAmt := v_tmpAmt - v_curCloseAmt;  
                                    v_tempCloseAmt :=  v_tempOpenAmt;                                                                    
                                    
                                    IF v_placeType = '0001' THEN
                                        v_curReleaseMoney := ROUND(v_curCloseAmt * v_tempOpenPrice,2);
                                    ELSE
                                        v_curReleaseMoney := 0;
                                    END IF;
                                    
                                    v_releaseMoney := v_releaseMoney + v_curReleaseMoney;
                                    SELECT PositionSeq INTO v_value1 FROM OrderPairsInfo WHERE PositionSeq  = v_positionSeq AND OrderId= v_tempOrderId
                                             FOR UPDATE NOWAIT;
                                    UPDATE OrderPairsInfo SET CloseAmt = v_tempCloseAmt WHERE PositionSeq  = v_positionSeq AND OrderId= v_tempOrderId; 
                                    
                                    INSERT INTO OrderPairsDetail (PositionSeq, OpenOrderId, CloseOrderId, Amt, OpenPrice, ClosePrice, ReurnMoney, ReturnProfit, UpdateDate)
                                        VALUES(v_positionSeq,v_tempOrderId,in_orderId,v_curCloseAmt,v_tempOpenPrice,v_price,v_curReleaseMoney,v_curReleaseProfit,v_korTime);    
                                    
                                ELSIF v_tmpAmt <=  (v_tempOpenAmt - v_tempCloseAmt)    THEN
                                    v_curCloseAmt :=v_tmpAmt;
                                    IF v_positionType = '0001' THEN
                                        v_curReleaseProfit :=  ROUND(v_curCloseAmt * v_price - v_curCloseAmt * v_tempOpenPrice,2);
                                    ELSE
                                        v_curReleaseProfit := ROUND(v_curCloseAmt * v_tempOpenPrice - v_curCloseAmt * v_price,2);
                                    END IF;
                                    v_releaseProfit := v_releaseProfit + v_curReleaseProfit ;
                                    v_tmpAmt := 0;
                                    v_tempCloseAmt := v_tempCloseAmt + v_curCloseAmt;                                    
                                    
                                    
                                    IF v_placeType = '0001' THEN
                                        v_curReleaseMoney := ROUND(v_curCloseAmt * v_tempOpenPrice,2);
                                    ELSE
                                        v_curReleaseMoney :=  0;
                                    END IF;
                                    v_releaseMoney := v_releaseMoney + v_curReleaseMoney;
                                    SELECT PositionSeq INTO v_value1 FROM OrderPairsInfo WHERE PositionSeq  = v_positionSeq AND OrderId= v_tempOrderId
                                             FOR UPDATE NOWAIT;
                                    UPDATE OrderPairsInfo SET CloseAmt = v_tempCloseAmt WHERE PositionSeq  = v_positionSeq AND OrderId= v_tempOrderId;
                                    INSERT INTO OrderPairsDetail (PositionSeq, OpenOrderId, CloseOrderId, Amt, OpenPrice, ClosePrice, ReurnMoney, ReturnProfit, UpdateDate)
                                        VALUES(v_positionSeq,v_tempOrderId,in_orderId,v_curCloseAmt,v_tempOpenPrice,v_price,v_curReleaseMoney,v_curReleaseProfit,v_korTime);  
                                END IF;     
                                      
                        end loop;   
                        close c_orderPair;                         
                        
                    END ;
                    v_holdAmtAft  := v_holdAmtBfr - v_orderAmt;           
                    v_avgPriceAft := v_avgPriceBfr ;
                    
                    UPDATE Positions SET                   
                        HoldAmt = HoldAmt - v_orderAmt,
                        Locked = Locked - v_orderAmt,
                        Closed = v_closed,
                        --CloseRecord = v_closeRecord,
                        AddupCloseAmt = AddupCloseAmt + v_orderAmt,
                        AddupCloseMoney = AddupCloseMoney + v_tradeMoney,
                        AddupReurnMoney = AddupReurnMoney + v_releaseMoney,
                        AddupReturnProfit = AddupReturnProfit + v_releaseProfit
                    WHERE PositionSeq = v_positionSeq ;                
                    
                END IF;
                    
            END IF;
        END;
        
        
        /*SEP6 Insert ordertrans and Executed detial*/
        BEGIN
            SELECT SEQ_OrderTrans.NEXTVAL INTO   v_orderTransId from dual;                    
            INSERT INTO OrderTrans (OrderTransId,Orderid, TransDate, TransType)
                VALUES (v_orderTransId,in_orderId,v_korTime,'0002');
        
        
        
            SELECT SEQ_OrderExecuted.NEXTVAL INTO v_orderExcutSeq FROM DUAL;
            INSERT INTO OrderExecuted (OrderExcutSeq, PositionSeq,  OrderId,     BrrwId, ExecuteDate, ExecutePrice, ExcecuteAmt, TradeTax, TradeFee, MgmtFee,  CloseFee, LossCutFee,   UsedBonus , PlaceType, HoldAmtBfr, AvgPriceBfr,              HoldAmtAft, AvgPriceAft, AddupReurnMoneyBfr, AddupReturnProfitBfr,    Rollbackable, CloseAll, ReurnMoney, ReturnProfit )
                                VALUES(v_orderExcutSeq,v_positionSeq,in_orderId,v_brrwId,v_korTime , v_price,v_orderAmt        ,v_tradeTax,v_tradeFee,v_mgmtFee,v_closeFee,v_lossCutFee,v_bonusMoney,v_placeType,v_holdAmtBfr,v_avgPriceBfr,v_holdAmtAft,v_avgPriceAft,v_addupReurnMoneyBfr,v_addupReturnProfitBfr,'Y',v_closed,v_releaseMoney,v_releaseProfit);
        END;
        
        SELECT BrrwId INTO v_value1 FROM BorrowInfo WHERE BrrwId = v_brrwId
                    FOR UPDATE NOWAIT;
        /* Open Order*/ 
        IF v_openClose = '0001' AND v_placeType = '0001' THEN
            UPDATE BorrowInfo SET
                Locked = Locked - v_tradeMoney,
                ChangeMoney = ChangeMoney - v_tradeMoney,                
                AddupLossCutFee =AddupLossCutFee + v_lossCutFee,
                AddupCloseFee = AddupCloseFee +v_closeFee,
                AddupMgmtFee = AddupMgmtFee + v_mgmtFee,
                AddupTradeFee = AddupTradeFee +v_tradeFee,
                AddupTradeTax = AddupTradeTax + v_tradeTax,
                AddupUsedBonus = AddupUsedBonus + v_bonusMoney
            WHERE BrrwId = v_brrwId;
        ELSIF v_openClose = '0001' THEN
            UPDATE BorrowInfo SET               
                AddupLossCutFee =AddupLossCutFee + v_lossCutFee,
                AddupCloseFee = AddupCloseFee +v_closeFee,
                AddupMgmtFee = AddupMgmtFee + v_mgmtFee,
                AddupTradeFee = AddupTradeFee +v_tradeFee,
                AddupTradeTax = AddupTradeTax + v_tradeTax,
                AddupUsedBonus = AddupUsedBonus + v_bonusMoney                
            WHERE BrrwId = v_brrwId;
        
        /* Close Order*/
        ELSIF v_openClose = '0002' AND v_placeType = '0001' THEN
            UPDATE BorrowInfo SET                
                ChangeMoney = ChangeMoney + v_releaseMoney + v_releaseProfit,
                AddupLossCutFee =AddupLossCutFee + v_lossCutFee,
                AddupCloseFee = AddupCloseFee +v_closeFee,
                AddupMgmtFee = AddupMgmtFee + v_mgmtFee,
                AddupTradeFee = AddupTradeFee +v_tradeFee,
                AddupTradeTax = AddupTradeTax + v_tradeTax,
                AddupUsedBonus = AddupUsedBonus + v_bonusMoney,
                AddupCloseProfit = AddupCloseProfit  + v_releaseProfit
            WHERE BrrwId = v_brrwId;        
        ELSIF v_openClose = '0002' THEN
            UPDATE BorrowInfo SET                
                ChangeMoney = ChangeMoney + v_releaseProfit,
                AddupLossCutFee =AddupLossCutFee + v_lossCutFee,
                AddupCloseFee = AddupCloseFee +v_closeFee,
                AddupMgmtFee = AddupMgmtFee + v_mgmtFee,
                AddupTradeFee = AddupTradeFee +v_tradeFee,
                AddupTradeTax = AddupTradeTax + v_tradeTax,
                AddupUsedBonus = AddupUsedBonus + v_bonusMoney,
                AddupCloseProfit = AddupCloseProfit  + v_releaseProfit
            WHERE BrrwId = v_brrwId;         
        END IF;
       
        SELECT UserId INTO v_value1 FROM CustBalance WHERE UserId = v_userId
                    FOR UPDATE NOWAIT;
        /*update addupTradeMoney*/        
        UPDATE CustBalance SET           
            AddupCloseProfit = AddupCloseProfit + v_releaseProfit , 
            AddupTradeMoney = AddupTradeMoney + v_tradeMoney,         
            AddupBonus = AddupBonus - v_bonusMoney, 
            AddupUsedBonus = AddupBonus + v_bonusMoney, 
            AddupLossCutFee = AddupLossCutFee + v_lossCutFee, 
            AddupCloseFee = AddupCloseFee + v_closeFee, 
            AddupMgmtFee = AddupMgmtFee + v_mgmtFee, 
            AddupTradeFee = AddupTradeFee + v_tradeFee, 
            AddupTradeTax = AddupTradeTax + v_tradeTax           
        WHERE
            UserId = v_userId;
                            
        SELECT OrderId INTO v_value1 FROM orders WHERE  OrderId = in_orderId
                    FOR UPDATE NOWAIT;    
        UPDATE orders SET Sts = '0002' WHERE OrderId = in_orderId;           
        COMMIT;        

    END;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_ExecuteOrder 실행 시 에러발생');
       
END sp_ExecuteOrder;

create or replace PROCEDURE          sp_PlaceOrder 
(
        in_userId                   in    varchar2,
        in_itemId                   in    varchar2,
        in_marketId                 in    varchar2,
        in_brrwId                   in    number,
        in_positionType             in    varchar2,
        in_tradeType                in    varchar2,
        in_orderType                in    varchar2,
        in_orderPrice               in    number,
        in_orderAmt                 in    number,
        in_executedType             in    varchar2,        
        in_placeType                in    varchar2,
        in_memo                     in    varchar2,
        out_errorCd                 OUT     varchar2 ,
        out_message                 OUT     varchar2
)as
    v_korTime                       date;
    v_localTime                     date;
    v_userActive                    varchar2(1);
    v_userType                      varchar2(4);
    v_orderId                       number(20,0);    
    v_brrwRate                      number(20,4);    
    v_usableForTrade                number(21,2);
    v_usableMarginPlace             number(21,2);        
    v_positionSeq                   number(20,0);
    v_recordCnt                     number(20,0);
    v_shortSellAllow                varchar2(10);
    v_marketShortSellAllow          varchar2(1);
    v_itemShortSellAllow            varchar2(1);
    v_vipShortSellAllow             varchar2(1);    
    v_tradable                      varchar2(1);
    v_timezone                      number(5,0);    
    v_minBrrwRateOfMarket           number(5,0);
    v_maxBrrwRateOfMarket           number(5,0);
    v_openClose                     varchar2(4);    
    v_tradebleAmt                   number(21,3);
    v_value1                        varchar(30);
    v_value2                        varchar(30);
    v_value3                        varchar(30);
/******************************************************************************
   NAME:       sp_PlaceOrder
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/14   Administrator       1. Created this procedure.

   NOTES:TEST SQL
  set serveroutput on;扫恶手动阀第三方
Declare
        in_userId                   varchar2(20);
        in_itemId                   varchar2(30);
        in_marketId                 varchar2(30);
        in_brrwId                   number(20,0);
        in_positionType             varchar2(4);
        in_tradeType                varchar2(4);
        in_orderType                varchar2(4);
        in_orderPrice               number(21,2);
        in_orderAmt                 number(21,3);
        in_executedType             varchar2(4);        
        in_placeType                varchar2(4);
        in_memo                     varchar2(200);
        out_errorCd                 varchar2(4);
        out_message                 varchar2(200);
begin
in_userId := 'OrgVip01';
sp_PlaceOrder(in_userId,in_itemId,in_marketId,in_brrwId,in_positionType,in_tradeType,in_orderType,in_orderPrice,in_orderAmt,in_executedType,in_placeType,in_memo,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE(out_errorCd || out_message);
end;
        

   Automatically available Auto Replace Keywords:
      Object Name:     sp_PlaceOrder
      Sysdate:         2019/03/14
      Date and Time:   2019/03/14, 오후 2:13:51, and 2019/03/14 오후 2:13:51
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN

    usp_getOperationSetting('ShortSellAllow',v_shortSellAllow,v_value1,v_value2,v_value3);   
    SELECT DECODE(COUNT(1),0,99,MAX(TimeZone)) INTO v_timezone FROM market WHERE MarketId = in_marketId;
    IF v_timezone = 99 THEN
        out_errorCd := '0023';
        out_message := spr_GetErrorKRName(out_errorCd);                  
        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
        RETURN;
    END IF;
    SELECT spr_getLocalTime(v_timezone) INTO v_localTime FROM DUAL;     
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
    /*0. Parameter check*/
    BEGIN                        
        IF in_tradeType NOT IN ('0001'/*지정가*/,'0002'/*시장가*/) THEN
            out_errorCd := '0024';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;            
        END IF;         
        
        IF in_orderType NOT IN ('0001'/*매수*/,'0002'/*매도*/) THEN
            out_errorCd := '0025';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
        
        IF in_positionType NOT IN ('0001'/*다매매*/,'0002'/*공매매*/) THEN
            out_errorCd := '0026';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF; 
        
        IF in_placeType NOT IN ('0001'/*대출거래*/,'0002'/*마진*/,'0003'/*중개*/) THEN            /*0001 대출, 0002 마진,0003 중개*/
            out_errorCd := '0027';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
        
        IF in_orderPrice IS NULL  OR in_orderPrice <= 0 THEN                                                    /*주문가격 Check*/
            out_errorCd := '0028';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;    
        
        IF in_orderAmt IS NULL OR in_orderAmt <= 0 THEN                                                    /*주문량 Check*/
            out_errorCd := '0029';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;    
        
        IF in_positionType = '0001' AND in_tradeType = ' 0001' THEN                                         /*매수(다) Open */   
            v_openClose := '0001';                                                                    
        ELSIF in_positionType = '0002' AND in_tradeType = ' 0002' THEN                                        /*매도(공) Open */
            v_openClose := '0001';
        ELSIF in_positionType = '0001' AND in_tradeType = ' 0002' THEN                                        /*매도(다) Close */
            v_openClose := '0002';
        ELSIF in_positionType = '0002' AND in_tradeType = ' 0001' THEN                                        /*매수(공) Close */
            v_openClose := '0002';
        END IF;
    END;
    
  
    /*1.고객유효성 점검*/ 
    BEGIN                         
        usp_checkUserActive(in_userId,v_userActive,v_userType);
        IF v_userActive = 'N' THEN                                                         
            out_errorCd := '0002';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
        
        /*
        SELECT DECODE(COUNT(1),0,0,COUNT(1)) INTO v_recordCnt FROM BorrowInfo WHERE BrrwId = in_brrwId AND UserId = in_userId ;
        IF v_recordCnt = 0 THEN                                                         
            out_errorCd := '0059';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
        */       
    END;
    
    /*2.Order가능시간확인*/
    BEGIN                        
        /*고객요청Order*/
        v_recordCnt := 0;
        /*IF in_executedType ='0001' /고객/ OR in_executedType ='0003' /이익스탑/ OR in_executedType ='0004' /손실스탑/ THEN */
        IF in_executedType IN ('0001' /*고객*/ , '0003' /*이익스탑*/ , '0004' /*손실스탑*/) THEN
            SELECT COUNT(MarketId) INTO v_recordCnt 
                FROM TradingTimeInfo 
            WHERE    MarketId = in_marketId
                AND to_date(to_char(v_localTime,'hh24:mi'),'hh24:mi') >= to_date(to_char(LocalOpenTime,'hh24:mi'),'hh24:mi')
                AND to_date(to_char(v_localTime,'hh24:mi'),'hh24:mi') <= to_date(to_char(LocalCloseTime,'hh24:mi'),'hh24:mi')                
                AND MgmtType = '0001';                            /*거래시간 내에 만 Order 생성*/
            IF(v_recordCnt = 0 ) THEN
                out_errorCd := '0030';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
        /* ELSE 0002 장마감,0005 LossCut,0007 오버낫초과,0008 오버낫 마감,0010 관리자 */
        
        END IF;
        /*시스템자동Order는 시간 제한 없음*/       
    END;
    
    /*3.OpenOrder의 거래가능 여부 확인 */ 
    BEGIN
    
        /*3.1 (Open)Market 조건 CHECK*/
        BEGIN
            /*(거래관리) Market 거래가능 여부와 공매매 가능여부 정보 가지오기*/                       
            SELECT COUNT(MarketId) ,DECODE(COUNT(1),0,NULL,MAX(ShortSellAllow))                                                             
                    INTO v_recordCnt,v_marketShortSellAllow
                FROM Market
            WHERE MarketId = in_marketId AND Active = 'Y' ;
                
            IF  v_recordCnt = 0  THEN
                out_errorCd := '0031';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;            
        END;
        
        /*3.2(Open)거래가능 중목확인*/    
        BEGIN                        
            /*휴장정보확인*/
            SELECT COUNT(MarketId) INTO v_recordCnt                                                                    
                FROM MarketHoliday     
            WHERE MarketId = in_marketId
                AND to_char(v_korTime,'YYYYMMDD') = Holiday ;
            IF  v_recordCnt > 0  THEN
                out_errorCd := '0033';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
            
            /*(관리)Item 거래가능 여부와 공매매 가능여부 정보 가지오기*/
            SELECT DECODE(COUNT(1),0,NULL,MAX(Tradable)), DECODE(COUNT(1),0,NULL,MAX(ShortSellAllow))                                                                    
                    INTO v_tradable,v_itemShortSellAllow
                FROM TradeItems
            WHERE ItemId = in_itemId 
                AND MarketId = in_marketId;
            IF v_tradable IS NULL OR v_tradable = 'N' THEN
                out_errorCd := '0032';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
                
           /*(제한)Item 거래 제한 여부 정보 가지오기*/                    
            SELECT COUNT(ItemId) INTO v_recordCnt                                                                    /*(제한)Item 거래 제한 여부 정보 가지오기*/
                FROM LimitItems     
            WHERE ItemId = in_itemId 
                AND MarketId = in_marketId
                AND TO_CHAR(v_korTime,'YYYY/MM/DD') = TradeDate ; 

            IF  v_recordCnt > 0  THEN
                out_errorCd := '0034';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
        END;
    END;
    
    /*4 Open/Close Order의 상세 내용확인*/
    BEGIN
        /* OpenOrder Check*/                
        IF v_openClose = '0001' THEN        
            
            /*(Open)거래소Market별 대출범위초과 여부확인*/
            BEGIN                        
                
                SELECT DECODE(COUNT(1),0,0,MAX(BrrwRate)) INTO v_brrwRate FROM BorrowInfo WHERE brrwId = in_brrwId;
                IF v_brrwRate = 0 THEN                                                         
                    out_errorCd := '0035';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN; 
                END IF;
                
                /*Market별 거래가능대출율 정보 가지오기*/
                SELECT DECODE(COUNT(1),0,NULL,MAX(OptSubValue1)),DECODE(COUNT(1),0,NULL,MAX(OptSubValue2))
                        INTO v_minBrrwRateOfMarket, v_maxBrrwRateOfMarket
                    FROM OptSetting 
                WHERE OptKey = 'MarketMinBrrwRate' AND OptMainValue = in_marketId;
                            
                IF v_minBrrwRateOfMarket IS NOT NULL AND v_maxBrrwRateOfMarket IS NOT NULL THEN
                    IF( v_brrwRate < v_minBrrwRateOfMarket OR v_brrwRate > v_maxBrrwRateOfMarket ) THEN                    /*Market허용 대출율 점검*/
                        out_errorCd := '0036';                                                          
                        out_message := spr_GetErrorKRName(out_errorCd);                  
                        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                        ROLLBACK;
                        RETURN; 
                    END IF;  
                END IF;
            END;
           
            /*(Open)공매가능여부 확인*/
            BEGIN                        
                
                IF in_positionType = '0002' THEN
                    
                    IF(v_shortSellAllow IS NULL OR v_shortSellAllow <>'Y') THEN
                        out_errorCd := '0037';                                                          
                        out_message := spr_GetErrorKRName(out_errorCd);                  
                        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                        ROLLBACK;
                        RETURN;
                    END IF;
                    
                    IF(v_marketShortSellAllow IS NULL OR v_marketShortSellAllow <>'Y') THEN
                        out_errorCd := '0038';                                                          
                        out_message := spr_GetErrorKRName(out_errorCd);                  
                        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                        ROLLBACK;
                        RETURN;
                    END IF;            
                   
                    IF v_itemShortSellAllow IS NULL OR v_itemShortSellAllow <>'Y' THEN
                        out_errorCd := '0039';                                                          
                        out_message := spr_GetErrorKRName(out_errorCd);                  
                        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                        ROLLBACK;
                        RETURN;
                    END IF;
                  
                    SELECT DECODE(COUNT(1),0,NULL,MAX(vip.ShortSellAllow)) INTO v_vipShortSellAllow /*max 함수로 Y를 우선 가지오기*/
                        FROM VipInfo vip ,CustVip cust
                    WHERE cust.UserId = in_userId 
                        AND vip.VipId =  cust.VipId;
                    
                    IF(v_vipShortSellAllow IS NULL OR v_vipShortSellAllow <> 'Y') THEN
                        out_errorCd := '0040';                                                          
                        out_message := spr_GetErrorKRName(out_errorCd);                  
                        DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                        ROLLBACK;
                        RETURN;
                    END IF;            
                    
                END IF;
            END;
            
            /*(Open)가용금액 확인 */ 
            BEGIN
                usp_getBrrwUsableForTrade(in_brrwId,v_usableForTrade,v_usableMarginPlace,out_errorCd,out_message);            /*거래가능 금액 정보 가지오기*/
                IF out_errorCd != '0000' THEN
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;
                
                IF(in_placeType = '0001' AND in_orderPrice * in_orderAmt > v_usableForTrade * 1.05) THEN
                    out_errorCd := '0041';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                ELSIF(in_placeType = '0002' AND in_orderPrice * in_orderAmt > v_usableMarginPlace * 1.2) THEN
                    out_errorCd := '0042';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;
            END;
        
        /*CloseOrder Check*/      
        ELSE
            
            /*(Close)Position 재고량 확인 */
        
            SELECT COUNT(1),DECODE(COUNT(1),0,0,MAX(HoldAmt - Locked)),DECODE(COUNT(1),0,0,MAX(PositionSeq))
                    INTO v_recordCnt,v_tradebleAmt,v_positionSeq
                FROM Positions
            WHERE BrrwId = in_brrwId 
                AND MarketId= in_marketId 
                AND ItemId= in_itemId                
                AND PositionType= in_positionType
                AND PlaceType= in_placeType
                AND Closed = 'N';
                               
                IF (v_recordCnt = 0 ) THEN
                    out_errorCd := '0050';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                ELSIF (v_recordCnt > 1 ) THEN
                    out_errorCd := '0051';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;
                
                IF (in_orderAmt > v_tradebleAmt) THEN
                    out_errorCd := '0043';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;
         
        END IF;
    END;
    
    /*5.주문Order등록 Process*/   
    BEGIN                        
       /*5.1 주문Order등록*/     
        BEGIN                    
            
            SELECT SEQ_ORDERS.NEXTVAL INTO v_orderId FROM dual;
            INSERT INTO Orders (OrderId,UserId,ItemId, MarketId,OpenClose, BrrwId, PositionType, OrderTime, TradeType, OrderType, OrderPrice, OrderAmt,Sts, ExecutedType, PlaceType,Memo)
            VALUES (v_orderId,in_userId,in_itemId,in_marketId,v_openClose,in_brrwId,in_positionType,v_korTime,in_tradeType, in_orderType, in_orderPrice, in_orderAmt,'0001',in_executedType,in_placeType,in_memo);
            /*select t_error ,in_itemId,in_marketId,in_brrwId,in_positionType,v_korTime,in_tradeType, in_orderType, in_orderPrice, in_orderAmt,'0001',in_executedType,in_placeType,in_memo,'N' from dual;  */
            
        END;        
    
      
        /*5.2 고객 대출정부Update*/
        BEGIN                    
            IF  v_openClose = '0001' AND in_placeType = '0001' THEN
            
                SELECT BrrwId INTO v_value1 FROM BorrowInfo WHERE BrrwId = in_brrwId
                    FOR UPDATE WAIT 2;
                    
                UPDATE BorrowInfo SET
                    LOCKED = LOCKED + ROUND(in_orderPrice*in_orderAmt,2)                
                WHERE BrrwId = in_brrwId;
            ELSIF v_openClose = '0002' THEN
                SELECT PositionSeq INTO v_value1 FROM Positions WHERE PositionSeq = v_positionSeq
                    FOR UPDATE WAIT 2;
                                      
                UPDATE Positions SET
                    LOCKED = LOCKED + ROUND(in_orderAmt,3)                
                WHERE  PositionSeq = v_positionSeq; 
            END IF;
        END; 
        COMMIT;
        
        /*5.3 실시간 조회필요 RealtimePrice에 등록*/        
        BEGIN                    
            v_recordCnt := 0;
            SELECT COUNT(ItemId) INTO v_recordCnt FROM RealtimePrice 
                WHERE ItemId = in_itemId AND MarketId = in_marketId;
            IF (v_recordCnt = 0 ) THEN
                INSERT INTO RealtimePrice (ItemId, MarketId)
                VALUES (in_itemId,in_marketId);
            END IF;
        END;       
        COMMIT; 
         
       
    END;
    
   EXCEPTION
    WHEN NO_DATA_FOUND THEN 
       ROLLBACK;   
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_PlaceOrder 실행 시 에러발생');
       
END sp_PlaceOrder;

create or replace PROCEDURE          sp_RejectDeposit(
in_depositSeq   IN      number,
in_manangerId   IN      varchar2,
in_memo         IN      varchar2,    
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2)

IS
v_korTime date;
v_recordcount number(10,0);
v_sts varchar2(4);
/******************************************************************************
   NAME:       sp_RejectDeposit
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/08   Administrator       1. Created this procedure.

   NOTES:SQL TEST
   
   set serveroutput on;
Declare
in_depositSeq       number(20,0);
in_manangerId       varchar2(20);
in_memo             varchar2(200);
out_errorCd         varchar2(200);
out_message         varchar2(200);

begin

in_depositSeq := 11;
in_manangerId :='ShrubAdmin';

in_memo :='';


sp_RejectDeposit(in_depositSeq,in_manangerId ,in_memo,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE('out_errorCd：' ||out_errorCd || ' out_message：' ||out_message);
end;

select * from custbalance;

select a.* from DepositWithDrawInfo a;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_RejectDeposit
      Sysdate:         2019/03/08
      Date and Time:   2019/03/08, 오후 12:42:59, and 2019/03/08 오후 12:42:59
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
    BEGIN                /*1 관리자 계정 정상여부를 확인 합니다*/    
        SELECT COUNT(UserId) into v_recordcount
            FROM UserInfo
        WHERE UserId = in_manangerId and UserType in ('0002','0010') and Active = 'Y';
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0009';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 입금처리 불가 합니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            return;
        END IF;
    END;
    
    BEGIN                /*2 요청금액과 승인금액 일치여부 확인합니다  */
        SELECT COUNT(1),DECODE(COUNT(1),0,NULL,MAX(Sts)) INTO v_recordcount,v_sts                
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq;
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0012';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            return;            
        END IF;        
       
    
        IF v_sts IS NULL OR v_sts <> '0001'  THEN
            out_errorCd := '0013';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            return;
        END IF;        
       
    END;
    
    BEGIN                 /*3.입금 거부처리*/
       
        SELECT Sts  INTO v_sts             
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq FOR UPDATE WAIT 2;
        
        UPDATE DepositWithDrawInfo SET          
              ExecuteTime = v_korTime, 
              ExecuteMoney = 0, 
              Sts = '0003',           
              MgmtMemo = in_memo, 
              MgmtUserId = in_manangerId
        WHERE
          AccessSeq = in_depositSeq;
       
    END;
    COMMIT;
    out_errorCd := '0000';
    out_message := spr_GetErrorKRName(out_errorCd); 
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
       ROLLBACK;       
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || ' ORA' || sqlcode || ' Message' || sqlerrm;
       DBMS_OUTPUT.PUT_LINE('sp_RejectDeposit 실행 시 에러발생');
END sp_RejectDeposit;

create or replace PROCEDURE          sp_RejectOrder
(
in_orderId      in      number,
in_transCmd     in      varchar2,
in_userId       in      varchar2,
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2)
AS
/******************************************************************************
   NAME:       sp_RejectOrder
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/15   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_RejectOrder
      Sysdate:         2019/03/15
      Date and Time:   2019/03/15, 오전 8:27:33, and 2019/03/15 오전 8:27:33
      Username:        Administrator (in TOAD Options, Procedure Editor)
      Table Name:       (in the "New PL/SQL Object" dialog)

******************************************************************************/
    v_korTime               date;    
    v_recordCnt             number(10,0);
    v_userActive            varchar2(1);
    v_userType              varchar2(4);
    v_brrwId                number(20,0);
    v_positionSeq           number(20,0);
    v_userId                varchar2(20);
    v_itemId                varchar2(10);
    v_marketId              varchar2(4);
    v_orderPrice            number(21,2);
    v_orderAmt              number(21,3);
    v_orderSts              varchar2(4);
    v_executedType          varchar2(4);
    v_positionType          varchar2(4);
    v_placeType             varchar2(4);
    v_tradeType             varchar2(4);
    v_openClose             varchar2(4);
    v_value1                varchar(30);
BEGIN
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
    /*1. Order 처리 Commond 확인*/
    BEGIN                    
        IF(in_transCmd <> '0003' AND in_transCmd <> '0004') THEN
            out_errorCd := '0044';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
    END;  
    
    /*2. Order 정보 가지오기*/
    BEGIN                            
        SELECT COUNT(1) INTO v_recordCnt FROM Orders WHERE Orderid = in_orderId;
         IF(v_recordCnt = 0 ) THEN
            out_errorCd := '0045';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
        
        
        SELECT UserId,BrrwId,OrderPrice,OrderAmt,MarketId,ItemId ,Sts ,ExecutedType,PositionType,TradeType,PlaceType,OpenClose
                INTO v_userId,v_brrwId,v_orderPrice,v_orderAmt ,v_marketId,v_itemId,v_orderSts ,v_executedType,v_positionType,v_tradeType,v_placeType,v_openClose
        FROM Orders 
            WHERE Orderid = in_orderId;       
    END;
    
    /*3. Order 정보 가지오기*/
    BEGIN
        /* Order상태확인*/                          
        IF ( v_orderSts IS NULL  OR v_orderSts <> '0001' ) THEN       
            out_errorCd := '0046';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;        
        END IF;
    END;
    
    /*4. 고객취소 Order 점검*/
    BEGIN  
        
        IF(in_transCmd = '0003') THEN
        
            /*고객등록 Order만 취소 처리가능*/
            IF v_executedType <>'0001' THEN                
                out_errorCd := '0047';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                RETURN;
            END IF;
            
            usp_checkUserActive(in_userId,v_userActive,v_userType);
            IF v_userActive = 'N' THEN                                                         
                out_errorCd := '0002';                                                          
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                ROLLBACK;
                RETURN; 
            END IF;
            IF v_userType IN ('0001'/*고객*/,'0003'/*Temp*/,'0009'/*Test*/) AND in_userId != v_userId THEN
                out_errorCd := '0048';                                                          
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                ROLLBACK;
                RETURN; 
            END IF; 
            
        END IF;
    END;
  
    /*5. 기분 OrderTrans 준제 여부확인*/
    BEGIN                    
        SELECT COUNT(OrderId) INTO v_recordCnt FROM OrderTrans WHERE Orderid = in_orderId;
        IF (v_recordCnt > 0 ) THEN       
            out_errorCd := '0049';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;         
        END IF;
    END;
    
    /*6.주문Order 취소/거부 Process*/
    BEGIN                    
         
        BEGIN                    /* Processing*/
            /*INSERT ORDERTANSE*/
            INSERT INTO OrderTrans (OrderTransId,OrderId, TransDate, TransType)
            VALUES (seq_OrderTrans.NEXTVAL,in_orderId,v_korTime,in_transCmd);
            
            /*UPDATE Order STATUS*/
            SELECT OrderId INTO v_value1 FROM orders WHERE  OrderId = in_orderId
                    FOR UPDATE WAIT 2;
            UPDATE orders SET Sts= in_transCmd WHERE OrderId = in_orderId;
            
            /*Return Tradefund And Positions*/
            IF  v_openClose = '0001' AND v_placeType = '0001' THEN
                SELECT BrrwId INTO v_value1 FROM BorrowInfo WHERE BrrwId = v_brrwId
                    FOR UPDATE WAIT 2;
                UPDATE BorrowInfo SET
                    Locked = Locked - ROUND(v_orderPrice*v_orderAmt,2)                 
                WHERE BrrwId = v_brrwId;
            ELSIF v_openClose = '0002' THEN
                SELECT COUNT(1),DECODE(COUNT(1),0,0,MAX(PositionSeq))
                        INTO v_recordCnt,v_positionSeq
                    FROM Positions
                WHERE BrrwId = v_brrwId 
                    AND MarketId= v_marketId 
                    AND ItemId= v_itemId                
                    AND PositionType= v_positionType
                    AND PlaceType= v_placeType
                    AND Closed = 'N';
                    
                IF (v_recordCnt = 0 ) THEN
                    out_errorCd := '0050';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                ELSIF (v_recordCnt > 1 ) THEN
                    out_errorCd := '0051';                                                          
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;
                
                SELECT PositionSeq INTO v_value1 FROM Positions WHERE PositionSeq = v_positionSeq
                    FOR UPDATE WAIT 2;
                       
                UPDATE Positions SET
                    Locked = Locked - v_orderAmt                 
                WHERE  PositionSeq = v_positionSeq; 
            END IF;
            
            /*delete From RealtimePrice List*/
            
            /*
            SELECT COUNT(ItemId) INTO v_recordCnt FROM orders WHERE MarketId =  v_marketId and ItemId = v_itemId AND Sts = '0001';
            SELECT COUNT(ItemId) + v_recordCnt INTO v_recordCnt FROM Positions WHERE MarketId =  v_marketId AND ItemId = v_itemId AND HoldAmt > 0;
            IF v_recordCnt = 0 THEN
                DELETE FROM RealtimePrice WHERE MarketId =  v_marketId and ItemId = v_itemId;
            END IF;
            */
           
        END;
        COMMIT;  
    
    END; 
   EXCEPTION
     WHEN NO_DATA_FOUND THEN     
       ROLLBACK; 
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_RejectOrder 실행 시 에러발생');
       
END sp_RejectOrder;

create or replace PROCEDURE          sp_RequestBorrow
(
in_userId           IN      varchar2,
in_brrwCode         IN      varchar2,
in_brrwRate         IN      number,
in_principalMoney   IN      number,
in_brrwMoney        IN      number,
out_errorCd         OUT     varchar2 ,
out_message         OUT     varchar2
) AS
/******************************************************************************
   NAME:       sp_RequestBorrow
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/11   sjh-home       1. Created this procedure.

   NOTES:TEST SQL
   set serveroutput on;
Declare
in_userId                 varchar2(20);
in_brrwCode               varchar2(4);
in_brrwRate               number(10,0);
in_principalMoney         number(21,2);
in_brrwMoney              number(21,2);
out_errorCd         varchar2(200);
out_message         varchar2(200);

begin

in_userId := 'OrgTest02';
in_brrwCode :='0010';
in_brrwRate := 10;
in_principalMoney := 300000;
in_brrwMoney := 3000000.000;
sp_RequestBorrow(in_userId,in_brrwCode,in_brrwRate,in_principalMoney,in_brrwMoney,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE('out_errorCd：' ||out_errorCd || ' out_message：' ||out_message);
end;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_RequestBorrow
      Sysdate:         2019/03/11
      Date and Time:   2019/03/11, 오후 8:11:11, and 2019/03/11 오후 8:11:11
      Username:        sjh-home (in TOAD Options, Procedure Editor)
      Table Name:       (in the "New PL/SQL Object" dialog)

******************************************************************************/
    v_userActive                varchar2(1);
    v_userType                  varchar2(4);
    v_korTime               date;
    v_principal             number(21,2);
    v_brrwRates             varchar2(50);
    v_brrwCount             number(10,0);    
    v_brrwIdList            varchar2(150);
    v_haveBrrwCnt           number(10,0);    
    v_addupBrrwMoney        number(21,2);    
    v_brrwId                number(20,0);   
    v_tradeFund             number(21,2);    
    v_custlossCutPcnt       number(21,3);
    
    
   v_tradeTaxRate           number(10,4);  
   v_tradeFeeRate           number(10,4);  
   v_mgmtFeeRate            number(10,4);  
   v_closeFeeRate           number(10,4);  
   v_lossCutFeeRate         number(10,4);  
   v_overNight              varchar2(1);
   v_overNightFeeRate       number (10,4); 
   v_overNightMaxDay        number(5,0);  
   v_overNightFreeDay       number(5,0);  
   v_lossCutFree            varchar2(1);
   v_lossCutRateMin         number(10,4);  
   v_lostCutRateMax         number(10,4);  
   v_shortSellAllow         varchar2(1);
   v_bonusRate              number(10,4);  
   v_bonusCntPerMonth       number(5,0);  
   v_bonusActive            varchar2(1);
   v_bonusMaxMoney          number(21,2);  
   v_maxBrrwCnt             number(5,0);  
   v_maxBrrwRate            number(10,0);  
   v_maxBrrwMoney           number(21,2);  
   v_membershipDay          number(5,0);  
   v_profitInvestActive     varchar2(1);
   v_lossCutPcnt            number(10,4);  
   v_vipTypeId              varchar2(10);
   v_vipId                  varchar2(20);
   v_specialVip             varchar2(20);
   
    
    
    
   v_recordCnt              number(10,0);  
   v_oneTimeMinPrincipal    number(21,2);  
    
   v_value1                 varchar(20);
   v_value2                 varchar(20);
   v_value3                 varchar(20);
BEGIN

    BEGIN                        /*0.고객유효성 점검*/  
        usp_checkUserActive(in_userId,v_userActive,v_userType);
        IF v_userActive = 'N' THEN                                                         
            out_errorCd := '0002';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
    END;
    
    BEGIN                       /*1.getUserPlace */
        usp_getUserPlace(in_userId,  v_tradeTaxRate, v_tradeFeeRate , v_mgmtFeeRate, v_closeFeeRate, v_lossCutFeeRate , v_overNight, v_overNightFeeRate , v_overNightMaxDay, v_overNightFreeDay 
            , v_lossCutFree  , v_lossCutRateMin  , v_lostCutRateMax , v_shortSellAllow , v_bonusRate , v_bonusCntPerMonth , v_bonusActive , v_bonusMaxMoney , v_maxBrrwCnt,v_maxBrrwRate 
            , v_maxBrrwMoney , v_membershipDay , v_profitInvestActive  ,v_lossCutPcnt, v_vipTypeId , v_vipId , v_specialVip , out_errorCd , out_message);
        
        IF out_errorCd != '0000' THEN
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                ROLLBACK;
                RETURN;  
        END IF;
    END;
    
    BEGIN                        /*2.원금충부여부 확인*/
        SELECT DECODE(COUNT(1),0,0,MAX(Principal))
                INTO v_principal
        FROM CustBalance
            WHERE UserId = in_userId;
        
        IF in_principalMoney > v_principal THEN        
            out_errorCd := '0015';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;  
        END IF;
    END;
   
    BEGIN                        /*3.대출율 입력 ERROR check */
        SELECT COUNT(CodeID) INTO v_recordCnt
            FROM CodeInfo
        WHERE CodeGroupId = '0004'
            AND CodeID = in_brrwCode
            AND Value = in_brrwRate
            AND Active = 'Y';
            
        IF v_recordCnt = 0 THEN
            out_errorCd := '0016';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;
        END IF;
    END;
    
    BEGIN                        /*4.보유대출 개숫  Setting 갓 초과 여부*/
        select count(BrrwID), listagg(BrrwID) within group (order by BrrwID) , listagg(BrrwRate) within group (order by BrrwID),
            decode(count(1),0,0,sum(AddupBrrwMoney))
                into v_brrwCount,v_brrwIdList,v_brrwRates,v_addupBrrwMoney
        FROM BorrowInfo 
            where UserId = in_userId and Returned = 'N';
         DBMS_OUTPUT.PUT_LINE('v_brrwRates：' || v_brrwRates || ' v_haveBrrwCnt:' || v_haveBrrwCnt|| ' v_brrwCount:' || v_brrwCount|| ' v_brrwIdList:' || v_brrwIdList);
        /* TEST
        v_brrwRates = '1,2,3,4,5,6';
        v_brrwCount = 6;
        select v_brrwCount,v_maxBrrwCnt from dual;
        select 'haveBrrwCnt' , count(*)   from dual where in_brrwRate in (v_brrwRates);
        */
        v_haveBrrwCnt := 0;
        IF v_brrwRates IS NOT NULL THEN
            SELECT COUNT(*)  INTO v_haveBrrwCnt from BorrowInfo WHERE BrrwRate IN (v_brrwRates) AND Returned = 'N';
            
            IF v_haveBrrwCnt = 0 AND v_brrwCount + 1 >= v_maxBrrwCnt  THEN                            
                out_errorCd := '0017';
                out_message := spr_GetErrorKRName(out_errorCd);                  
                DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                ROLLBACK;
                RETURN;                    
            END IF;
        END IF;        
    END;
   
    BEGIN                        /*5.고객VIP등급으로 최대 대출배숫 초과 여부 확인*/        
                        
        IF in_brrwRate >v_maxBrrwRate THEN
            out_errorCd := '0018';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
        
        IF in_brrwMoney + v_addupBrrwMoney >v_maxBrrwMoney THEN
            out_errorCd := '0019';
            out_message := spr_GetErrorKRName(out_errorCd) || (v_maxBrrwMoney - v_addupBrrwMoney) || '원만 대출가능 합니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;            
        END IF;     
    END;
    
    BEGIN                        /*6.대출신청시 일회최소금액 달성 여부*/
        usp_getOperationSetting('OneTimeMinPrincipal',v_oneTimeMinPrincipal,v_value1,v_value2,v_value3); 
        IF(in_principalMoney < v_oneTimeMinPrincipal) THEN
            out_errorCd := '0020';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 최소담보금' || v_oneTimeMinPrincipal || '월입니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;
        END IF;
    END;
   
    BEGIN                        /*7.대출금액 계산 Check부*/
        IF(in_principalMoney*in_brrwRate != in_brrwMoney) THEN            
            out_errorCd := '0021';
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;
        END IF;
    END;

    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    BEGIN                         /*8.대출 Process 처리*/
    
        
        BEGIN                    /*8.1대출 내역 기록*/
           
            
            IF v_brrwRates IS NULL OR v_haveBrrwCnt = 0 THEN             /*신규 대출 신청*/
                SELECT SEQ_BORROWINFO.NEXTVAL INTO v_brrwId FROM DUAL;
                INSERT INTO BorrowInfo (BrrwId, UserId, FirstBrrwDate, BrrwRateCode, BrrwRate, LossCutRate, LossCutMoney, AddupPrincipalGuarantee, AddupBrrwMoney, TradeFund,Returned)
                    VALUES (v_brrwId,in_userId,v_korTime,in_brrwCode,in_brrwRate,v_lossCutPcnt,round(in_principalMoney * v_lossCutPcnt/100,2),in_principalMoney,in_brrwMoney,in_brrwMoney,'N');
                
                INSERT INTO BorrowDetail (BrrwId, BrrwTime, ActionType, BrrwAmt)
                    VALUES (v_brrwId,v_korTime,'0001',in_brrwMoney);
        
            ELSE                                /*기준 대출에 추가신청*/
                SELECT DECODE(COUNT(1),0,NULL,MAX(BrrwId)) 
                        INTO v_brrwId
                    FROM BorrowInfo
                WHERE UserId = in_userId         
                    AND BrrwRateCode = in_brrwCode 
                    AND BrrwRate = in_brrwRate
                    AND Returned = 'N';
                    
                IF v_brrwId IS NULL  THEN
                    out_errorCd := '0022';
                    out_message := spr_GetErrorKRName(out_errorCd);                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    ROLLBACK;
                    RETURN;
                END IF;  
                
                SELECT BrrwId INTO v_value1 FROM BorrowInfo WHERE BrrwId = v_brrwId
                    FOR UPDATE WAIT 2;
                
                UPDATE BorrowInfo SET
                    LossCutMoney = round((AddupPrincipalGuarantee + in_principalMoney)*v_lossCutPcnt/100,2),
                    AddupPrincipalGuarantee = AddupPrincipalGuarantee + in_principalMoney,
                    AddupBrrwMoney = AddupBrrwMoney +in_brrwMoney,                        
                    TradeFund = (AddupBrrwMoney +in_brrwMoney) - BrrwRate * AddupWithdrawGuarantee    /* [계산식 = 총 대출금 - 츨금담보금*대출 배숫] */                    
                WHERE BrrwId = v_brrwId;
                    
                INSERT INTO BorrowDetail (BrrwId, BrrwTime, ActionType, BrrwAmt)
                    VALUES (v_brrwId,v_korTime,'0001',in_brrwMoney);
                        
            END IF;
        END;
          
        BEGIN        /*7.2고객Balance정보Update*/
            SELECT  UserId INTO v_value1        
            FROM CustBalance
                WHERE UserId = in_userId
                FOR UPDATE WAIT 2;
                
            UPDATE CustBalance  SET                 
                Principal = Principal - in_principalMoney,                
                PrincipalGuarantee = PrincipalGuarantee + in_principalMoney                                
            WHERE
                UserId = in_userId;                
        END;
        
    END;
    
    COMMIT;
    out_errorCd := '0000';
    out_message := spr_GetErrorKRName(out_errorCd); 

   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       ROLLBACK;
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);       
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_RequestBorrow 실행 시 에러발생');
END sp_RequestBorrow;

create or replace PROCEDURE          sp_RequestDeposit(
in_userId       IN varchar2,
in_bankFrom     IN varchar2,
in_bankTo       IN varchar2,
in_requestMoney IN number,
in_custMemo     IN varchar2,
out_errorCd     OUT varchar2 ,
out_message     OUT varchar2)
IS
    v_rejectOrNoTAtNoBankTime   varchar2(10);
    v_optBonusModeActive        varchar2(10);
    v_optVipModeActive          varchar2(10);
    v_bankProcessTimeStart      varchar2(10);
    v_bankProcessTimeEnd        varchar2(10);
    v_korTime                   date;
    v_vipId                     varchar2(10);    
    v_bonusRate                 number(10,4);
    v_bonusCntPerMonth          number(10,0);
    v_bonusActiveOfVip          varchar2(1);
    v_bonusMaxMoney             number(21,2);
    v_depositBonus              number(21,2);
    v_depositBonusRate          number(10,4);
    v_bonusMoneyOfThisMnth      number(21,2);
    v_bonusCntOfThisMnth        number(10,0);
    v_bonusSource               varchar2(20);
    
    v_eventId                   varchar2(20);
    v_bonusType                 varchar2(4);
    v_optDepositMinMoney        number(21,2);
    v_optDepositMaxMoney        number(21,2);
    v_bankName                  varchar2(20);
    v_accountNo                 varchar2(20);
    v_accountName               varchar2(20);
    v_userActive                varchar2(1);
    v_userType                  varchar2(4);
    /*v_value0                    varchar2(20); */
    v_value1                    varchar2(20);
    v_value2                    varchar2(20);
    v_value3                    varchar2(20);
    v_eventUsed                 varchar2(1);
    v_count0                    number(5,0);
/******************************************************************************
   NAME:       sp_RequestDeposit
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/05   sjh-home       1. Created this procedure.

   NOTES:
set serveroutput on;
Declare
in_userId           varchar2(20);
in_bankFrom         varchar2(10);
in_bankTo           varchar2(10);
in_requestMoney     number(21,2);
in_custMemo         varchar2(200);
out_errorCd         varchar2(200);
out_message         varchar2(200);

begin
OrgTest01,OrgVip02,OrgVip03
in_userId := 'OrgTest01';
in_bankFrom :='3';
in_bankTo :='5';
in_requestMoney :=200000000;
in_custMemo :='';

sp_RequestDeposit(in_userId,in_bankFrom,in_bankTo ,in_requestMoney,in_custMemo,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE('out_errorCd：' ||out_errorCd || 'out_message：' ||out_message);
end;


select * from DepositWithdrawInfo;
select * from custVip;
select * from vipinfo;
select * from custevent;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_RequestDeposit
      Sysdate:         2019/03/05
      Date and Time:   2019/03/05, 오후 9:38:15, and 2019/03/05 오후 9:38:15
      Username:        sjh-home (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   v_rejectOrNoTAtNoBankTime := 'Y';
   v_eventUsed := 'N';
   /*1.Judge the working time . Rujected Or Keep'*/    
    usp_getOperationSetting('BankProcessTime',v_bankProcessTimeStart,v_bankProcessTimeEnd,v_value2,v_value3);       
    
    usp_getOperationSetting('RejectOrNoTAtNoBankTime',v_rejectOrNoTAtNoBankTime,v_value1,v_value2,v_value3);    
    
    usp_getOperationSetting('BonusModeActive',v_optBonusModeActive,v_value1,v_value2,v_value3);    
    
    usp_getOperationSetting('VipModeActive',v_optVipModeActive,v_value1,v_value2,v_value3);    
    
    usp_getOperationSetting('DepositMinMoney',v_optDepositMinMoney,v_value1,v_value2,v_value3);    
    
    usp_getOperationSetting('DepositMaxMoney',v_optDepositMaxMoney,v_value1,v_value2,v_value3);    
   
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
    BEGIN                        /*0.고객유효성 점검*/  
        usp_checkUserActive(in_userId,v_userActive,v_userType);
        IF v_userActive = 'N' THEN                                                         
            out_errorCd := '0002';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
    END;
    
    BEGIN                        /*2.충전처리 금부시간 확인*/
    
        IF v_rejectOrNoTAtNoBankTime ='Y' AND  
            (to_date(to_char(v_korTime,'hh24:mi'),'hh24:mi') > to_date(v_bankProcessTimeEnd,'hh24:mi') 
                    OR to_date(to_char(v_korTime,'hh24:mi'),'hh24:mi') < to_date(v_bankProcessTimeStart,'hh24:mi') )
        THEN
            out_errorCd := '0006';
            out_message := spr_GetErrorKRName(out_errorCd);
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN;             
        END IF;
    END;
    
    BEGIN                        /*1.충전금액 확인 */
        IF(in_requestMoney < to_number(v_optDepositMinMoney)) THEN    
            out_errorCd := '0004';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 최소금액은: ' ||v_optDepositMinMoney || '원 입니다';
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
   
        
        IF(in_requestMoney > to_number(v_optDepositMaxMoney)) THEN    
            out_errorCd := '0005';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 최대금액은: ' ||v_optDepositMaxMoney || '원 입니다';
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
        END IF;
    END;
    
   
    
    BEGIN
        SELECT DECODE(COUNT(1),0,NULL,MAX(BankName)),
               DECODE(COUNT(1),0,NULL,MAX(AccountNo)),
               DECODE(COUNT(1),0,NULL,MAX(AccountName))
            INTO v_bankName, v_accountNo, v_accountName
        FROM CustBankInfo WHERE UserId = in_userId AND BankId = in_bankFrom AND BankOwner = '0001' /*고객*/ AND Active = 'Y';
           
            /*SELECT v_depositBonus , v_depositBonusRate , v_bonusType ,v_bonusSource,out_errorCd,_message from dual; */
            
        IF(v_accountNo IS NULL ) THEN
            out_errorCd := '0007';
            out_message := spr_GetErrorKRName(out_errorCd);
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
         END IF;
         
        SELECT DECODE(COUNT(1),0,NULL,MAX(BankName)),
               DECODE(COUNT(1),0,NULL,MAX(AccountNo)),
               DECODE(COUNT(1),0,NULL,MAX(AccountName))
            INTO v_bankName, v_accountNo, v_accountName
        FROM CustBankInfo WHERE BankId = in_bankTo AND BankOwner = '0002' /*고객*/ AND Active = 'Y';
           
            /*SELECT v_depositBonus , v_depositBonusRate , v_bonusType ,v_bonusSource,out_errorCd,_message from dual; */
            
        IF(v_accountNo IS NULL ) THEN
            out_errorCd := '0008';
            out_message := spr_GetErrorKRName(out_errorCd);
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
            RETURN; 
         END IF;
    END;
    
    BEGIN                          /*3.충전요청기록 등록하기*/
        v_depositBonus := 0;
        v_depositBonusRate := 0;
        v_bonusType := null;
        v_bonusSource :=null;
        BEGIN            /*3.1 Bonus 적용여부확인*/
            
            IF(v_optBonusModeActive = 'Y') THEN
            
                /*Event Model Effact*/
                /*Event Bonus 우선사용합니다*/
                BEGIN
                    /*가용 Event 정보 가지오기*/
                    /*0002--고객 첫 충정Bonus, 0003--수시 월별 충전Bonus*/
                    
                    SELECT COUNT(ce.EventId) INTO v_count0
                        FROM  CustEvent ce, EventInfo ei  
                    WHERE ce.userId = in_userId 
                        AND ce.EventId = ei.EventId AND ce.Used <> 'Y' 
                        AND ei.EventType in ('0002','0003') /*0002 첫 충정Evnet, 0003 일반충정Event */ AND ei.Active = 'Y'
                        AND v_korTime >=ce.StartDate
                        AND v_korTime <= ce.EndDate;
                       
                    IF v_count0 > 0 THEN    
                        
                        /* Evernt 상세정보*/    
                        SELECT d.EventId,d.A,d.B,d.C 
                                INTO v_eventId,v_bonusRate, v_bonusCntPerMonth, v_bonusMaxMoney                        
                            FROM  CustEvent ce, EventInfo ei ,EventDetail d 
                        WHERE ce.userId = in_userId 
                            AND ce.EventId = ei.EventId AND ei.Eventid = d.EventId AND ce.Used <> 'Y'
                            AND ei.EventType in ('0002','0003') /*0002 첫 충정Evnet, 0003 일반충정Event */ AND ei.Active = 'Y'
                            AND v_korTime >=ce.StartDate
                            AND v_korTime <= ce.EndDate
                            AND ROWNUM < 2;
                       
                      
                        /*당워사용 및 신청중 Bonus 정보 가지오기*/
                        SELECT DECODE(COUNT(BonusMoney),0,0,SUM(BonusMoney)),
                               DECODE(COUNT(BonusMoney),0,0,COUNT(BonusMoney))
                                    INTO v_bonusMoneyOfThisMnth,v_bonusCntOfThisMnth
                            FROM DepositWithdrawInfo
                        WHERE UserId = in_userId AND BonusMoney > 0 
                            AND  Sts in ('0001','0002') /*Statues ('0001'시청,'0002'승인)*/                            
                            AND BonusSource = v_eventId;
                            
                        IF (v_bonusCntOfThisMnth >= v_bonusCntPerMonth) THEN    /*Bonus 충전회숫 상한 도찰 */                     
                            v_depositBonus := 0; 
                            v_eventUsed := 'Y';                                            
                        ELSE                                                /*Bonus 충전회숫 상한  미달 시  */
                            
                            v_depositBonus := round(in_requestMoney * v_bonusRate / 100,2);
                            
                            IF (v_depositBonus + v_bonusMoneyOfThisMnth > v_bonusMaxMoney) THEN                        
                                v_depositBonus := v_bonusMaxMoney -v_bonusMoneyOfThisMnth;
                                v_eventUsed := 'Y';                                                      
                            END IF;    
                            
                            IF (v_depositBonus>0) THEN
                                v_depositBonusRate := v_bonusRate;
                                v_bonusType := '0002';
                                v_bonusSource := v_eventId;                    
                            END IF;
                        END IF;
                     END IF;  
                END;
            END IF;
        END; 
               
        /**3.2 Vip Model Effact*/
        BEGIN
            
            IF (v_depositBonus = 0 AND v_optVipModeActive = 'Y') THEN    /*When Event Bonus is Working, No process Vip Bonus*/
               
            
                       
                /*Get Vip Info for bonus rate*/
                SELECT DECODE(COUNT(1),0,'vip0',MAX(VipId)) into v_vipId
                    FROM CustVip WHERE userId = in_userId;
                      
                            
                v_bonusActiveOfVip := 'N';
                v_bonusRate := 0;
                v_bonusCntPerMonth := 0;
                v_bonusMaxMoney := 0;
                SELECT  BonusRate, BonusCntPerMonth, BonusActive, BonusMaxMoney
                        INTO v_bonusRate, v_bonusCntPerMonth, v_bonusActiveOfVip, v_bonusMaxMoney
                    FROM VipInfo WHERE VipId = v_vipId;
                IF v_bonusActiveOfVip = 'Y' THEN
                    SELECT DECODE(COUNT(BonusMoney),0,0,SUM(BonusMoney)),
                           DECODE(COUNT(BonusMoney),0,0,COUNT(BonusMoney))
                                INTO v_bonusMoneyOfThisMnth,v_bonusCntOfThisMnth
                        FROM DepositWithdrawInfo 
                    WHERE UserId = in_userId 
                        AND BonusMoney > 0 
                        AND Sts in ('0001','0002') 
                        AND BonusType = '0001'/*Statues ('0001'시청,'0002'승인)*/
                        AND to_char(v_korTime,'yyyyMM') = to_char(RequestTime,'yyyyMM')
                        AND BonusSource = v_vipId;
                                
                                
                    IF (v_bonusCntOfThisMnth >= v_bonusCntPerMonth)  THEN  /*Bonus 충전회숫 상한 도찰 */                         
                        v_depositBonus := 0;
                    ELSE                                            /*Bonus 충전회숫 상한  미달 시  */
                                    
                        v_depositBonus := ROUND(in_requestMoney * v_bonusRate / 100,2);
                                    
                        IF (v_depositBonus + v_bonusMoneyOfThisMnth > v_bonusMaxMoney) THEN                        
                            v_depositBonus := v_bonusMaxMoney -v_bonusMoneyOfThisMnth;                        
                        END IF; 
                                                 
                        IF (v_depositBonus > 0) THEN
                            v_depositBonusRate := v_bonusRate;
                            v_bonusType := '0001';
                            v_bonusSource := v_vipId;                    
                        END IF;
                    END IF;                          
                END IF;
            END IF;  
        END;
            
       
        
        /*3.3 Insert SQL*/
        BEGIN    
            
        
                                 
            
            /*START TRANSACTION; */ 
            /*
            IF v_eventUsed = 'Y' AND v_eventId IS NOT NULL THEN
                UPDATE CustEvent SET USED = 'Y' WHERE  userId = in_userId AND  EventId = v_eventId;  
            END IF;
           */
            INSERT INTO DepositWithdrawInfo (AccessSeq,UserId,BankFrom,BankTo,BalanceType,RequestTime,RequestMoney,Sts
                    ,CustMemo,BonusMoney, BonusSource, BonusMemo, BonusType ,GuaranteeWithdraw) 
                VALUES 
                  (SEQ_DepositWithdrawInfo.NEXTVAL,in_userId,in_bankFrom,in_bankTo,'0001',v_korTime,in_requestMoney,'0001'
                    ,nvl(in_custMemo,''),nvl(v_depositBonus,0),v_bonusSource,'',v_bonusType,'N');
            
            COMMIT;
            out_errorCd := '0000';
            out_message := spr_GetErrorKRName(out_errorCd);  
            
        END;
        
        
    END;
    
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || ' ORA' || sqlcode || ' Message' || sqlerrm;
       DBMS_OUTPUT.PUT_LINE('sp_RequestDeposit 실행 시 에러발생');
       --RAISE;
END sp_RequestDeposit;

create or replace PROCEDURE          sp_ReturnBrrw (
in_brrwId           IN          number,
out_errorCd         OUT         varchar2,
out_message         OUT         varchar2
)IS
/******************************************************************************
   NAME:       sp_ReturnBrrw
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/04/16   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     sp_ReturnBrrw
      Sysdate:         2019/04/16
      Date and Time:   2019/04/16, 오전 8:29:32, and 2019/04/16 오전 8:29:32
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

--v_korTime                       date;
--v_localTime                     date;

--v_orderId                       number(20,0);    
--v_positionSeq                   number(20,0);
--v_brrwId                        number(20,0);
v_userId                        varchar2(12);
--v_itemId                        varchar2(12);
--v_marketId                      varchar2(4);
--v_positionType                  varchar2(4);
--v_tradeType                     varchar2(4);
--v_orderType                     varchar2(4);
---v_orderPrice                    number(21,2);
--v_orderAmt                      number(21,3);
--v_executedType                  varchar2(4);     
--v_placeType                     varchar2(4);
--v_openClose                     varchar2(4);
--v_returnType                    varchar2(4);
--v_overRate                      number(21,2);
--v_overCloseType                 varchar2(4);
v_returned                      varchar2(1);
--v_margin                        number(21,2);
--v_usableMarginPlace             number(21,2);
v_recordCnt                     number(20,0);
--v_shortSellAllow                varchar2(10);
--v_marketShortSellAllow          varchar2(1);
--v_itemShortSellAllow            varchar2(1);
--v_vipShortSellAllow             varchar2(1);    
--v_tradable                      varchar2(1);
--v_timezone                      number(5,0);    
--v_minBrrwRateOfMarket           number(5,0);
--v_maxBrrwRateOfMarket           number(5,0);
v_addupGuarantee                number(21,3);
v_addupWithdrawGuarantee        number(21,3);
v_profit                        number(21,3);
v_addupFee                      number(21,3);
--v_tradebleAmt                   number(21,3);
--v_value0                        varchar(30);
v_value1                        varchar(30);
--v_value2                        varchar(30);
--v_value3                        varchar(30);
BEGIN
   
   /*Brrw의Positon과미 실행 Order 준제 여부 Check */
   BEGIN
        SELECT COUNT(POSITIONSEQ) INTO v_recordCnt FROM POSITIONS WHERE brrwId = in_brrwId AND CLOSED = 'N';
        IF v_recordCnt >0 THEN           
            sp_ClosePositionsOfBrrw(in_brrwId,'0006',out_errorCd,out_message);           
            RETURN;
        END IF;
        
        SELECT COUNT(ORDERID) INTO v_recordCnt FROM ORDERS WHERE brrwId = in_brrwId AND Sts = '0001' ;
        IF v_recordCnt >0 THEN            
            RETURN;
        END IF;
   END;
   
   BEGIN
        SELECT UserId,AddupPrincipalGuarantee, AddupWithdrawGuarantee,Returned,AddupCloseProfit, AddupLossCutFee+ AddupCloseFee + AddupMgmtFee + AddupTradeFee + AddupTradeTax+ AddupOverNightFee 
               INTO v_userId,v_addupGuarantee,v_addupWithdrawGuarantee,v_returned,v_profit,v_addupFee
            FROM BorrowInfo 
        WHERE BrrwId= in_brrwId 
            FOR UPDATE NOWAIT;
            
        SELECT UserId INTO v_value1 FROM CustBalance WHERE UserId = v_userId
                    FOR UPDATE NOWAIT;
        IF v_returned != 'W' THEN            
            ROLLBACK;
            RETURN;
        END IF;
       
                   
        UPDATE BorrowInfo SET
            RETURNED = 'Y'
        WHERE BrrwId= in_brrwId;
        UPDATE CustBalance SET
            Principal =  Principal + v_addupGuarantee + v_profit  - v_addupWithdrawGuarantee - v_addupFee
        WHERE UserId = v_userId;
        COMMIT;
            
   END;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN  
       ROLLBACK;    
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd)|| ' ORA' || sqlcode || ' Message' || sqlerrm; 
       DBMS_OUTPUT.PUT_LINE('sp_ReturnBrrw 실행 시 에러발생');
END sp_ReturnBrrw;

create or replace PROCEDURE          sp_RollbackDeposit
(
in_depositSeq   IN      number,
in_manangerId   IN      varchar2,
in_memo         IN      varchar2,    
out_errorCd     OUT     varchar2,
out_message     OUT     varchar2)
IS
 v_korTime              date;
v_recordcount           number(10,0);    
v_userId                varchar2(20);
v_sts                   varchar2(4);
v_bonus                 number(21,2);
v_executeMoney          number(21,2);
v_reuestMoney           number(21,2);
v_bonusSource           varchar2(15);
v_bonusType             varchar2(4);
--v_processing            varchar2(1);

/******************************************************************************
   NAME:       sp_RollbackDeposit
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/08   Administrator       1. Created this procedure.

   NOTES:TEST SQL 
   set serveroutput on;
Declare
in_depositSeq       number(20,0);
in_manangerId       varchar2(20);
in_memo             varchar2(200);
out_errorCd         varchar2(200);
out_message         varchar2(200);

begin

in_depositSeq := 12;
in_manangerId :='ShrubAdmin';

in_memo :='';


sp_RollbackDeposit(in_depositSeq,in_manangerId ,in_memo,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE('out_errorCd：' ||out_errorCd || ' out_message：' ||out_message);
end;

select * from custbalance;

select a.* from DepositWithDrawInfo a;
select * from custevent;
select * from eventDetail;

   Automatically available Auto Replace Keywords:
      Object Name:     sp_RollbackDeposit
      Sysdate:         2019/03/08
      Date and Time:   2019/03/08, 오후 1:21:54, and 2019/03/08 오후 1:21:54
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
    
    
   
    SELECT spr_getKorTime() INTO v_korTime FROM DUAL;
    
     BEGIN                /*1 관리자 계정 정상여부를 확인 합니다*/    
        SELECT COUNT(UserId) INTO v_recordcount
            FROM UserInfo
        WHERE UserId = in_manangerId AND UserType IN ('0002','0010') AND Active = 'Y';
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0009';
            out_message := spr_GetErrorKRName(out_errorCd) || ' 입금처리 불가 합니다';                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;
        END IF;
    END;
   
    BEGIN                /*2 입금요청 정보 Check */
        SELECT COUNT(1) INTO v_recordcount                 
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq;
        
        IF (v_recordcount = 0) THEN
            out_errorCd := '0012';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            RETURN;            
        END IF;
        
        
        SELECT RequestMoney,ExecuteMoney,UserId,Sts,BonusMoney,BonusSource,BonusType 
                INTO v_reuestMoney,v_executeMoney,v_userId,v_sts,v_bonus,v_bonusSource,v_bonusType 
            FROM DepositWithDrawInfo
        WHERE AccessSeq = in_depositSeq
            FOR UPDATE WAIT 2 ;
        
        
        IF v_sts <> '0002' AND v_sts <> '0003' THEN
            out_errorCd := '0014';
            out_message := spr_GetErrorKRName(out_errorCd) ;                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            ROLLBACK;
        END IF;
       
    END;
    
    
   
    
    BEGIN                /*3 입금요청 Rollback 처리*/
    
        /*3.0 고객 Balance LOCK*/
        /*
        BEGIN
            SELECT count(UserId) , DECODE(COUNT(1),0,'N',MAX(Processing))
                    INTO v_recordcount,v_processing
            FROM CustBalance
                WHERE UserId = v_userId;
            IF  v_processing = 'Y' THEN
                    out_errorCd := '0060';
                    out_message := spr_GetErrorKRName(out_errorCd) ;                  
                    DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
                    RETURN;
            END IF;           
        END;
        */
        
        SELECT   UserId INTO v_userId        
        FROM CustBalance
            WHERE UserId = v_userId
            FOR UPDATE WAIT 2;
            
        SELECT  DECODE(EventId,NULL,NULL,EventId) INTO v_bonusSource
        FROM CustEvent                            
            WHERE UserId = v_userId AND EventId = v_bonusSource
            FOR UPDATE WAIT 2; 
        
        /* 3(CASE1)입금거부 Rollback 처리*/
        BEGIN                            
            IF v_sts = '0003' THEN
                UPDATE DepositWithDrawInfo SET          
                    ExecuteTime = v_korTime, 
                    ExecuteMoney = 0, 
                    Sts = '0001',           
                    MgmtMemo = in_memo, 
                    MgmtUserId = in_manangerId
                WHERE
                    AccessSeq = in_depositSeq;
               
           
        
            /*3 (CASE2)입금승인 rollback 처리*/                                  
            ELSIF v_sts = '0002' THEN
                /*3 (CASE2) 1.입금요청성태로rollback*/    
                BEGIN                                
                    UPDATE DepositWithDrawInfo SET          
                        ExecuteTime = v_korTime, 
                        ExecuteMoney = 0, 
                        Sts = '0001',           
                        MgmtMemo = in_memo, 
                        MgmtUserId = in_manangerId
                    WHERE
                        AccessSeq = in_depositSeq;    
            
                END;
                /*3 (CASE2) 2.Balance rollback*/
                BEGIN                        
                                
                    UPDATE CustBalance SET                 
                        Principal = Principal - v_executeMoney,                
                        AddupDeposit = AddupDeposit - v_executeMoney, 
                        AddupBonus = AddupBonus - v_bonus,
                        FirstDeposit = DECODE(FirstDeposit,AddupDeposit,0,FirstDeposit)                
                    WHERE
                        UserId = v_userId;                        
                        
                    
                END;
                /*3 (CASE2) 3.Event Bonus 사용rollback 처리*/
                BEGIN                       
                    IF v_bonusSource IS NOT NULL AND v_bonusType = '0002'  THEN   
                            DBMS_OUTPUT.PUT_LINE('sp_RollbackDeposit' || v_userId|| v_bonusSource );
                        UPDATE CustEvent SET
                            Used = 'N'
                        WHERE
                            UserId = v_userId AND EventId = v_bonusSource;                    
                    END IF;   
                END;
        
            END IF;
        END;
        
        
        COMMIT;
        out_errorCd := '0000';
        out_message := spr_GetErrorKRName(out_errorCd);   
    END; 
   EXCEPTION
     WHEN NO_DATA_FOUND THEN   
       ROLLBACK;  
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || ' ORA' || sqlcode || ' Message' || sqlerrm;
       DBMS_OUTPUT.PUT_LINE('sp_RejectDeposit 실행 시 에러발생');    
END sp_RollbackDeposit;

create or replace PROCEDURE          usp_checkUserActive
(
    in_userId       in varchar2,
    out_userActive  out varchar2,
    out_userType    out varchar2
) IS

/******************************************************************************
   NAME:       usp_checkUserActive
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/02/22   Administrator       1. Created this procedure.

   NOTES:TEST  SQL
        set serveroutput on;
        Declare
        in_userId varchar2(10);
        out_userActive varchar2(10);
        out_userType varchar2(4);
        begin
        in_userId := 'OrgVip01';
        usp_checkUserActive(in_userId,out_userActive,out_userType);
        DBMS_OUTPUT.PUT_LINE('가용User：' ||out_userActive || out_userType);
        end;
   Automatically available Auto Replace Keywords:
      Object Name:     usp_checkUserActive
      Sysdate:         2019/02/22
      Date and Time:   2019/02/22, 오후 1:02:01, and 2019/02/22 오후 1:02:01
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   
   
   SELECT DECODE(COUNT(1),0,'N',MAX(Active)) ,DECODE(COUNT(1),0,'0000',MAX(UserType)) INTO out_userActive,out_userType FROM UserInfo WHERE USERID = in_userId;
  
  EXCEPTION
     WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('usp_getUserSetting NO_DATA_FOUND !'); 
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_checkUserActive;

create or replace PROCEDURE          usp_getBrrwUsableForTrade 
(   in_brrwId                   IN      number,
    out_usableMoney             OUT     number,
    out_usableMarginPlace       OUT     number,
    out_errorCd                 OUT     varchar2,
    out_message                 OUT     varchar2
    ) AS

/******************************************************************************
   NAME:       usp_getUsableForTrade
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/04   Administrator       1. Created this procedure.

   NOTES:TEST SQL
 
Declare
            
in_brrwid                   number(20,0);
out_usableMoney             number(21,2); 
out_usableMarginPlace       number(21,2); 
out_errorCd                 varchar2(20);
out_message                 varchar2(200);
BEGIN 
in_brrwid :=3;
usp_getBrrwUsableForTrade(   in_brrwid  ,out_usableMoney  ,out_usableMarginPlace,out_errorCd,out_message);
DBMS_OUTPUT.PUT_LINE(out_errorCd  ||'--'||out_message );
DBMS_OUTPUT.PUT_LINE(' in_brrwid-'||in_brrwid  ||'- out_usableMoney-'||out_usableMoney  ||'-out_usableMarginPlace-'||out_usableMarginPlace);
end;

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getUsableForTrade
      Sysdate:         2019/03/04
      Date and Time:   2019/03/04, 오후 3:37:01, and 2019/03/04 오후 3:37:01
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
  
   
   v_userId                   varchar2(20);
   v_tradeTaxRate             number(10,4);  
   v_tradeFeeRate             number(10,4);  
   v_mgmtFeeRate              number(10,4);  
   v_closeFeeRate             number(10,4);  
   v_lossCutFeeRate           number(10,4);  
   v_overNight                varchar2(1);
   v_overNightFeeRate         number (10,4); 
   v_overNightMaxDay          number(5,0);  
   v_overNightFreeDay         number(5,0);  
   v_lossCutFree              varchar2(1);
   v_lossCutRateMin           number(10,4);  
   v_lostCutRateMax           number(10,4);  
   v_shortSellAllow           varchar2(1);
   v_bonusRate                number(10,4);  
   v_bonusCntPerMonth         number(5,0);  
   v_bonusActive              varchar2(1);
   v_bonusMaxMoney            number(21,2);  
   v_maxBrrwCnt               number(5,0);  
   v_maxBrrwRate              number(10,0);  
   v_maxBrrwMoney             number(21,2);  
   v_membershipDay            number(5,0);  
   v_profitInvestActive       varchar2(1);
   v_lossCutPcnt              number(10,4);  
   v_vipTypeId                varchar2(10);
   v_vipId                    varchar2(20);
   v_specialVip               varchar2(20);
   
   v_tradeFund  number(21,2);
   v_changeMoney number(21,2);
   v_returned VARCHAR2(1);
   v_longPositionMargin number(21,2);
   v_shortPositionMargin number(21,2);
   v_tmpPositionMargin number(21,2);
   v_locked number(21,2);
   v_totalFee number(21,2);
    
   v_addLongMarginPlace number(21,2);
   v_addShortMarginPlace number(21,2);
   v_brrwRate number(5,0);
   v_value0 VARCHAR2(20);

BEGIN
   out_usableMoney := 0;
   out_usableMarginPlace := 0;   
   BEGIN                                 /*1. Get BorrowInfo And Set _usableMoney*/
       SELECT DECODE(COUNT(1),0,'Y',MAX(Returned)),
              DECODE(COUNT(1),0,0,SUM(TradeFund - AddupWithdrawGuarantee*BrrwRate)),
              DECODE(COUNT(1),0,0,SUM(ChangeMoney)),
              DECODE(COUNT(1),0,NULL,MAX(UserId)),
              DECODE(COUNT(1),0,NULL,MAX(BrrwRate)),
              DECODE(COUNT(1),0,0,SUM(Locked)),
              DECODE(COUNT(1),0,0,SUM(AddupLossCutFee + AddupCloseFee + AddupMgmtFee + AddupTradeFee + AddupTradeTax + AddupOverNightFee))          
                    INTO v_returned, v_tradeFund,v_changeMoney ,v_userId,v_brrwRate,v_locked,v_totalFee
       FROM BorrowInfo
            WHERE BrrwId = in_brrwId;
            
       IF v_userId IS NULL THEN
            out_errorCd := '0003';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);
            return;
       END IF;
       IF v_returned <> 'N' THEN
            out_usableMoney := 0;
            out_usableMarginPlace := 0;
            DBMS_OUTPUT.PUT_LINE('Returned Borrow !');
            return;
       END IF;  
       out_usableMoney := v_tradeFund + v_changeMoney - v_locked - v_totalFee;
   END ;
   
   BEGIN                                /*2. Get user place*/
 
        usp_getUserPlace(v_userId,  v_tradeTaxRate, v_tradeFeeRate , v_mgmtFeeRate, v_closeFeeRate, v_lossCutFeeRate , v_overNight, v_overNightFeeRate , v_overNightMaxDay, v_overNightFreeDay 
        , v_lossCutFree  , v_lossCutRateMin  , v_lostCutRateMax , v_shortSellAllow , v_bonusRate , v_bonusCntPerMonth , v_bonusActive , v_bonusMaxMoney , v_maxBrrwCnt,v_maxBrrwRate 
        , v_maxBrrwMoney , v_membershipDay , v_profitInvestActive  , v_lossCutPcnt, v_vipTypeId ,v_vipId , v_specialVip , out_errorCd , out_message);        
        
        IF(out_errorCd <> '0000') THEN 
            return;
        END IF;
    END;
   
   BEGIN                                /*3. Get Position and MarginPlaceble Money*/
        IF (v_profitInvestActive ='N') THEN
             out_usableMarginPlace := 0 ;    
             return;
        END IF;
        usp_getUserSetting(v_userId,'ProfitInvestActive',v_value0);
        IF (v_value0 ='N') THEN
             out_usableMarginPlace := 0 ;    
             return;
        END IF;
        /*LONG*/
        SELECT NVL(SUM(CASE
                            WHEN (AddupOpenMoney - AddupCloseMoney - p.HoldAmt*DECODE(r.Price,null,p.AvgPrice,r.Price) )> 0 then 0 
                            ELSE AddupCloseMoney + p.HoldAmt*DECODE(r.Price,null,p.AvgPrice,r.Price) - AddupOpenMoney end)
                        ,0) , 
                    NVL(SUM(AddMarginPlace),0)
                INTO v_longPositionMargin,v_addLongMarginPlace
        FROM Positions p left join RealtimePrice r
                ON  p.ItemId= r.ItemId AND p.MarketId =r.MarketId
            WHERE p.BrrwId= in_brrwId
                AND P.PositionType = '0001'
                AND p.HoldAmt > 0;
            
        /*SHORT*/
        SELECT NVL(SUM(CASE
                            WHEN (AddupOpenMoney - AddupCloseMoney - p.HoldAmt*DECODE(r.Price,NULL,p.AvgPrice,r.Price)) < 0 THEN 0
                            ELSE AddupOpenMoney - AddupCloseMoney - p.HoldAmt*DECODE(r.Price,NULL,p.AvgPrice,r.Price) END )
                   ,0) ,
               NVL(SUM(AddMarginPlace),0)
            INTO v_shortPositionMargin,v_addShortMarginPlace
        FROM Positions p left join RealtimePrice r
                ON  p.ItemId= r.ItemId AND p.MarketId =r.MarketId
            WHERE p.BrrwId= in_brrwId
                AND P.PositionType = '0002'
                AND p.HoldAmt > 0;
                
            
        IF v_longPositionMargin is null THEN
            v_longPositionMargin := 0;
        END IF;
        IF v_shortPositionMargin is null THEN
            v_shortPositionMargin := 0;
        END IF;
        
        IF v_addLongMarginPlace is null THEN
            v_addLongMarginPlace := 0;
        END IF;
        
        IF v_addShortMarginPlace is null THEN
            v_addShortMarginPlace := 0;
        END IF;      
        
        /* SET UsableMarginPlace*/
        out_usableMarginPlace := 0;
        v_tmpPositionMargin := (v_longPositionMargin - v_addLongMarginPlace/v_brrwRate) *v_brrwRate;        
        IF v_tmpPositionMargin is null OR v_tmpPositionMargin < 0 THEN
            v_tmpPositionMargin := 0 ;
        END IF;        
        out_usableMarginPlace := out_usableMarginPlace + v_tmpPositionMargin;
            
        v_tmpPositionMargin := (v_shortPositionMargin - v_addShortMarginPlace/v_brrwRate) * v_brrwRate;
        IF v_tmpPositionMargin is null OR v_tmpPositionMargin < 0 THEN
            v_tmpPositionMargin := 0 ;
        END IF;        
        out_usableMarginPlace := out_usableMarginPlace + v_tmpPositionMargin;        
        
        IF out_usableMarginPlace IS null OR out_usableMarginPlace < 0 THEN
             out_usableMarginPlace  := 0 ;
        END IF;
        
    END;
    
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd);
       DBMS_OUTPUT.PUT_LINE('usp_getBrrwUsableForTrade 실행 시 에러발생');
       RAISE;
END usp_getBrrwUsableForTrade;

create or replace PROCEDURE          usp_getFundReturnType(
     in_userid IN  varchar2,
     out_returnTypeOfShortOrderUser OUT varchar2
     )
     IS

/******************************************************************************
   NAME:       usp_getFundReturnType
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/04   Administrator       1. Created this procedure.

   NOTES:TEST SQL
        set serveroutput on;
        Declare
        in_userid varchar2(100);
        out_returnTypeOfShortOrderUser varchar2(100);
        
        begin
        in_userid := 'OrgTest01';
        
        usp_getFundReturnType(in_userid,out_returnTypeOfShortOrderUser);
        DBMS_OUTPUT.PUT_LINE('out_returnTypeOfShortOrderUser：' || out_returnTypeOfShortOrderUser);
        end;

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getFundReturnType
      Sysdate:         2019/03/04
      Date and Time:   2019/03/04, 오후 3:19:05, and 2019/03/04 오후 3:19:05
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

    v_value0  varchar2(20);
    v_value1  varchar2(20);
    v_value2  varchar2(20);
    v_value3  varchar2(20);
    
BEGIN
    usp_getOperationSetting('ReturnTypeOfShortOrder',v_value0,v_value1,v_value2,v_value3);    
    usp_getUserSetting(in_userId,'ReturnTypeOfShortOrder',out_returnTypeOfShortOrderUser);    
    IF out_returnTypeOfShortOrderUser IS NULL THEN
       out_returnTypeOfShortOrderUser := v_value0;
    END IF;
    
    IF out_returnTypeOfShortOrderUser IS NULL THEN
         out_returnTypeOfShortOrderUser := '0001';
    END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('usp_getFundReturnType  UserID '||in_userId); 
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_getFundReturnType;

create or replace PROCEDURE usp_getMarketSetting 
    (
    
    in_marketId     IN varchar2,  
    in_key          IN varchar2,  
    out_value1      OUT varchar2,
    out_value2      OUT varchar2,
    out_value3      OUT varchar2,
    out_value4      OUT varchar2,
    out_act         OUT varchar2)
    IS
/******************************************************************************
   NAME:       usp_getMarketSetting
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/05/01   sjh-home       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getMarketSetting
      Sysdate:         2019/05/01
      Date and Time:   2019/05/01, 오후 12:22:08, and 2019/05/01 오후 12:22:08
      Username:        sjh-home (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
    /* Formatted on 2019/05/01 오후 12:26:10 (QP5 v5.256.13226.35510) */
    SELECT DECODE(COUNT(1),0,NULL,MAX(Value1)),
           DECODE(COUNT(1),0,NULL,MAX(Value2)),
           DECODE(COUNT(1),0,NULL,MAX(Value3)),
           DECODE(COUNT(1),0,NULL,MAX(Value4)),
           DECODE(COUNT(1),0,NULL,MAX(Active))
      INTO out_value1,
           out_value2,
           out_value3,
           out_value4,
           out_act
      FROM MarketSetting
     WHERE MarketId = in_marketId AND ConfigName = in_key;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
      /*out_errorCd := '0001';                                                          
      out_message := spr_GetErrorKRName(out_errorCd); */
      DBMS_OUTPUT.PUT_LINE('usp_getMarketSetting NO_DATA_FOUND !'); 
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_getMarketSetting;

create or replace PROCEDURE          usp_getOperationSetting 
    ( in_key IN varchar2,
    out_manValue OUT varchar2,
    out_value1 OUT varchar2,
    out_value2 OUT varchar2,
    out_value3 OUT varchar2)
    IS

/******************************************************************************
   NAME:       usp_getOperationSetting
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/02/28   Administrator       1. Created this procedure.

   NOTES:TEST SQL
        set serveroutput on;
            Declare
        in_key  varchar2(100);
        out_manValue  varchar2(100);
        out_value1  varchar2(100);
        out_value2  varchar2(100);
        out_value3  varchar2(100);
        begin
        in_key := 'TradeFeeMode';
        usp_getOperationSetting(in_key,out_manValue,out_value1,out_value2,out_value3);
        DBMS_OUTPUT.PUT_LINE('MAIN VALUE：' || out_manValue);
        end;

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getOperationSetting
      Sysdate:         2019/02/28
      Date and Time:   2019/02/28, 오후 12:50:53, and 2019/02/28 오후 12:50:53
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   out_manValue := 'Not Define';
   out_value1 := 'Not Define';
   out_value2 := 'Not Define';
   out_value3 := 'Not Define';  
   SELECT DECODE(COUNT(1),0,NULL,MAX(OptMainValue)), DECODE(COUNT(1),0,NULL,MAX(OptSubValue1)), DECODE(COUNT(1),0,NULL,MAX(OptSubValue2)), DECODE(COUNT(1),0,NULL,MAX(OptSubValue3))
            INTO out_manValue,out_value1,out_value2,out_value3
   FROM OptSetting
        WHERE OptKey = in_key AND Active = 'Y';
        
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      /*out_errorCd := '0001';                                                          
      out_message := spr_GetErrorKRName(out_errorCd); */
      DBMS_OUTPUT.PUT_LINE('usp_getOperationSetting NO_DATA_FOUND !'); 
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_getOperationSetting;

create or replace PROCEDURE usp_getUserOverSetting
(   in_userId                   IN      varchar2,
    out_overRate                OUT     number,
    out_closeType               OUT     varchar2,
    out_errorCd                 OUT     varchar2,
    out_message                 OUT     varchar2
    ) AS
/******************************************************************************
   NAME:       usp_getUserOverSetting
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019-04-10   Administrator       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getUserOverSetting
      Sysdate:         2019-04-10
      Date and Time:   2019-04-10, 오전 8:37:06, and 2019-04-10 오전 8:37:06
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
v_value0  varchar2(20);
v_value1  varchar2(20);
v_value2  varchar2(20);
v_value3  varchar2(20);
BEGIN
    usp_getOperationSetting('CloseTypeOfOverNightBeyond',v_value0,v_value1,v_value2,v_value3);    
    usp_getUserSetting(in_userId,'CloseTypeOfOverNightBeyond',out_closeType);    
    IF out_closeType IS NULL THEN
       out_closeType := v_value0;
    END IF;
    usp_getOperationSetting('OverNightRate',v_value0,v_value1,v_value2,v_value3);
    IF v_value0 IS NULL THEN
         out_overRate := v_value0;
    ELSE
        out_overRate := 5;
    END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_getUserOverSetting;

create or replace PROCEDURE          usp_getUserPlace 
(
    in_userId                   IN   varchar2,
    out_tradeTaxRate            OUT  number, 
    out_tradeFeeRate            OUT  number, 
    out_mgmtFeeRate             OUT  number, 
    out_closeFeeRate            OUT  number, 
    out_lossCutFeeRate          OUT  number, 
    out_overNight               OUT  varchar2,
    out_overNightFeeRate        OUT  number ,
    out_overNightMaxDay         OUT  number, 
    out_overNightFreeDay        OUT  number, 
    out_lossCutFree             OUT  varchar2,
    out_lossCutRateMin          OUT  number, 
    out_lostCutRateMax          OUT  number, 
    out_shortSellAllow          OUT  varchar2,
    out_bonusRate               OUT  number, 
    out_bonusCntPerMonth        OUT  number, 
    out_bonusActive             OUT  varchar2,
    out_bonusMaxMoney           OUT  number, 
    out_maxBrrwCnt              OUT  number, 
    out_maxBrrwRate             OUT  number, 
    out_maxBrrwMoney            OUT  number, 
    out_membershipDay           OUT  number, 
    out_profitInvestActive      OUT  varchar2,
    out_lossCutPcnt             OUT  number, 
    out_vipTypeId               OUT  varchar2,
    out_vipId                   OUT  varchar2,
    out_specialVip              OUT  varchar2,
    out_errorCd                 OUT  varchar2,
    out_message                 OUT  varchar2

    ) as
    
    var_userActive                 varchar2(100);
    v_userType                      varchar2(4);
    var_temp                       varchar2(100);
    var_custLossCutPcnt            number(10,4);    
    var_value0                     varchar2(40);
    var_value1                     varchar2(40);
    var_value2                     varchar2(40);
    var_value3                     varchar2(40);       
    var_overNightDefault           varchar2(1);
    var_vipIdDefault               varchar2(10);
    var_lossCutRateDefault         number(10,4); /*Default Value : 30%*/
    var_count                      number(10,0);
/******************************************************************************
   NAME:       usp_getUserPlace
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/02/22   Administrator       1. Created this procedure.
   1.01                                        1. 수수료할인Event 관련 로직 추가     
   NOTES:TEST SQL
   
        set serveroutput on;
            Declare
            
    in_userId                     varchar2(20);
    out_tradeTaxRate              number(20,4); 
    out_tradeFeeRate              number(20,4); 
    out_mgmtFeeRate               number(20,4); 
    out_closeFeeRate              number(20,4); 
    out_lossCutFeeRate            number(20,4); 
    out_overNight                 varchar2(20);
    out_overNightFeeRate          number (20,4);
    out_overNightMaxDay           number(20,4); 
    out_overNightFreeDay          number(20,4); 
    out_lossCutFree               varchar2(20);
    out_lossCutRateMin            number(20,4); 
    out_lostCutRateMax            number(20,4); 
    out_shortSellAllow            varchar2(20);
    out_bonusRate                 number(20,4); 
    out_bonusCntPerMonth          number(20,4); 
    out_bonusActive               varchar2(20);
    out_bonusMaxMoney             number(20,4); 
    out_maxBrrwCnt                number(20,4); 
    out_maxBrrwRate               number(20,4); 
    out_maxBrrwMoney              number(20,4); 
    out_membershipDay             number(20,4); 
    out_profitInvestActive        varchar2(20);
    out_lossCutPcnt               number(20,4); 
    out_vipTypeId                 varchar2(20);
    out_vipId                     varchar2(20);
    out_specialVip                varchar2(20);
    out_errorCd                   varchar2(20);
    out_message                   varchar2(200);
    BEGIN 
    in_userId :='OrgTest02';
    usp_getUserPlace(   in_userId    ,
out_tradeTaxRate    ,out_tradeFeeRate    ,
out_mgmtFeeRate    ,out_closeFeeRate    ,out_lossCutFeeRate    ,
out_overNight    ,out_overNightFeeRate    ,out_overNightMaxDay    ,
out_overNightFreeDay    ,out_lossCutFree    ,out_lossCutRateMin    ,
out_lostCutRateMax    ,out_shortSellAllow    ,out_bonusRate    ,
out_bonusCntPerMonth    ,out_bonusActive    ,out_bonusMaxMoney    ,out_maxBrrwCnt    ,
out_maxBrrwRate    ,out_maxBrrwMoney    ,out_membershipDay    ,out_profitInvestActive    ,
out_lossCutPcnt    ,out_vipTypeId    ,out_vipId    ,
out_specialVip    ,out_errorCd    ,out_message); 


    
 DBMS_OUTPUT.PUT_LINE(in_userId  ||'-out_tradeTaxRate-'||out_tradeTaxRate    ||'-out_tradeFeeRate-'|| out_tradeFeeRate    ||'-out_mgmtFeeRate-'||
out_mgmtFeeRate    ||'-out_closeFeeRate-'||out_closeFeeRate    ||'-out_lossCutFeeRate-'||out_lossCutFeeRate    ||'-out_overNight-'||out_overNight    ||'-out_overNightFeeRate-'||
out_overNightFeeRate    ||'-out_overNightMaxDay-'||out_overNightMaxDay    ||'-out_overNightFreeDay-'||out_overNightFreeDay    ||'-out_lossCutFree-'||out_lossCutFree    ||'-out_bonusCntPerMonth-'||
out_lossCutRateMin    ||'-out_lostCutRateMax-'||out_lostCutRateMax    ||'-out_shortSellAllow-'||out_shortSellAllow    ||'-out_bonusRate-'||out_bonusRate    ||'-out_bonusCntPerMonth-'||
out_bonusCntPerMonth    ||'-out_bonusActive-'||out_bonusActive    ||'-out_bonusMaxMoney-'||out_bonusMaxMoney    ||'-out_maxBrrwCnt-'||out_maxBrrwCnt    ||'-out_maxBrrwRate-'||
out_maxBrrwRate    ||'-out_maxBrrwMoney-'||out_maxBrrwMoney    ||'-out_membershipDay-'||out_membershipDay    ||'-out_profitInvestActive-'||out_profitInvestActive    ||'-out_lossCutPcnt-'||out_lossCutPcnt    ||'-out_vipTypeId-'||
out_vipTypeId    ||'-out_vipId-'||out_vipId    ||'-out_specialVip-'||out_specialVip    ||'--'||out_errorCd ||'--'||out_message);

END;

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getUserPlace
      Sysdate:         2019/02/22
      Date and Time:   2019/02/22, 오전 11:35:50, and 2019/02/22 오전 11:35:50
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN

    var_lossCutRateDefault := 30;
    var_vipIdDefault  := 'vip0';
    BEGIN
        out_tradeTaxRate := 0.0;
        out_tradeFeeRate := 0.0;
        out_mgmtFeeRate := 0.0;
        out_closeFeeRate := 0.0;
        out_lossCutFeeRate := 0.0;
        out_overNight := 'Y';
        out_overNightFeeRate := 0.0;
        out_overNightMaxDay := 0;
        out_overNightFreeDay := 0;
        out_lossCutFree := 'N';
        out_lossCutRateMin := 30;
        out_lostCutRateMax := 30;
        out_shortSellAllow := 'N';
        out_bonusRate := 0.0;
        out_bonusCntPerMonth := 0;
        out_bonusActive := 'N';
        out_bonusMaxMoney := 0.0;
        out_maxBrrwRate := 10;
        out_maxBrrwMoney := 1;
        out_membershipDay := 30;
        out_profitInvestActive  := 'N';
        out_lossCutPcnt := 30;
        out_vipTypeId  := '0001';
        out_vipId  := 'vip0';
        out_specialVip  := 'N';  
    END INITIAL;
    
   BEGIN                        /*1.고객유효성 점검*/  
        usp_checkUserActive(in_userId,var_userActive,v_userType);
        IF var_userActive = 'N' THEN                                                         
            out_errorCd := '0002';                                                          
            out_message := spr_GetErrorKRName(out_errorCd);                  
            DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);  
        END IF;
   END;
   
   BEGIN                        /*2.고객VIP등급으로 최대 대출배숫 초과 여부 확인*/
        SELECT COUNT(1) INTO var_count FROM CustVip
            WHERE userId =  in_userId;
        IF var_count = 0 THEN               /*고객의 vip등급 정보 없는 경우, vip0으로 판정*/
            out_vipId := var_vipIdDefault;
            out_specialVip := null;
        ELSE
            
            out_vipId := NULL;
            SELECT  VipId ,CASE when SvipStartDate is null  then 'N' 
                                when spr_getKorTime() >=SvipStartDate AND spr_getKorTime() <= SvipEndDate then SpecialVip 
                                else 'N' end
                   INTO  out_vipId,out_specialVip 
            FROM CustVip
                WHERE userId =  in_userId;
        END IF;
        
        SELECT TradeTaxRate, TradeFeeRate, MgmtFeeRate, CloseFeeRate, LossCutFeeRate, OverNightFeeRate, OverNightMaxDay, OverNightFreeDay, LossCutFree, LossCutRateMin, LostCutRateMax, ShortSellAllow, BonusRate, BonusCntPerMonth, BonusActive, BonusMaxMoney, MaxBrrwCnt,MaxBrrwRate, MaxBrrwMoney, MembershipDay, ProfitInvestActive, VipTypeId
                INTO out_tradeTaxRate,out_tradeFeeRate,out_mgmtFeeRate,out_closeFeeRate,out_lossCutFeeRate,out_overNightFeeRate,out_overNightMaxDay,out_overNightFreeDay,out_lossCutFree,out_lossCutRateMin,out_lostCutRateMax,out_shortSellAllow,out_bonusRate,out_bonusCntPerMonth,out_bonusActive,out_bonusMaxMoney,out_maxBrrwCnt,out_maxBrrwRate,out_maxBrrwMoney,out_membershipDay,out_profitInvestActive,out_vipTypeId
            FROM VipInfo
        WHERE VipId =  out_vipId;
        
        /*SpecialVip는 거래비용,lossCut과overNight자유설정,공매매 설정,미 결재마진재투자설정 만 적용 합*/
        IF out_specialVip is not null and out_specialVip <> 'N'  THEN
        
            SELECT case when TradeTaxRate < out_tradeTaxRate then TradeTaxRate else out_tradeTaxRate end,
                   case when TradeFeeRate < out_tradeFeeRate then TradeFeeRate else out_tradeFeeRate end,
                   case when MgmtFeeRate < out_mgmtFeeRate then MgmtFeeRate else out_mgmtFeeRate end,
                   case when CloseFeeRate < out_closeFeeRate then CloseFeeRate else out_closeFeeRate end,
                   case when OverNightFeeRate < out_overNightFeeRate then OverNightFeeRate else out_overNightFeeRate end,
                   case when OverNightMaxDay > out_overNightMaxDay then OverNightMaxDay else out_overNightMaxDay end,
                   case when OverNightFreeDay > out_overNightFreeDay then OverNightFreeDay else out_overNightFreeDay end,
                   case when ShortSellAllow = 'Y' then 'Y' else out_shortSellAllow end,
                   case when MaxBrrwCnt > out_maxBrrwCnt then MaxBrrwCnt else out_maxBrrwCnt end,
                   case when MaxBrrwRate > out_maxBrrwRate then MaxBrrwRate else out_maxBrrwRate end,
                   case when ProfitInvestActive = 'Y' then 'Y' else out_profitInvestActive end,
                   case when LossCutFree = 'Y' then 'Y' else out_lossCutFree end,
                   case when LossCutRateMin < out_lossCutRateMin then LossCutRateMin else out_lossCutRateMin end ,
                   case when LostCutRateMax >out_lostCutRateMax then LostCutRateMax else out_lostCutRateMax end    
              into out_tradeTaxRate,out_tradeFeeRate,out_mgmtFeeRate,out_closeFeeRate,out_overNightFeeRate,out_overNightMaxDay
                      ,out_overNightFreeDay,out_shortSellAllow,out_maxBrrwCnt,out_maxBrrwRate,out_profitInvestActive,out_lossCutFree,out_lossCutRateMin,out_lostCutRateMax
                FROM VipInfo
            WHERE VipId =  out_specialVip;
        END IF;
             
   END;
   
   
   BEGIN                        /*3.Option Setting과 Custem Setting 값으로 update 함 */
        
       BEGIN                    /*3.1 LOSSCUT*/
            usp_getOperationSetting('LossCutPcnt',var_temp,var_value1,var_value2,var_value3);    
            out_lossCutPcnt := to_number(var_temp);
                               
            usp_getUserSetting(in_userId,'LossCutPcnt',var_temp);        
            var_custlossCutPcnt := to_number(var_temp);  
            IF out_lossCutFree = 'Y' AND var_custlossCutPcnt IS NULL  THEN
                out_lossCutPcnt := var_custlossCutPcnt;
            END IF;
            IF out_lossCutPcnt IS NULL THEN
                out_lossCutPcnt := var_lossCutRateDefault;
            END IF;
        END;
        
       BEGIN                    /*3.2 shortSellAllow*/
            usp_getOperationSetting('ShortSellAllow',var_value0,var_value1,var_value2,var_value3);    
            SELECT decode(var_value0,'N','N',out_shortSellAllow) INTO out_shortSellAllow FROM DUAL;
            IF out_shortSellAllow IS NULL THEN
                out_shortSellAllow := 'N';
            END IF;    
       END;
        
       BEGIN                    /*3.3 ProfitInvestActive*/
            usp_getOperationSetting('ProfitInvestActive',var_value0,var_value1,var_value2,var_value3);    
            usp_getUserSetting(in_userId,'ProfitInvestActive',var_value3);
            
            IF var_value0 = 'Y' AND var_value3 = 'Y' AND out_profitInvestActive = 'Y' THEN
                out_profitInvestActive := 'Y';           
            ELSE
                out_profitInvestActive := 'N';           
            END IF;
            
            IF out_profitInvestActive IS NULL THEN
                out_profitInvestActive := 'N';
            END IF;
       END;
        
       BEGIN                    /*3.4 OverNight*/
            usp_getOperationSetting('OverNight',var_temp,var_value1,var_value2,var_value3);
            IF var_temp IS NULL THEN
                var_overNightDefault := 'Y';
            ELSE
                var_overNightDefault := var_temp;
            END IF;
            
            
            usp_getUserSetting(in_userId,'OverNight',out_overNight);
            IF var_overNightDefault = 'Y' AND out_overNight IS NOT NULL THEN
                out_overNight := out_overNight ;
            ELSE
                out_overNight := 'N' ;        
            END IF;  
          
       END;
       
       BEGIN   
            usp_getOperationSetting('BonusModeActive',var_temp,var_value1,var_value2,var_value3);
            IF var_temp IS NULL OR var_temp = 'N' THEN
                out_bonusActive := 'N';            
            END IF;                  
       
       END ;
        
   END;
  
   out_errorCd := '0000';                                                          
   out_message := spr_GetErrorKRName(out_errorCd);   
   /*DBMS_OUTPUT.PUT_LINE('ErrorCd：' || out_errorCd || ' Message:' || out_message);*/  
   EXCEPTION
     WHEN NO_DATA_FOUND THEN     
       out_errorCd := '0001';
       out_message := spr_GetErrorKRName(out_errorCd);
     WHEN OTHERS THEN
       ROLLBACK; 
       out_errorCd := '0200';
       out_message := spr_GetErrorKRName(out_errorCd) || SQLERRM;
       DBMS_OUTPUT.PUT_LINE('usp_getUserPlace 실행 시 에러발생');
       RAISE;
END usp_getUserPlace;

create or replace PROCEDURE          usp_getUserSetting
(
  in_userid     IN varchar2,
  in_configName IN varchar2,
  out_value     OUT varchar2
) IS

/******************************************************************************
   NAME:       usp_getUserSetting
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019/03/01   sjh-home       1. Created this procedure.

   NOTES:TEST SQL
        set serveroutput on;
        Declare
        in_userid varchar2(100);
        in_configName varchar2(100);
        out_value varchar2(100);
        begin
        in_userid := 'OrgTest01';
        in_configName := 'LossCutPcnt';
        usp_getUserSetting(in_userid,in_configName,out_value);
        DBMS_OUTPUT.PUT_LINE('LossCutPcnt：' || out_value);
        end;
        
        SELECT * FROM CustSetting

   Automatically available Auto Replace Keywords:
      Object Name:     usp_getUserSetting
      Sysdate:         2019/03/01
      Date and Time:   2019/03/01, 오전 11:05:23, and 2019/03/01 오전 11:05:23
      Username:        sjh-home (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
    out_value := NULL;    
    
    SELECT DECODE( COUNT(ConfigValue),0,NULL,MAX(ConfigValue)) INTO out_value
        FROM CustSetting
    WHERE UserId = in_userId AND ConfigName = in_configName;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('usp_getUserSetting  UserID '||in_userId|| ' Conf '||in_configName||' NO_DATA_FOUND !'); 
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_getUserSetting;

create or replace PROCEDURE usp_procClosePosition 
(
in_newOrderAmt          IN      number, 
in_newPrice             IN      number,

in_amtRecord            IN      varchar2, 
in_closeRecord          IN      varchar2, 
in_priceRecord          IN      varchar2, 
in_positionType         IN      varchar2,
out_closeRecord         OUT     varchar2,
out_releaseMoney        OUT     number,
out_releaseProfit       OUT     number
)       
IS
    v_newOrderAmt number(20,3);
    v_tmpAmt number(20,3);
    v_tmpClose number(21,2);
    v_tmpPrice number(21,2);
    v_pos1 number(5,0);
    v_pos2 number(5,0);
    v_pos3 number(5,0);
    v_priceRecordBck varchar2(200);
    v_amtRecordBck varchar2(200);
    v_closeRecordBck varchar2(200);
/******************************************************************************
   NAME:       usp_procClosePosition
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019-03-05   Administrator       1. Created this procedure.

   NOTES:TEST SQL
   
set serveroutput on;
Declare
        
in_newOrderAmt          number(20,3); 
in_newPrice             number(20,2);

in_amtRecord            varchar2(200); 
in_closeRecord          varchar2(200); 
in_priceRecord          varchar2(200); 
in_positionType         varchar2(4); 
out_closeRecord         varchar2(200); 
out_releaseMoney        number(21,2);
out_releaseProfit       number(21,2); 

BEGIN  
in_newOrderAmt  := 20 ;
in_newPrice     :=2.5 ;
                
in_amtRecord    :='30|23|' ;
in_closeRecord  :='15|3|' ;
in_priceRecord  :='2.1|3.43|';
in_positionType := '0002';
usp_procClosePosition(in_newOrderAmt ,in_newPrice  ,in_amtRecord,in_closeRecord,in_priceRecord,in_positionType,out_closeRecord,out_releaseMoney,out_releaseProfit);
DBMS_OUTPUT.PUT_LINE(out_closeRecord ||'=='|| out_releaseMoney||'=='|| out_releaseProfit);
   
END;
   
END;

   Automatically available Auto Replace Keywords:
      Object Name:     usp_procClosePosition
      Sysdate:         2019-03-05
      Date and Time:   2019-03-05, 오후 3:26:06, and 2019-03-05 오후 3:26:06
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   
    
    
    out_closeRecord := '';        
    v_tmpAmt := 0 ;
    v_tmpClose := 0;
    v_tmpPrice := 0;
    out_releaseMoney := 0 ;
    out_releaseProfit := 0 ;
    
    v_priceRecordBck := in_priceRecord;
    v_amtRecordBck := in_amtRecord;
    v_closeRecordBck := in_closeRecord;
    v_newOrderAmt := in_newOrderAmt;
    
    IF ( in_newOrderAmt is null or in_newOrderAmt <=0) THEN
            return;
    END IF;
            
    WHILE (instr(v_priceRecordBck,'|',1,1) >0 ) LOOP
       
        
        v_pos1 := instr(v_amtRecordBck,'|',1,1) ;
        v_tmpAmt := to_number(substr(v_amtRecordBck,1,v_pos1 - 1));
                
        v_pos2 := instr(v_closeRecordBck,'|',1,1) ;
        v_tmpClose := to_number(substr(v_closeRecordBck,1,v_pos2 - 1));
       
        v_pos3 := instr(v_priceRecordBck,'|',1,1) ;
        v_tmpPrice := to_number(substr(v_priceRecordBck,1,v_pos3 - 1));
               
        IF  v_tmpClose < v_tmpAmt  THEN
            IF (v_tmpAmt - v_tmpClose) >= v_newOrderAmt THEN
                 out_releaseMoney := out_releaseMoney + v_newOrderAmt * v_tmpPrice;
                 IF in_positionType = '0001' THEN
                    out_releaseProfit := out_releaseProfit + v_newOrderAmt * (in_newPrice -  v_tmpPrice);
                 ELSE
                    out_releaseProfit := out_releaseProfit + v_newOrderAmt * (v_tmpPrice - in_newPrice );
                 END IF;
                 out_closeRecord := out_closeRecord || to_char(v_tmpClose + v_newOrderAmt) || '|'|| substr(v_closeRecordBck,v_pos2 +1 );                
                 return;            
            ELSE
                 out_releaseMoney := out_releaseMoney + (v_tmpAmt - v_tmpClose) * v_tmpPrice;                
                   
                 IF in_positionType = '0001' THEN
                    out_releaseProfit := out_releaseProfit + (v_tmpAmt - v_tmpClose) * (in_newPrice -  v_tmpPrice); 
                 ELSE
                    out_releaseProfit := out_releaseProfit + (v_tmpAmt - v_tmpClose) * (v_tmpPrice-  in_newPrice); 
                 END IF;
                 
                 out_closeRecord := out_closeRecord || v_tmpAmt || '|';
                
                 v_amtRecordBck := substr(v_amtRecordBck,v_pos1 +1 );
                 v_closeRecordBck := substr(v_closeRecordBck,v_pos2 +1 );
                 v_priceRecordBck := substr(v_priceRecordBck,v_pos3 +1 );                
                 v_newOrderAmt := v_newOrderAmt - (v_tmpAmt - v_tmpClose);
            END IF;
        ELSE
             out_closeRecord := out_closeRecord || v_tmpClose || '|';
             v_closeRecordBck := substr(v_closeRecordBck,v_pos2 +1 );
            
        END IF;
        
      
               
    END LOOP;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_procClosePosition;

create or replace PROCEDURE          usp_sortOrderRecord
(        
in_sortType             IN      varchar2, 
in_orderRecord          IN      varchar2, 
in_amtRecord            IN      varchar2, 
in_closeRecord          IN      varchar2, 
in_priceRecord          IN      varchar2, 
in_newOrderAmt          IN      varchar2, 
in_newPrice             IN      varchar2, 
in_newOrderId           IN      varchar2, 
out_orderRecord         OUT     varchar2,
out_amtRecord           OUT     varchar2,
out_closeRecord         OUT     varchar2,
out_priceRecord         OUT     varchar2 

         )
         
IS

/******************************************************************************
   NAME:       usp_sortOrderRecord
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2019-03-05   Administrator       1. Created this procedure.

   NOTES: TEST SQL
   
          set serveroutput on;
        Declare
        in_sortType                 varchar(4);        
        in_orderRecord             varchar(400);
        in_amtRecord                 varchar(400);
        in_closeRecord             varchar(400);
        in_priceRecord             varchar(400);
        in_newOrderAmt             varchar(40);        
        in_newPrice                 varchar(40);
        in_newOrderId             varchar(40);
        out_orderRecord         varchar(400);
        out_amtRecord             varchar(400);
        out_closeRecord         varchar(400);
        out_priceRecord         varchar(400);
        
        begin
         
                  
         in_sortType := '0003';
         
         in_orderRecord :='01|02|';                  
         in_amtRecord :='200|300|';
         in_priceRecord :='3.224|32.224|';
         in_closeRecord :='20|10|';
         
         in_newOrderAmt :='3';         
         in_newPrice :='13.223';
         in_newOrderId :='3';
         
         
        
        
         
         usp_sortOrderRecord(in_sortType  ,in_orderRecord  ,in_amtRecord,in_closeRecord,in_priceRecord,in_newOrderAmt,in_newPrice,in_newOrderId,out_orderRecord,out_amtRecord,out_closeRecord,out_priceRecord);
        DBMS_OUTPUT.PUT_LINE(out_orderRecord ||'=='|| out_amtRecord||'=='|| out_closeRecord||'=='|| out_priceRecord);
  
        end;,


   Automatically available Auto Replace Keywords:
      Object Name:     usp_sortOrderRecord
      Sysdate:         2019-03-05
      Date and Time:   2019-03-05, 오전 9:13:08, and 2019-03-05 오전 9:13:08
      Username:        Administrator (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/


    v_tmpAmt varchar(100);
    v_tmpClose varchar(100);
    v_tmpPrice varchar(100);
    v_tmpOrder varchar(100);
    
    v_orderRecordBck varchar(400);
    v_priceRecordBck varchar(400);
    v_amtRecordBck varchar (400);
    v_closeRecordBck varchar(400);
    
    v_pos1 number(10,0);
    v_pos2 number(10,0);
    v_pos3 number(10,0);
    v_pos4 number(10,0);
    
            
BEGIN
   out_orderRecord := '';
   out_amtRecord     := '';
   out_closeRecord := '';
   out_priceRecord := '';
   IF in_sortType = '0001'THEN
         out_amtRecord := in_amtRecord || in_newOrderAmt ||'|';
         out_closeRecord := in_closeRecord || '0|';
         out_priceRecord := in_priceRecord  || in_newPrice ||'|';
         out_orderRecord := in_orderRecord  || in_newOrderId || '|';   
   ELSIF in_sortType = '0002'THEN
        out_amtRecord := in_newOrderAmt||'|'||in_amtRecord ;
        out_closeRecord := '0|'|| in_closeRecord ;
        out_priceRecord := in_newPrice||'|'|| in_priceRecord;  
        out_orderRecord := in_newOrderId||'|'||in_orderRecord;
   ELSIF in_sortType = '0003'THEN
        
            v_tmpAmt := '';
            v_tmpClose := '';
            v_tmpPrice := '';
            v_tmpOrder := '';
            v_priceRecordBck := in_priceRecord;
            v_amtRecordBck := in_amtRecord;
            v_closeRecordBck := in_closeRecord;
            v_orderRecordBck := in_orderRecord;
           
            WHILE (instr(v_priceRecordBck,'|',1,1) > 0) LOOP
                v_pos1 := instr(v_priceRecordBck,'|',1,1) ;
                v_tmpPrice := substr(v_priceRecordBck,1,v_pos1 - 1);
                
                v_pos2 := instr(v_amtRecordBck,'|',1,1) ;
                v_tmpAmt := substr(v_amtRecordBck,1,v_pos2 - 1);
                
                v_pos3 := instr(v_closeRecordBck,'|',1,1) ;
                v_tmpClose := substr(v_closeRecordBck,1,v_pos3 - 1);
                
                v_pos4 := instr(v_orderRecordBck,'|',1,1) ;
                v_tmpOrder := substr(v_orderRecordBck,1,v_pos4 - 1);
                IF to_number(in_newPrice ) > to_number(v_tmpPrice) THEN
                   out_priceRecord := out_priceRecord || in_newPrice|| '|'|| v_priceRecordBck;
                   v_priceRecordBck := '';
                   
                   out_amtRecord := out_amtRecord || in_newOrderAmt|| '|'|| v_amtRecordBck;
                   v_amtRecordBck := '';
                   
                   out_closeRecord := out_closeRecord || '0|'|| v_closeRecordBck;
                   v_closeRecordBck := '';
                   
                   
                   out_orderRecord := out_orderRecord ||  in_newOrderId|| '|' ||  v_orderRecordBck;
                   v_orderRecordBck := '';
                  
                  
                ELSE
                    out_priceRecord := out_priceRecord || v_tmpPrice || '|';
                    v_priceRecordBck := substr(v_priceRecordBck,v_pos1 +1 );
                    
                    out_amtRecord := out_amtRecord || v_tmpAmt || '|';
                    v_amtRecordBck := substr(v_amtRecordBck,v_pos2 +1 );
                    
                    out_closeRecord := out_closeRecord || v_tmpClose || '|';
                    v_closeRecordBck := substr(v_closeRecordBck,v_pos3 +1 );
                    
                    out_orderRecord := out_orderRecord || v_tmpOrder || '|';
                    v_orderRecordBck := substr(v_orderRecordBck,v_pos4 +1 );
                END IF;
               
            END LOOP;
            
            IF in_priceRecord IS NULL THEN  
                DBMS_OUTPUT.PUT_LINE('in_priceRecord IS NULL OR Empty') ;            
                out_priceRecord := in_priceRecord ||  in_newPrice || '|';
                out_amtRecord :=   in_amtRecord ||  in_newOrderAmt || '|';
                out_closeRecord := in_closeRecord ||  '0|';
                out_orderRecord := in_orderRecord ||  in_newOrderId || '|';
            END IF; 
           
   ELSIF in_sortType = '0004'THEN
        
            v_tmpAmt := '';
            v_tmpClose := '';
            v_tmpPrice := '';
            v_tmpOrder := '';
            v_priceRecordBck := in_priceRecord;
            v_amtRecordBck := in_amtRecord;
            v_closeRecordBck := in_closeRecord;
            v_orderRecordBck := in_orderRecord;
            
            WHILE (instr(v_priceRecordBck,'|',1,1) > 0) LOOP
                 v_pos1 := instr(v_priceRecordBck,'|') ;
                 v_tmpPrice := substr(v_priceRecordBck,1,v_pos1 - 1);
                
                 v_pos2 := instr(v_amtRecordBck,'|') ;
                 v_tmpAmt := substr(v_amtRecordBck,1,v_pos2 - 1);
                
                 v_pos3 := instr(v_closeRecordBck,'|') ;
                 v_tmpClose := substr(v_closeRecordBck,1,v_pos3 - 1);
                
                 v_pos4 := instr(v_orderRecordBck,'|') ;
                 v_tmpOrder := substr(v_orderRecordBck,1,v_pos4 - 1);
                
                IF to_number(in_newPrice) < to_number(v_tmpPrice ) THEN
                    out_priceRecord := out_priceRecord || in_newPrice || '|' || v_priceRecordBck;
                    v_priceRecordBck := '';
                   
                    out_amtRecord := out_amtRecord || in_newOrderAmt || '|'|| v_amtRecordBck;
                    v_amtRecordBck := '';
                   
                    out_closeRecord := out_closeRecord || '0|' || v_closeRecordBck;
                    v_closeRecordBck := '';
                   
                    out_orderRecord := out_orderRecord || in_newOrderId || '|' || v_orderRecordBck;
                    v_orderRecordBck := '';
                  
                ELSE
                     out_priceRecord := out_priceRecord || v_tmpPrice || '|';
                     v_priceRecordBck := substr(v_priceRecordBck,v_pos1 +1 );
                    
                     out_amtRecord := out_amtRecord || v_tmpAmt ||'|';
                     v_amtRecordBck := substr(v_amtRecordBck,v_pos2 +1 );
                    
                     out_closeRecord := out_closeRecord || v_tmpClose || '|';
                     v_closeRecordBck := substr(v_closeRecordBck,v_pos3 +1 );
                    
                     out_orderRecord := out_orderRecord || v_tmpOrder || '|';
                     v_orderRecordBck := substr(v_orderRecordBck,v_pos4 +1 );
                END IF;
               
            END LOOP;
           
            IF in_priceRecord IS NULL  THEN
                DBMS_OUTPUT.PUT_LINE('in_priceRecord IS NULL OR Empty') ;            
                out_priceRecord := in_priceRecord ||  in_newPrice || '|';
                out_amtRecord :=   in_amtRecord ||  in_newOrderAmt || '|';
                out_closeRecord := in_closeRecord ||  '0|';
                out_orderRecord := in_orderRecord ||  in_newOrderId || '|';
            END IF;
   END IF;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END usp_sortOrderRecord;