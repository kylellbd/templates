var Main = function() {
    var makeTable_1_1 = function() {
        var table_1 = $("#myPositionPT").find('#table_1_1').bootstrapTable({
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            uniqueId: "no", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            columns: [{
                field: 'selectItem',
                checkbox: true,
                align: "center"
            }, {
                field: 'ID',
                title: '주문번호',
                align: "center"
            }, {
                field: 'MarketId',
                title: 'Market',
                align: "center"
            }, {
                field: 'ItemId',
                title: '종목명',
                align: "center"
            }, {
                field: 'OpenCloseType',
                title: 'Position상태 구분',
                align: "center"
            }, {
                field: 'PlaceType',
                title: '거래자금유형',
                align: "center"
            }, {
                field: 'PositionType',
                title: '포지션타입',
                align: "center"
            }, {
                field: 'OrderType',
                title: '지정가/시장가구분',
                align: "center"
            }, {
                field: 'TradeType',
                title: '주문유형',
                align: "center"
            }, {
                field: 'OrderAmt',
                title: '수량',
                align: "center"
            }, {
                field: 'OrderPrice',
                title: '가격',
                align: "center"
            }, {
                field: 'OrderTime',
                title: '주문시간',
                align: "center"
            }],
            data: table_1_1_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };


    var table_1_1_Sample = [{
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "OrderTime": ""
        },

    ];

    var makeTable_1_2 = function() {
        var table_2 = $("#myPositionPT").find('#table_1_2').bootstrapTable({
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            uniqueId: "no", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            columns: [{
                field: 'ExecuteDate',
                title: '처리시간',
                align: "center"
            }, {
                field: 'ID',
                title: '주문번호',
                align: "center"
            }, {
                field: 'MarketId',
                title: 'Market',
                align: "center"
            }, {
                field: 'ItemId',
                title: '종목명',
                align: "center"
            }, {
                field: 'PlaceType',
                title: '거래자금유형',
                align: "center"
            }, {
                field: 'PositionType',
                title: '포지션타입',
                align: "center"
            }, {
                field: 'OrderType',
                title: '지정가/시장가구분',
                align: "center"
            }, {
                field: 'TradeType',
                title: '주문유형',
                align: "center"
            }, {
                field: 'Sts',
                title: '상태',
                align: "center"
            }, {
                field: 'OrderAmt',
                title: '주문량',
                align: "center"
            }, {
                field: 'ExcecuteAmt',
                title: '체결량',
                align: "center"
            }, {
                field: 'OrderPrice',
                title: '주문가',
                align: "center"
            }, {
                field: 'ExecutePrice',
                title: '체결가',
                align: "center"
            }, {
                field: 'Profit',
                title: '손익',
                align: "center"
            }, {
                field: 'TradeTax',
                title: '거래세',
                align: "center"
            }, {
                field: 'MgmtFee',
                title: '취급수수료',
                align: "center"
            }, {
                field: 'TradeFee',
                title: '거래수수료',
                align: "center"
            }, {
                field: 'CloseFee',
                title: '마감수수료',
                align: "center"
            }, {
                field: 'LossCutFee',
                title: '로스컷수수료',
                align: "center"
            }, {
                field: 'oevernight',
                title: '오버나잇수수료',
                align: "center"
            }, {
                field: 'allProfit',
                title: '총손익',
                align: "center"
            }, {
                field: 'executeBy',
                title: '호출',
                align: "center"
            }],
            data: table_1_2_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };
    var table_1_2_Sample = [{
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
        {
            "ID": "1000123891",
            "MarketId": "코스피",
            "ItemId": "SK하이닉스",
            "OpenCloseType": "open",
            "PlaceType": "마진",
            "PositionType": "공",
            "OrderType": "시장가",
            "TradeType": "매도",
            "OrderAmt": "",
            "OrderPrice": "",
            "ExecuteDate": "2019.01.01 12:30",
            "Sts": "체결",
            "ExcecuteAmt": "",
            "ExecutePrice": "",
            "Profit": "311,203",
            "TradeTax": "1,500",
            "MgmtFee": "1,500",
            "TradeFee": "1,500",
            "CloseFee": "1,500",
            "LossCutFee": "1,500",
            "oevernight": "1,500",
            "allProfit": "288,203",
            "executeBy": "사용자"
        },
    ];

    var makeTable_1_3 = function() {
        var table_3 = $("#myPositionPT").find('#table_1_3').bootstrapTable({
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            uniqueId: "no", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            columns: [{
                title: "스톱설정",
                field: "PositionSeq",
                align: "center",
                formatter: function(value, row, index) {
                    var btnNm = "";
                    if (index % 2 == 1) {
                        btnNm = "세&nbsp;&nbsp;&nbsp;팅";
                    } else {
                        btnNm = "재세팅";
                    }
                    return '<button type="button" class="btn green-haze btn-outline sbold uppercase">' + btnNm + '</button>';
                }
            }, {
                field: 'MarketId',
                title: 'Market',
                align: "center"
            }, {
                field: 'ItemId',
                title: '종목명',
                align: "center"
            }, {
                field: 'PlaceType',
                title: '거래자금유형',
                align: "center"
            }, {
                field: 'PositionType',
                title: '포지션타입',
                align: "center"
            }, {
                field: 'OpenOrderId',
                title: '주문번호',
                align: "center"
            }, {
                field: 'OpenDate',
                title: '생성일자',
                align: "center"
            }, {
                field: 'OpenTime',
                title: '생성시간',
                align: "center"
            }, {
                field: 'AvgPrice',
                title: '평균가격',
                align: "center"
            }, {
                field: 'HoldAmt',
                title: 'HoldAmt',
                align: "center"
            }, {
                field: 'Locked',
                title: 'Locked',
                align: "center"
            }, {
                field: 'AddupOpenAmt',
                title: 'AddupOpenAmt',
                align: "center"
            }, {
                field: 'AddupOpenMoney',
                title: 'AddupOpenMoney',
                align: "center"
            }, {
                field: 'AddupCloseAmt',
                title: 'AddupCloseAmt',
                align: "center"
            }, {
                field: 'AddupCloseMoney',
                title: 'AddupCloseMoney',
                align: "center"
            }, {
                field: 'AddupGuarantee',
                title: 'AddupGuarantee',
                align: "center"
            }, {
                field: 'AddMarginPlace',
                title: 'AddMarginPlace',
                align: "center"
            }, {
                field: 'OpenOrderCnt',
                title: 'OpenOrderCnt',
                align: "center"
            }, {
                field: 'AddupReturnMoney',
                title: 'AddupReturnMoney',
                align: "center"
            }, {
                field: 'AddupReturnProfit',
                title: 'AddupReturnProfit',
                align: "center"
            }, {
                field: 'MgmtLock',
                title: 'MgmtLock',
                align: "center"
            }],
            data: table_1_3_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_1_3_Sample = [{
        "MarketId": "코스피",
        "ItemId": "SK하이닉스",
        "PlaceType": "대출",
        "PositionType": "다",
        "OpenOrderId": "129371298",
        "OpenDate": "2019.01.08",
        "OpenTime": "13:12:26",
        "AvgPrice": "1202.2",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }, {
        "MarketId": "코스피",
        "ItemId": "삼성전자",
        "PlaceType": "마진",
        "PositionType": "공",
        "OpenOrderId": "129371300",
        "OpenDate": "2019.01.19",
        "OpenTime": "10:15:26",
        "AvgPrice": "80500.0",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }, {
        "MarketId": "코스피",
        "ItemId": "SK하이닉스",
        "PlaceType": "대출",
        "PositionType": "다",
        "OpenOrderId": "129371298",
        "OpenDate": "2019.01.08",
        "OpenTime": "13:12:26",
        "AvgPrice": "1202.2",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }, {
        "MarketId": "코스피",
        "ItemId": "삼성전자",
        "PlaceType": "마진",
        "PositionType": "공",
        "OpenOrderId": "129371300",
        "OpenDate": "2019.01.19",
        "OpenTime": "10:15:26",
        "AvgPrice": "80500.0",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }, {
        "MarketId": "코스피",
        "ItemId": "SK하이닉스",
        "PlaceType": "대출",
        "PositionType": "다",
        "OpenOrderId": "129371298",
        "OpenDate": "2019.01.08",
        "OpenTime": "13:12:26",
        "AvgPrice": "1202.2",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }, {
        "MarketId": "코스피",
        "ItemId": "삼성전자",
        "PlaceType": "마진",
        "PositionType": "공",
        "OpenOrderId": "129371300",
        "OpenDate": "2019.01.19",
        "OpenTime": "10:15:26",
        "AvgPrice": "80500.0",
        "HoldAmt": "",
        "Locked": "N",
        "AddupOpenAmt": "",
        "AddupOpenMoney": "",
        "AddupCloseAmt": "",
        "AddupCloseMoney": "",
        "AddupGuarantee": "",
        "AddMarginPlace": "",
        "OpenOrderCnt": "",
        "AddupReturnMoney": "",
        "MgmtLock": "N"
    }];


    var makeTable_1_5 = function() {
        var table_5 = $("#myPositionPT").find('#table_1_5').bootstrapTable("destroy").bootstrapTable({
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            uniqueId: "no", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            columns: [{
                field: 'ProfitDate',
                title: '일자',
                align: "center"
            }, {
                field: 'Profit',
                title: '손익',
                align: "center"
            }, {
                field: 'TradeTax',
                title: '거래세',
                align: "center"
            }, {
                field: 'MgmtFee',
                title: '취급수수료',
                align: "center"
            }, {
                field: 'TradeFee',
                title: '거래수수료',
                align: "center"
            }, {
                field: 'CloseFee',
                title: '마감수수료',
                align: "center"
            }, {
                field: 'LossCutFee',
                title: '로스컷수수료',
                align: "center"
            }, {
                field: 'oevernight',
                title: '오버나잇수수료',
                align: "center"
            }, {
                field: 'allProfit',
                title: '총손익',
                align: "center"
            }, {
                field: 'allFee',
                title: '총수수료',
                align: "center"
            }, {
                field: 'allMoney',
                title: '합계',
                align: "center"
            }],
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
        return table_5;
    };

    var table_1_5_Sample = [{
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }, {
        "ProfitDate": "2019.03.15",
        "Profit": "10,312,305",
        "TradeTax": "1,520",
        "MgmtFee": "1,520",
        "TradeFee": "1,520",
        "CloseFee": "1,520",
        "LossCutFee": "1,520",
        "oevernight": "1,520",
        "allProfit": "10,312,305",
        "allFee": "9,580",
        "allMoney": ""
    }];


    return {
        init: function() {
            makeTable_1_1();
            makeTable_1_2();
            makeTable_1_3();
            makeTable_1_5();
        },
        searchProfitByDate: function() {
            makeTable_1_5();
            $("#myPositionPT").find('#table_1_5').bootstrapTable("append", table_1_5_Sample);
        }
    };
}();

jQuery(document).ready(function() {
    Main.init();

    $(".ProfitSearch").on("click", function() {

        Main.searchProfitByDate();

    });
});