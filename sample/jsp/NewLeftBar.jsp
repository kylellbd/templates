<script type="text/javascript">
	var leftBarInit = function() {
		var leftBar = new Object();
		
		leftBar.Init = function() {			
			var loginMenuList = $COM_UTIL.getMenuList();
			var loginMenuListLength = loginMenuList.length;
			var preLoginMenuListLength = loginMenuList.length - 1;
			var homePage = "/index.do"
			var menuArray = {
					homePage : "dep1home-page"
			};//key是pageUri，value是menuId，目的是通过pageUri找到menuId
			var pathName = window.location.pathname;
			var menuHtml = '<li id='+menuArray.homePage+' class="nav-item start dep1">'
				+ '<a href="/index.do" class="nav-link nav-toggle menu-cell-content">'
				+ '<i class="icon-home"></i><span class="title">Home</span>'
				+ '</a></li>'
				+ '<li class="heading"><h3 class="uppercase">Menu</h3></li>';
			var choosedMenuCSS = '<span class="selected"></span>';//li展开样式
			var menuShowId = null;//要给左侧菜单样式的li id

			for (var i = 0; i < loginMenuListLength; i++) {
				var menuId = loginMenuList[i].menuId;
				var parentMenuId = loginMenuList[i].parentMenuId;
				var menuName = loginMenuList[i].menuName;
				var menuDepthNo = loginMenuList[i].menuDepthNo;
				var pageUri = loginMenuList[i].pageUri;

				if(i < preLoginMenuListLength){
					var nextMenuDepthNo = loginMenuList[i+1].menuDepthNo;
				}

				if (menuDepthNo == "1") {
					if(menuHtml != "" && nextMenuDepthNo == "2"){
						menuHtml += '</ul>'
					}

					if(nextMenuDepthNo == "2"){
						menuArray[pageUri] = "dep1"+menuId;

						menuHtml += '<li id='+menuArray[pageUri]+' class="nav-item dep1">'
						+ '<a href='+pageUri+' class="nav-link nav-toggle menu-cell-content">'
						+ '<i class="icon-diamond"></i>'
						+ '<span class="title spanTitle">' + menuName + '</span>'
						+ '<span class="arrow"></span></a>'
						+ '<ul class="sub-menu">';
					}else{
						menuArray[pageUri] = "dep1"+menuId;

						menuHtml += '<li id='+menuArray[pageUri]+' class="nav-item dep1">'
						+ '<a href='+pageUri+' class="nav-link menu-cell-content">'
						+ '<i class="icon-diamond"></i>'
						+ '<span class="title spanTitle">' + menuName + '</span>'
						+ '</a></li>';
					}

				}else{
					menuArray[pageUri] = "dep2"+menuId;

					menuHtml += '<li id='+menuArray[pageUri]+' class="nav-item dep2">'
							+ '<a href='+pageUri+' class="nav-link">'
							+ '<span class="title">'+menuName+'</span>'	
							+ '</a></li>';
				}
			}

			$("#ul_menu").empty();
			$("#ul_menu").append(menuHtml);

			menuShowId = menuArray[pathName];
			if(menuShowId == null){
				menuShowId = menuArray.homePage;
			}

			var $dep1Children = $("#" + menuShowId).parent().parent().children(".menu-cell-content");//2级li的上级li.children(".menu-cell-content")
			var checkDep = menuShowId.substring(0,4);

			if(checkDep == "dep2"){
				$("#" + menuShowId).attr("class", "nav-item active open dep2");
				$("#" + menuShowId).parent().parent().attr("class", "nav-item active open");
				$dep1Children.append(choosedMenuCSS);
				$dep1Children.children(".arrow").attr("class","arrow open");
			}else{
				$("#" + menuShowId).attr("class", "nav-item active");
				$("#" + menuShowId).children(".menu-cell-content").append(choosedMenuCSS);
			}
		}
		return leftBar;
	}
</script>
<div class="page-sidebar-wrapper">
	<!-- BEGIN SIDEBAR -->
	<div class="page-sidebar navbar-collapse collapse">
		<!-- BEGIN SIDEBAR MENU -->
		<ul id="ul_menu" class="page-sidebar-menu  page-header-fixed "
			data-keep-expanded="true" data-auto-scroll="false"
			data-slide-speed="150" style="padding-top: 20px">
		</ul>
		<!-- END SIDEBAR MENU -->
	</div>
	<!-- END SIDEBAR -->
</div>
