var LeftBar = function() {
	var makeLeftBar = function(){
		var loginMenuList = SampleData;
		var loginMenuListLength = loginMenuList.length;
		var menuHtml = "";
		var path = window.location.pathname;
		var showMenuId = "";
		var showMenuDepth = 0;
		var defaultMenuId = "ADM-01";
		
		var choosedMenuHtmlDep1 = '<span class="selected"></span>'
				+ '<span class="arrow open"></span>';
		var choosedMenuHtmlDep2 = '<span class="selected"></span>';
		var hasChildrenHtml = '<span class="arrow"></span>';

		for (var i = 0; i < loginMenuListLength; i++) {
			var menuId = loginMenuList[i].menuId;
			var parentMenuId = loginMenuList[i].parentMenuId;
			var menuName = loginMenuList[i].menuName;
			var menuDepthNo = loginMenuList[i].menuDepthNo;
			var pageUri = loginMenuList[i].pageUri;
			var hasChildren = loginMenuList[i].hasChildren;
			var menuIcon = loginMenuList[i].menuIcon;
			
			if(path == pageUri){
				showMenuId = menuId;
				showMenuDepth = menuDepthNo;
			}

			if (menuDepthNo == "1") {
				if (menuHtml != "") {
					menuHtml += '</ul></li>';
				}
				menuHtml += '<li id='+menuId+' depth="1" class="nav-item dep1">';
				if(pageUri){
					menuHtml += '<a href='+pageUri+' class="nav-link nav-toggle dep1-children">';
				}else{
					menuHtml += '<a class="nav-link nav-toggle dep1-children">';
				}
						
				menuHtml += '<i class='+menuIcon+'></i>'
						+ '<span class="title spanTitle">' + menuName + '</span>';
				if(hasChildren){
					menuHtml += hasChildrenHtml;
				}
				menuHtml += '</a>';
				if(hasChildren){
					menuHtml += '<ul class="sub-menu">';
					
				}
			} else if (menuDepthNo == "2") {
				menuHtml += '<li id='+menuId+' depth="2" class="nav-item dep2">';
				if(pageUri){
					menuHtml += '<a href='+pageUri+' class="nav-link dep2-children">';
				}else{
					menuHtml += '<a class="nav-link dep2-children">';
				}
				menuHtml += '<span class="title">' + menuName + '</span>'
						+ '</a></li>';
			}
		}

		$("#ul_menu").empty();
		$("#ul_menu").append(menuHtml);

		if (showMenuId != null) {
			if(showMenuDepth==2){
				var $parentLi = $("#" + showMenuId).parent().parent();
				$("#" + showMenuId).attr("class", "nav-item active open dep2");
				$("#" + showMenuId).children(".dep2-children").append(choosedMenuHtmlDep2);
				makeDepth1Stype($parentLi, choosedMenuHtmlDep1, choosedMenuHtmlDep2);
				
			}else{
				var $parentLi = $("#" + showMenuId);
				makeDepth1Stype($parentLi, choosedMenuHtmlDep1, choosedMenuHtmlDep2);
			}
			
		}else{
			var $parentLi = $("#"+defaultMenuId);
			makeDepth1Stype($parentLi, choosedMenuHtmlDep1, choosedMenuHtmlDep2);
		}
	}
	var makeDepth1Stype = function(depth1L, choosedMenuHtmlDep1, choosedMenuHtmlDep2){
		depth1L.attr("class", "nav-item active open");
		depth1L.children(".dep1-children").children(".arrow").remove();
		if(depth1L.children("ul").length == 0){
			depth1L.children(".dep1-children").append(choosedMenuHtmlDep2);
		}else{
			depth1L.children(".dep1-children").append(choosedMenuHtmlDep1);
		}
		
	}
	var SampleData = [
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/index_cn.html",
			"menuId":"ADM-01",
			"menuDepthNo":1,
			"menuName":"首页",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
				
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/notice/noticeMgt_cn.html",
			"menuId":"ADM-02",
			"menuDepthNo":1,
			"menuName":"公告管理",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":null,
			"menuId":"ADM-03",
			"menuDepthNo":1,
			"menuName":"VIP信息设置",
			"menuCategory":"ADM",
			"hasChildren":true,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-03",
			"pageUri":"/templates/adm/vipMgt/normalVipSet_cn.html",
			"menuId":"ADM-03-01",
			"menuDepthNo":2,
			"menuName":"普通VIP属性设置",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-03",
			"pageUri":"/templates/adm/vipMgt/normalVipReach_cn.html",
			"menuId":"ADM-03-02",
			"menuDepthNo":2,
			"menuName":"普通VIP达标设置",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-03",
			"pageUri":"/templates/adm/vipMgt/specialVipSet_cn.html",
			"menuId":"ADM-03-03",
			"menuDepthNo":2,
			"menuName":"特殊VIP设置",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/system/systemSet_cn.html",
			"menuId":"ADM-04",
			"menuDepthNo":1,
			"menuName":"基本运维设置",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":null,
			"menuId":"ADM-05",
			"menuDepthNo":1,
			"menuName":"MARKET 管理",
			"menuCategory":"ADM",
			"hasChildren":true,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-05",
			"pageUri":"/templates/adm/market/marketMgt_cn.html",
			"menuId":"ADM-05-01",
			"menuDepthNo":2,
			"menuName":"MARKET信息管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-05",
			"pageUri":"/templates/adm/market/marketItemMgt_cn.html",
			"menuId":"ADM-05-02",
			"menuDepthNo":2,
			"menuName":"可交易品类管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-05",
			"pageUri":"/templates/adm/market/marketRestDay_cn.html",
			"menuId":"ADM-05-03",
			"menuDepthNo":2,
			"menuName":"Market休息日管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-05",
			"pageUri":"/templates/adm/market/marketRestTime_cn.html",
			"menuId":"ADM-05-04",
			"menuDepthNo":2,
			"menuName":"Market休息时间管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		// {
		// 	"parentMenuId":"ADM-05",
		// 	"pageUri":"/templates/adm/market/systemSet_cn.html",
		// 	"menuId":"ADM-05-05",
		// 	"menuDepthNo":2,
		// 	"menuName":"可用贷款杠杆倍数设置",
		// 	"menuCategory":"ADM",
		// 	"menuIcon":"icon-home"
		// },
		{
			"parentMenuId":"ROOT",
			"pageUri":null,
			"menuId":"ADM-06",
			"menuDepthNo":1,
			"menuName":"用户管理",
			"menuCategory":"ADM",
			"hasChildren":true,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-06",
			"pageUri":"/templates/adm/user/userMgt_cn.html",
			"menuId":"ADM-06-01",
			"menuDepthNo":2,
			"menuName":"用户信息管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-06",
			"pageUri":"/templates/adm/user/testUserMgt_cn.html",
			"menuId":"ADM-06-02",
			"menuDepthNo":2,
			"menuName":"测试用户管理",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/cashInOut/cashInOutMgt_cn.html",
			"menuId":"ADM-07",
			"menuDepthNo":1,
			"menuName":"充值/提现管理",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/position/positionMgt_cn.html",
			"menuId":"ADM-08",
			"menuDepthNo":1,
			"menuName":"持仓信息管理",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/batch/batchMgt_cn.html",
			"menuId":"ADM-09",
			"menuDepthNo":1,
			"menuName":"批处理管理",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":"/templates/adm/log/logMgt_cn.html",
			"menuId":"ADM-10",
			"menuDepthNo":1,
			"menuName":"日志管理",
			"menuCategory":"ADM",
			"hasChildren":false,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ROOT",
			"pageUri":null,
			"menuId":"ADM-11",
			"menuDepthNo":1,
			"menuName":"查询汇总",
			"menuCategory":"ADM",
			"hasChildren":true,
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":"/templates/adm/report/orderList_cn.html",
			"menuId":"ADM-11-01",
			"menuDepthNo":2,
			"menuName":"订单信息详情",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-02",
			"menuDepthNo":2,
			"menuName":"持仓信息详情",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-03",
			"menuDepthNo":2,
			"menuName":"用户账单查询",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-04",
			"menuDepthNo":2,
			"menuName":"用户损益状况",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-05",
			"menuDepthNo":2,
			"menuName":"用户日别损益状况",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-06",
			"menuDepthNo":2,
			"menuName":"下订单日志",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-07",
			"menuDepthNo":2,
			"menuName":"全局损益详情",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		},
		{
			"parentMenuId":"ADM-11",
			"pageUri":null,
			"menuId":"ADM-11-08",
			"menuDepthNo":2,
			"menuName":"充值/提现详情",
			"menuCategory":"ADM",
			"menuIcon":"icon-home"
		}
	];
		
	return {
		init: function() {
			makeLeftBar();
		}
	};
}();

jQuery(document).ready(function() {
	LeftBar.init();
});