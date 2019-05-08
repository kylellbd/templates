var Assets = function() {


    var make_table_assets_1 = function() {
        var tab_assets_1 = $("#tab_assets").find('#table_assets_1').bootstrapTable({
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
            data: table_assets_1_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_assets_1_Sample = [{
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
    }];
    var make_table_assets_2 = function() {
        var table_assets_2 = $("#tab_assets").find('#table_assets_2').bootstrapTable({
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
            data: table_assets_2_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };
    var table_assets_2_Sample = [{
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



    var make_table_deposit = function() {
        var header = Comm.getPostHeader();
        header.crossDomain = true;

        var table_deposit = $("#tab_deposit").find('#table_deposit').bootstrapTable("destroy").bootstrapTable({
            url: 'http://62.234.152.219:90/api/DepositWithDraw/QueryDepositOrWithDraw', // 请求后台的URL（*）
            method: 'post', // 请求方式（*）
            dataType: 'json',
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            sidePagination: "client", // 分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1, // 初始化加载第一页，默认第一页
            pageSize: 10, // 每页的记录行数（*）
            pageList: [10, 25, 50, 100], // 可供选择的每页的行数（*）
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            uniqueId: "ACCESSSEQ", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: false, // 是否显示父子表
            ajaxOptions: {
                headers: header
            },
            queryParams: function(params) {
                return {
                    userId: header.user,
                    balanceType: $("#tab_deposit").find('.balanceType').val(),
                    sts: $("#tab_deposit").find('.sts').val(),
                    startDate: $("#tab_deposit").find('.from').val(),
                    endDate: $("#tab_deposit").find('.to').val()
                }
            },
            columns: [{
                field: 'REQUESTTIME',
                title: '신청일시',
                align: "center"
            }, {
                field: 'EXECUTETIME',
                title: '승인일시',
                align: "center"
            }, {
                field: 'BALANCETYPE',
                title: '입금/출금구분',
                align: "center"
            }, {
                field: 'REQUESTMONEY',
                title: '신청금액',
                align: "center"
            }, {
                field: 'EXECUTEMONEY',
                title: '처리금액',
                align: "center"
            }, {
                field: 'MGMTUSERID',
                title: '처리자',
                align: "center"
            }, {
                field: 'BANKNAME',
                title: '은행',
                align: "center"
            }, {
                field: 'ACCOUNTNO',
                title: '은행계좌',
                align: "center"
            }, {
                field: 'ACCOUNTNAME',
                title: '예금주',
                align: "center"
            }, {
                field: 'MGMTMEMO',
                title: '비고',
                align: "center"
            }],
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            },
            responseHandler: function(res) {
                var returnDatas = res.data;
                returnDatas.each(function(index, item) {
                    item.BANKNAME = item.BANKTO.BANKNAME;
                    item.ACCOUNTNO = item.BANKTO.ACCOUNTNO;
                    item.ACCOUNTNANE = item.BANKTO.ACCOUNTNANE;
                });

                return returnDatas;
            },
        });
        return table_deposit;
    };



    var make_table_loan_2 = function() {
        var table_load_2 = $("#tab_loan").find('#table_loan_2').bootstrapTable("destroy").bootstrapTable({
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
                field: 'BrrwRate',
                title: '대출뱃수',
                align: "center"
            }, {
                field: 'AddupPrincipalGuarantee',
                title: '대출담보금',
                align: "center"
            }, {
                field: 'LossCutMoney',
                title: '로스컷 금액',
                align: "center"
            }, {
                field: 'allProfitRate',
                title: '총손율(실행+평가)',
                align: "center"
            }, {
                field: 'LossCutRate',
                title: '로스컷 비율',
                align: "center"
            }, {
                field: 'BrrwCount',
                title: '보유 포지션 수량',
                align: "center"
            }, {
                field: 'BrrwId',
                align: "center",
                title: 'Action',
                formatter: function(value, row, index) {
                    return '<a class="btn green-haze btn-outline sbold uppercase dark" data-target="#static" data-toggle="modal">반환</a>';
                }
            }],
            data: table_loan_2_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_loan_2_Sample = [{
        "BrrwRate": "10",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, {
        "BrrwRate": "7",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, {
        "BrrwRate": "5",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, {
        "BrrwRate": "15",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "",
        "LossCutRate": "",
        "BrrwCount": "",
        "BrrwId": "123123"
    }, ];

    function getMyBankInfo() {
        var header = Comm.getHeader();
        header.userId = header.user;
        var settings = {
            "async": false,
            "crossDomain": true,
            "url": "http://62.234.152.219:90/api/User/GetUserBankList",
            "method": "GET",
            "headers": header
        }

        $.ajax(settings).done(function(response) {
            console.log(response);
            if (response.Result == 0) {
                var banks = response.Data;
                if (banks.length > 0) {
                    setMyBankData(banks);
                }

            }
        });
    }

    function setMyBankData(banks) {
        Comm.setItemsData($('#bankForm'), banks[0]);
    }

    return {
        init: function() {
            make_table_assets_1();
            make_table_assets_2();
            make_table_deposit();
            // make_table_encashment();
            // make_table_loan_1();
            make_table_loan_2();
        },
        searchRechargeByDate: function() {
            $("#tab_deposit").find('#table_deposit').bootstrapTable("refresh");
        },
        // searchEncashmentByDate: function() {
        //     make_table_encashment();
        //     $("#tab_encashment").find('#table_encashment').bootstrapTable("append", table_encashment_Sample);
        // },
        resetRechageCondition: function() {

            $("#tab_deposit").find('.from').val("");
            $("#tab_deposit").find('.to').val("");
            $("#tab_deposit").find('.balanceType').val("");
            $("#tab_deposit").find('.sts').val("");
        }
    };
}();

jQuery(document).ready(function() {
    Assets.init();
    $(".DepositSearch").on("click", function() {

        Assets.searchRechargeByDate();

    });
    $(".EncashmentSearch").on("click", function() {

        // Assets.searchEncashmentByDate();

    });

    $(".DepositReset").on("click", function() {

        Assets.resetRechageCondition();

    });



});