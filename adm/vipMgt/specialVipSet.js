var SpecialVip = function() {
    var make_table_Vip = function() {
        var tab_vip = $("#specialVipTable").bootstrapTable({
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
                field: 'VipKo',
                title: 'VipKo',
                align: "center"
            }, {
                field: 'VipEn',
                title: 'VipEn',
                align: "center"
            }, {
                field: 'TradeTaxRate',
                title: 'TradeTaxRate',
                align: "center"
            }, {
                field: 'TradeFeeRate',
                title: 'TradeFeeRate',
                align: "center"
            }, {
                field: 'MgmtFeeRate',
                title: 'MgmtFeeRate',
                align: "center"
            }, {
                field: 'CloseFeeRate',
                title: 'CloseFeeRate',
                align: "center"
            }, {
                field: 'OverNightFeeRate',
                title: 'OverNightFeeRate',
                align: "center"
            }, {
                field: 'OverNightMaxDay',
                title: 'OverNightMaxDay',
                align: "center"
            }, {
                field: 'OverNightFreeDay',
                title: 'OverNightFreeDay',
                align: "center"
            }, {
                field: 'LossCutFree',
                title: 'LossCutFree',
                align: "center"
            }, {
                field: 'LossCutFeeRate',
                title: 'LossCutFeeRate',
                align: "center"
            }, {
                field: 'LossCutRateMin',
                title: 'LossCutRateMin',
                align: "center"
            }, {
                field: 'LostCutRateMax',
                title: 'LostCutRateMax',
                align: "center"
            }, {
                field: 'BonusActive',
                title: 'BonusActive',
                align: "center"
            }, {
                field: 'BonusRate',
                title: 'BonusRate',
                align: "center"
            }, {
                field: 'BonusCntPerMonth',
                title: 'BonusCntPerMonth',
                align: "center"
            }, {
                field: 'BonusMaxMoney',
                title: 'BonusMaxMoney',
                align: "center"
            }, {
                field: 'MaxBrrwCnt',
                title: 'MaxBrrwCnt',
                align: "center"
            }, {
                field: 'MaxBrrwRate',
                title: 'MaxBrrwRate',
                align: "center"
            }, {
                field: 'MaxBrrwMoney',
                title: 'MaxBrrwMoney',
                align: "center"
            }, {
                field: 'MembershipDay',
                title: 'MembershipDay',
                align: "center"
            }, {
                field: 'ShortSellAllow',
                title: 'ShortSellAllow',
                align: "center"
            }, {
                field: 'ProfitInvestActive',
                title: 'ProfitInvestActive',
                align: "center"
            }],
            data: table_vip_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_vip_Sample = [{
        "VipKo": "특수1",
        "VipEn": "special1",
        "TradeTaxRate": "1.5%",
        "TradeFeeRate": "1.5%",
        "MgmtFeeRate": "1.5%",
        "CloseFeeRate": "1.5%",
        "OverNightFeeRate": "0.5%",
        "OverNightMaxDay": "10",
        "OverNightFreeDay": "5",
        "LossCutFree": "Y",
        "LossCutFeeRate": "0.5%",
        "LossCutRateMin": "10%",
        "LostCutRateMax": "20%",
        "BonusActive": "Y",
        "BonusRate": "2%",
        "BonusCntPerMonth": "1",
        "BonusMaxMoney": "500,000,000",
        "MaxBrrwCnt": "20",
        "MaxBrrwRate": "2.5%",
        "MaxBrrwMoney": "999,999,999,999",
        "MembershipDay": "4",
        "ShortSellAllow": "N",
        "ProfitInvestActive": "Y",
    }, {
        "VipKo": "특수1",
        "VipEn": "special1",
        "TradeTaxRate": "1.5%",
        "TradeFeeRate": "1.5%",
        "MgmtFeeRate": "1.5%",
        "CloseFeeRate": "1.5%",
        "OverNightFeeRate": "0.5%",
        "OverNightMaxDay": "10",
        "OverNightFreeDay": "5",
        "LossCutFree": "Y",
        "LossCutFeeRate": "0.5%",
        "LossCutRateMin": "10%",
        "LostCutRateMax": "20%",
        "BonusActive": "Y",
        "BonusRate": "2%",
        "BonusCntPerMonth": "1",
        "BonusMaxMoney": "500,000,000",
        "MaxBrrwCnt": "20",
        "MaxBrrwRate": "2.5%",
        "MaxBrrwMoney": "999,999,999,999",
        "MembershipDay": "4",
        "ShortSellAllow": "N",
        "ProfitInvestActive": "Y",
    }, {
        "VipKo": "특수1",
        "VipEn": "special1",
        "TradeTaxRate": "1.5%",
        "TradeFeeRate": "1.5%",
        "MgmtFeeRate": "1.5%",
        "CloseFeeRate": "1.5%",
        "OverNightFeeRate": "0.5%",
        "OverNightMaxDay": "10",
        "OverNightFreeDay": "5",
        "LossCutFree": "Y",
        "LossCutFeeRate": "0.5%",
        "LossCutRateMin": "10%",
        "LostCutRateMax": "20%",
        "BonusActive": "Y",
        "BonusRate": "2%",
        "BonusCntPerMonth": "1",
        "BonusMaxMoney": "500,000,000",
        "MaxBrrwCnt": "20",
        "MaxBrrwRate": "2.5%",
        "MaxBrrwMoney": "999,999,999,999",
        "MembershipDay": "4",
        "ShortSellAllow": "N",
        "ProfitInvestActive": "Y",
    }];


    return {
        init: function() {
            make_table_Vip();
        },

    };
}();

jQuery(document).ready(function() {
    SpecialVip.init();



});