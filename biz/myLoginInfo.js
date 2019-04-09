var LoginLog = function() {


    var make_table_log = function() {
        var tab_log = $("#table_log").bootstrapTable({
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
                field: 'UserId',
                title: '帐号',
                align: "center"
            }, {
                field: 'LoginType',
                title: '登录类型',
                align: "center"
            }, {
                field: 'LoginIp',
                title: '登录地址',
                align: "center"
            }, {
                field: 'LoginTime',
                title: '登录时间',
                align: "center"
            }],
            data: table_log_Sample,
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var table_log_Sample = [{
        "UserId": "user1",
        "LoginType": "login",
        "LoginIp": "69.15.45.47",
        "LoginTime": "2019.02.08 13:15:20"
    }, {
        "UserId": "user1",
        "LoginType": "logout",
        "LoginIp": "69.15.45.47",
        "LoginTime": "2019.02.08 16:15:20"
    }, {
        "UserId": "user1",
        "LoginType": "login",
        "LoginIp": "69.200.150.47",
        "LoginTime": "2019.01.09 13:15:20"
    }, {
        "UserId": "user1",
        "LoginType": "login",
        "LoginIp": "69.15.45.90",
        "LoginTime": "2019.01.12 13:15:20"
    }, {
        "UserId": "user1",
        "LoginType": "login",
        "LoginIp": "69.15.45.85",
        "LoginTime": "2019.01.05 13:15:20"
    }, {
        "UserId": "user1",
        "LoginType": "login",
        "LoginIp": "69.15.45.16",
        "LoginTime": "2019.01.04 13:15:20"
    }];


    return {
        init: function() {
            make_table_log();
        },
        searchLogByDate: function() {
            make_table_log();
            $("#table_log").bootstrapTable("append", table_log_Sample);
        }
    };
}();

jQuery(document).ready(function() {
    LoginLog.init();
    $(".LogSearch").on("click", function() {

        LoginLog.searchLogByDate();

    });


});