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



    var make_table_recharge = function() {
        var table_recharge = $("#tab_recharge").find('#table_recharge').bootstrapTable("destroy").bootstrapTable({
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
                field: 'RequestTime',
                title: '신청일시',
                align: "center"
            }, {
                field: 'ExecuteTime',
                title: '승인일시',
                align: "center"
            }, {
                field: 'RequestMoney',
                title: '신청금액',
                align: "center"
            }, {
                field: 'ExecuteMoney',
                title: '처리금액',
                align: "center"
            }, {
                field: 'MgmtUserId',
                title: '처리자',
                align: "center"
            }, {
                field: 'BankName',
                title: '은행',
                align: "center"
            }, {
                field: 'AccountNo',
                title: '은행계좌',
                align: "center"
            }, {
                field: 'AccountName',
                title: '예금주',
                align: "center"
            }, {
                field: 'CustMemo',
                title: '비고',
                align: "center"
            }],
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
        return table_recharge;
    };

    var table_recharge_Sample = [{
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }];

    var make_table_encashment = function() {
        var table_encashment = $("#tab_encashment").find('#table_encashment').bootstrapTable("destroy").bootstrapTable({
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
                field: 'RequestTime',
                title: '신청일시',
                align: "center"
            }, {
                field: 'ExecuteTime',
                title: '승인일시',
                align: "center"
            }, {
                field: 'RequestMoney',
                title: '신청금액',
                align: "center"
            }, {
                field: 'ExecuteMoney',
                title: '처리금액',
                align: "center"
            }, {
                field: 'MgmtUserId',
                title: '처리자',
                align: "center"
            }, {
                field: 'BankName',
                title: '은행',
                align: "center"
            }, {
                field: 'AccountNo',
                title: '은행계좌',
                align: "center"
            }, {
                field: 'AccountName',
                title: '예금주',
                align: "center"
            }, {
                field: 'CustMemo',
                title: '비고',
                align: "center"
            }],
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
        return table_encashment;
    };

    var table_encashment_Sample = [{
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }, {
        "RequestTime": "2019.03.15 18:02",
        "ExecuteTime": "2019.03.15 18:08",
        "RequestMoney": "1207,230",
        "ExecuteMoney": "1207,230",
        "MgmtUserId": "어드민",
        "BankName": "하나은행",
        "AccountNo": "12391239812083",
        "AccountName": "장동건",
        "CustMemo": ""
    }];


    var make_table_loan_1 = function() {
        var table_load_1 = $("#tab_loan").find('#table_loan_1').bootstrapTable("destroy").bootstrapTable({
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
                field: 'AddupBrrwMoney',
                title: '신청금액',
                align: "center"
            }, {
                field: 'BrrwRate',
                title: '대출뱃수',
                align: "center"
            }, {
                field: 'UsingGuarantee',
                title: '해당담보금',
                align: "center"
            }],
            data: table_loan_1_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
        return table_encashment;
    };

    var table_loan_1_Sample = [{
        "AddupBrrwMoney": "2,000,000",
        "BrrwRate": "10",
        "UsingGuarantee": "200,000"
    }, {
        "AddupBrrwMoney": "3,000,000",
        "BrrwRate": "10",
        "UsingGuarantee": "300,000"
    }, {
        "AddupBrrwMoney": "1,000,000",
        "BrrwRate": "10",
        "UsingGuarantee": "100,000"
    }, {
        "AddupBrrwMoney": "20,000,000",
        "BrrwRate": "10",
        "UsingGuarantee": "2,000,000"
    }, {
        "AddupBrrwMoney": "8,000,000",
        "BrrwRate": "10",
        "UsingGuarantee": "800,000"
    }, ];


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
        return table_encashment;
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
        "BrrwRate": "10",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, {
        "BrrwRate": "10",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, {
        "BrrwRate": "10",
        "AddupPrincipalGuarantee": "801,239,110",
        "LossCutMoney": "200,000",
        "allProfitRate": "+12.2%",
        "LossCutRate": "5%",
        "BrrwCount": "2",
        "BrrwId": "123123"
    }, ];

    return {
        init: function() {
            make_table_assets_1();
            make_table_assets_2();
            make_table_recharge();
            make_table_encashment();
            make_table_loan_1();
            make_table_loan_2();
        },
        searchRechargeByDate: function() {
            make_table_recharge();
            $("#tab_recharge").find('#table_recharge').bootstrapTable("append", table_recharge_Sample);
        },
        searchEncashmentByDate: function() {
            make_table_encashment();
            $("#tab_encashment").find('#table_encashment').bootstrapTable("append", table_encashment_Sample);
        }
    };
}();

jQuery(document).ready(function() {
    Assets.init();
    $(".RechargeSearch").on("click", function() {

        Assets.searchRechargeByDate();

    });
    $(".EncashmentSearch").on("click", function() {

        Assets.searchEncashmentByDate();

    });

});