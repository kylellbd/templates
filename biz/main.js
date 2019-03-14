var Main = function() {
    var makeMarketInfoKorea = function(){
        var table_1 = $("#main_list_1").find('#main_list_1_table_1').bootstrapTable({
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
			data: koreaSample,
			onLoadSuccess : function() { // 加载成功时执行
				console.log("加载成功");
			},
			onLoadError : function() { // 加载失败时执行
				console.log("加载数据失败");
			}
        });
    };
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

    var koreaSample = [
        {
            "ID":"삼성전자",
            "PRICE":"43050.0",
            "PERCENT":"+2.50%"
        },
        {
            "ID":"SK하이닉스",
            "PRICE":"70500.0",
            "PERCENT":"+5.54%"
        },
        {
            "ID":"현대자동차",
            "PRICE":"13000.0",
            "PERCENT":"+0.78%%"
        },
        {
            "ID":"LG화학",
            "PRICE":"367500.0",
            "PERCENT":"-0.41%"
        },
        {
            "ID":"삼성바이오로직스",
            "PRICE":"401500.0",
            "PERCENT":"+0.63%"
        },
        {
            "ID":"셀트리온",
            "PRICE":"208000.0",
            "PERCENT":"+4.00%"
        },
        {
            "ID":"포스코",
            "PRICE":"264500.0",
            "PERCENT":"+2.50%"
        },
        {
            "ID":"한국전력공사",
            "PRICE":"32800.0",
            "PERCENT":"-0.15%"
        },
        {
            "ID":"현대모비스",
            "PRICE":"214500.0",
            "PERCENT":"-0.23%"
        },
        {
            "ID":"신한지주",
            "PRICE":"41950.0",
            "PERCENT":"+3.33%"
        },
    ];
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
            makeMarketInfoKorea();
            makecryptoCoins();
            makeStockFeed();
		}
    };
}();

jQuery(document).ready(function() {
	Main.init();
});