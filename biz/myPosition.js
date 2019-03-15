var Main = function() {
    var makeTable_1_1 = function(){
        var table_1 = $("#myPositionPT").find('#table_1_1').bootstrapTable({
			striped : true, // 是否显示行间隔色
			cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : false, // 是否显示分页（*）
			sortable : false, // 是否启用排序
			sortOrder : "asc", // 排序方式
			search : false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			contentType : "application/json",
			strictSearch : false,
			showColumns : false, // 是否显示所有的列
			showRefresh : false, // 是否显示刷新按钮
			minimumCountColumns : 2, // 最少允许的列数
			clickToSelect : false, // 是否启用点击选中行
			uniqueId : "no", // 每一行的唯一标识，一般为主键列
			showToggle : false, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : false, // 是否显示父子表
			columns : [ {
				field : 'selectItem',
                checkbox: true,
                align : "center"
			},{
				field : 'ID',
                title : '주문번호',
                align : "center"
			}, {
				field : 'MarketId',
                title : 'Market',
                align : "center"
			}, {
				field : 'ItemId',
                title : '종목명',
                align : "center"
            }, {
				field : 'OpenCloseType',
				title : 'Position상태 구분',
                align : "center"
            }, {
				field : 'PlaceType',
				title : '거래자금유형',
                align : "center"
            }, {
				field : 'PositionType',
				title : '포지션타입',
                align : "center"
            }, {
				field : 'OrderType',
				title : '지정가/시장가구분',
                align : "center"
            }, {
				field : 'TradeType',
				title : '주문유형',
                align : "center"
            }, {
				field : 'OrderAmt',
				title : '수량',
                align : "center"
            }, {
				field : 'OrderPrice',
				title : '가격',
                align : "center"
            }, {
				field : 'OrderTime',
				title : '주문시간',
                align : "center"
            } ],
			data: table_1_1_Sample,
			onLoadSuccess : function() { // 加载成功时执行
				console.log("加载成功");
			},
			onLoadError : function() { // 加载失败时执行
				console.log("加载数据失败");
			}
        });
    };
    

    var table_1_1_Sample = [
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "OrderTime":""
        },
        
    ];

    var makeTable_1_2 = function(){
        var table_1 = $("#myPositionPT").find('#table_1_2').bootstrapTable({
			striped : true, // 是否显示行间隔色
			cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : false, // 是否显示分页（*）
			sortable : false, // 是否启用排序
			sortOrder : "asc", // 排序方式
			search : false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			contentType : "application/json",
			strictSearch : false,
			showColumns : false, // 是否显示所有的列
			showRefresh : false, // 是否显示刷新按钮
			minimumCountColumns : 2, // 最少允许的列数
			clickToSelect : false, // 是否启用点击选中行
			uniqueId : "no", // 每一行的唯一标识，一般为主键列
			showToggle : false, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : false, // 是否显示父子表
			columns : [ {
				field : 'ExecuteDate',
				title : '처리시간',
                align : "center"
            } ,{
				field : 'ID',
                title : '주문번호',
                align : "center"
			}, {
				field : 'MarketId',
                title : 'Market',
                align : "center"
			}, {
				field : 'ItemId',
                title : '종목명',
                align : "center"
            }, {
				field : 'PlaceType',
				title : '거래자금유형',
                align : "center"
            }, {
				field : 'PositionType',
				title : '포지션타입',
                align : "center"
            }, {
				field : 'OrderType',
				title : '지정가/시장가구분',
                align : "center"
            }, {
				field : 'TradeType',
				title : '주문유형',
                align : "center"
            }, {
				field : 'Sts',
				title : '상태',
                align : "center"
            }, {
				field : 'OrderAmt',
				title : '주문량',
                align : "center"
            }, {
				field : 'ExcecuteAmt',
				title : '체결량',
                align : "center"
            }, {
				field : 'OrderPrice',
				title : '주문가',
                align : "center"
            }, {
				field : 'ExecutePrice',
				title : '체결가',
                align : "center"
            }, {
				field : 'Profit',
				title : '손익',
                align : "center"
            }, {
				field : 'TradeTax',
				title : '거래세',
                align : "center"
            }, {
				field : 'MgmtFee',
				title : '취급수수료',
                align : "center"
            }, {
				field : 'TradeFee',
				title : '거래수수료',
                align : "center"
            }, {
				field : 'CloseFee',
				title : '마감수수료',
                align : "center"
            }, {
				field : 'LossCutFee',
				title : '로스컷수수료',
                align : "center"
            }, {
				field : 'oevernight',
				title : '오버나잇수수료',
                align : "center"
            }, {
				field : 'allProfit',
				title : '총손익',
                align : "center"
            }, {
				field : 'executeBy',
				title : '호출',
                align : "center"
            } ],
			data: table_1_1_Sample,
			onLoadSuccess : function() { // 加载成功时执行
				console.log("加载成功");
			},
			onLoadError : function() { // 加载失败时执行
				console.log("加载数据失败");
			}
        });
    };
    var table_1_1_Sample = [
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
        {
            "ID":"1000123891",
            "MarketId":"코스피",
            "ItemId":"SK하이닉스",
            "OpenCloseType":"open",
            "PlaceType":"마진",
            "PositionType":"공",
            "OrderType":"시장가",
            "TradeType":"매도",
            "OrderAmt":"",
            "OrderPrice":"",
            "ExecuteDate":"2019.01.01 12:30",
            "Sts":"체결",
            "ExcecuteAmt":"",
            "ExecutePrice":"",
            "Profit":"311,203",
            "TradeTax":"1,500",
            "MgmtFee":"1,500",
            "TradeFee":"1,500",
            "CloseFee":"1,500",
            "LossCutFee":"1,500",
            "oevernight":"1,500",
            "allProfit":"288,203",
            "executeBy":"사용자"
        },
    ];
    var makecryptoCoins = function(){
        var table_2 = $("#main_list_1").find('#main_list_1_table_2').bootstrapTable({
			//url : '/Interface/getStocks', // 请求后台的URL（*）
			//method : 'post', // 请求方式（*）
			//dataType : 'json',
			// toolbar : '#toolbar', // 工具按钮用哪个容器
			striped : true, // 是否显示行间隔色
			cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
			pagination : false, // 是否显示分页（*）
			sortable : false, // 是否启用排序
			sortOrder : "asc", // 排序方式
			// queryParams: oTableInit.queryParams,//传递参数（*）
			// sidePagination : "client", // 分页方式：client客户端分页，server服务端分页（*）
			// pageNumber : 1, // 初始化加载第一页，默认第一页
			// pageSize : 10, // 每页的记录行数（*）
			// pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
			search : false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
			// contentType : "application/x-www-form-urlencoded",
			contentType : "application/json",
			strictSearch : false,
			showColumns : false, // 是否显示所有的列
			showRefresh : false, // 是否显示刷新按钮
			minimumCountColumns : 2, // 最少允许的列数
			clickToSelect : false, // 是否启用点击选中行
			// height : 300, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
			uniqueId : "no", // 每一行的唯一标识，一般为主键列
			showToggle : false, // 是否显示详细视图和列表视图的切换按钮
			cardView : false, // 是否显示详细视图
			detailView : false, // 是否显示父子表
			columns : [ {
				field : 'ID',
				title : '종류'
			}, {
				field : 'PRICE',
				title : '현재가'
			}, {
				field : 'PERCENT',
				title : '변화'
			} ],
			data: cryptoCoinsSample,
			onLoadSuccess : function() { // 加载成功时执行
				console.log("加载成功");
			},
			onLoadError : function() { // 加载失败时执行
				console.log("加载数据失败");
			}
        });
    };

    var makeStockFeed = function() {
        $("#main_list_2").find('#main_list_2_table_1').bootstrapTable('load',stockFeedSample.ask);
		$("#main_list_2").find('#main_list_2_table_2').bootstrapTable('load',stockFeedSample.bid);
    }
    var cryptoCoinsSample = [
        {
            "ID":"Bitcoin",
            "PRICE":"3633.2",
            "PERCENT":"+0.30%"
        },
        {
            "ID":"XRP",
            "PRICE":"0.31607",
            "PERCENT":"+0.65%"
        },
        {
            "ID":"Ethereum",
            "PRICE":"118.63",
            "PERCENT":"-0.11%"
        },
        {
            "ID":"EOS",
            "PRICE":"2.4889",
            "PERCENT":"-1.15%"
        },
        {
            "ID":"Tether",
            "PRICE":"0.99800000",
            "PERCENT":"-0.10%"
        },
        {
            "ID":"Stellar",
            "PRICE":"0.10284060",
            "PERCENT":"+0.14%"
        },
        {
            "ID":"Litecoin",
            "PRICE":"32.684",
            "PERCENT":"+2.50%"
        },
        {
            "ID":"TRON",
            "PRICE":"0.027458",
            "PERCENT":"-0.15%"
        },
        {
            "ID":"Cardano",
            "PRICE":"0.043763",
            "PERCENT":"-0.23%"
        },
        {
            "ID":"NEO",
            "PRICE":"7.72",
            "PERCENT":"+3.33%"
        },
    ];

    var stockFeedSample = {
        "1101": "true",
        "1102": "true",
        "index": "43",
        "name": "SK하이닉스",
        "shcode": "000660",
        "expcode": "KR7000660001",
        "etfchk": "",
        "memedan": "00001",
        "count": "0",
        "market": "0",
        "recprice": "64900",
        "jnilvolume": "2830122",
        "jnilamount": "",
        "amount": "145716000000",
        "high52w": "97,700",
        "high52wdate": "2018/05/25",
        "low52w": "56,700",
        "low52wdate": "2019/01/04",
        "info1": "",
        "symbol": "000660",
        "master": "false",
        "vi": "0",
        "price": "64,600",
        "jnilclose": "64,900",
        "sign": "5",
        "change": "300",
        "diff": "-0.46",
        "volume": "2,263,599",
        "uplmtprice": "84,300",
        "dnlmtprice": "45,500",
        "open": "65,000",
        "high": "65,700",
        "low": "63,900",
        "askcnt": "224,371",
        "bidcnt": "306,680",
        "hotime": "16000007",
        "ask": [
            {
                "price": "64,600",
                "count": "30,011"
            },
            {
                "price": "64,700",
                "count": "44,184"
            },
            {
                "price": "64,800",
                "count": "23,980"
            },
            {
                "price": "64,900",
                "count": "32,290"
            },
            {
                "price": "65,000",
                "count": "27,178"
            },
            {
                "price": "65,100",
                "count": "40,427"
            },
            {
                "price": "65,200",
                "count": "4,401"
            },
            {
                "price": "65,300",
                "count": "4,673"
            },
            {
                "price": "65,400",
                "count": "4,268"
            },
            {
                "price": "65,500",
                "count": "12,959"
            }
        ],
        "bid": [
            {
                "price": "64,500",
                "count": "19,094"
            },
            {
                "price": "64,400",
                "count": "22,091"
            },
            {
                "price": "64,300",
                "count": "30,481"
            },
            {
                "price": "64,200",
                "count": "45,031"
            },
            {
                "price": "64,100",
                "count": "62,268"
            },
            {
                "price": "64,000",
                "count": "54,463"
            },
            {
                "price": "63,900",
                "count": "37,388"
            },
            {
                "price": "63,800",
                "count": "16,604"
            },
            {
                "price": "63,700",
                "count": "12,584"
            },
            {
                "price": "63,600",
                "count": "6,676"
            }
        ],
        "req_count": "1",
        "status": "1",
        "result": "true"
    };

    return {
        init: function() {
            makeTable_1_1();
            makeTable_1_2();
		}
    };
}();

jQuery(document).ready(function() {
	Main.init();
});