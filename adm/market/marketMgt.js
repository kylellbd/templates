var Market = function() {
    var make_table_Market = function() {
        var tab_market = $("#marketInfoTable").bootstrapTable({
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
                title: 'MarketId',
                align: "center"
            }, {
                field: 'CntryEn',
                title: 'CntryEn',
                align: "center"
            }, {
                field: 'CntryKo',
                title: 'CntryKo',
                align: "center"
            }, {
                field: 'BourseId',
                title: 'BourseId',
                align: "center"
            }, {
                field: 'BourseEn',
                title: 'BourseEn',
                align: "center"
            }, {
                field: 'BourseKo',
                title: 'BourseKo',
                align: "center"
            }, {
                field: 'MarketEn',
                title: 'MarketEn',
                align: "center"
            }, {
                field: 'MarketKo',
                title: 'MarketKo',
                align: "center"
            }, {
                field: 'ShortSellAllow',
                title: 'ShortSellAllow',
                align: "center"
            }, {
                field: 'TimeZone',
                title: 'TimeZone',
                align: "center"
            }, {
                field: 'Active',
                title: 'Active',
                align: "center"
            }, {
                title: "Action",
                field: "MarketId",
                align: "center",
                formatter: function(value, row, index) {
                    return '<a class="btn green-haze btn-outline sbold uppercase dark" data-target="#modal_market" data-toggle="modal">修改</a>';
                }
            }],
            data: table_market_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_market_Sample = [{
        "MarketId": "10",
        "CntryEn": "Korea",
        "CntryKo": "한국",
        "BourseId": "KRX",
        "BourseEn": "Korea Stock Exchange",
        "BourseKo": "한국증권거래소",
        "MarketEn": "KOSPI",
        "MarketKo": "코스피",
        "ShortSellAllow": "Y",
        "TimeZone": "9",
        "Active": "Y",
    }, {
        "MarketId": "11",
        "CntryEn": "Korea",
        "CntryKo": "한국",
        "BourseId": "KRX",
        "BourseEn": "Korea Stock Exchange",
        "BourseKo": "한국증권거래소",
        "MarketEn": "KOSDAQ",
        "MarketKo": "코스닥",
        "ShortSellAllow": "N",
        "TimeZone": "9",
        "Active": "Y",
    }, {
        "MarketId": "12",
        "CntryEn": "Korea",
        "CntryKo": "한국",
        "BourseId": "KRX",
        "BourseEn": "Korea Stock Exchange",
        "BourseKo": "한국증권거래소",
        "MarketEn": "ETF",
        "MarketKo": "ETF",
        "ShortSellAllow": "N",
        "TimeZone": "9",
        "Active": "Y",
    }, {
        "MarketId": "18",
        "CntryEn": "Korea",
        "CntryKo": "한국",
        "BourseId": "Bithumb",
        "BourseEn": "Bithumb Crypto Exchange",
        "BourseKo": "Bithumb 암호화폐거래소",
        "MarketEn": "Bithumb(KRW)",
        "MarketKo": "Bithumb(원화)",
        "ShortSellAllow": "N",
        "TimeZone": "9",
        "Active": "N",
    }, {
        "MarketId": "20",
        "CntryEn": "China",
        "CntryKo": "중국",
        "BourseId": "SHSE",
        "BourseEn": "Shanghai Stock Exchange",
        "BourseKo": "상해증권거래소",
        "MarketEn": "ShanhaiMainStock",
        "MarketKo": "ShanhaiMainStock",
        "ShortSellAllow": "N",
        "TimeZone": "8",
        "Active": "N",
    }, {
        "MarketId": "21",
        "CntryEn": "China",
        "CntryKo": "중국",
        "BourseId": "SZSE",
        "BourseEn": "Shenzhen Stock Exchange",
        "BourseKo": "심천증권거래소",
        "MarketEn": "ShenzhenMainStock",
        "MarketKo": "ShenzhenMainStock",
        "ShortSellAllow": "N",
        "TimeZone": "8",
        "Active": "N",
    }];


    return {
        init: function() {
            make_table_Market();
        },

    };
}();

jQuery(document).ready(function() {
    Market.init();



});