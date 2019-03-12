<script type="text/javascript">
	var leftBarInit = function() {

		var leftBar = new Object();
		leftBar.Init = function() {
			var loginMenuList = leftBar.SampleData;
			var loginMenuListLength = loginMenuList.length;
			var menuHtml = "";
			var showMenuId = sessionStorage.getItem("showMenuId");
			var choosedMenuHtml = '<span class="selected"></span>'
					+ '<span class="arrow open"></span>';

			for (var i = 0; i < loginMenuListLength; i++) {
				var menuId = loginMenuList[i].menuId;
				var parentMenuId = loginMenuList[i].parentMenuId;
				var menuName = loginMenuList[i].menuName;
				var menuDepthNo = loginMenuList[i].menuDepthNo;
				var pageUri = loginMenuList[i].pageUri;

				if (menuDepthNo == "1") {
					if (menuHtml != "") {
						menuHtml += '</ul></li>';
					}
					menuHtml += '<li id=dep1'+menuId+' class="nav-item">'
							+ '<a class="nav-link nav-toggle dep1-children">'
							+ '<i class="icon-diamond"></i>'
							+ '<span class="title spanTitle">' + menuName
							+ '</span></a><ul class="sub-menu">'
				} else if (menuDepthNo == "2") {
					menuHtml += '<li id=dep2'+menuId+' class="nav-item dep2">'
							+ '<a href='+pageUri+' class="nav-link">'
							+ '<span class="title">' + menuName + '</span>'
							+ '</a></li>';
				}
			}

			$("#ul_menu").empty();
			$("#ul_menu").append(menuHtml);

			if (showMenuId != null) {
				var $parentLi = $("#" + showMenuId).parent().parent();

				$("#" + showMenuId).attr("class", "nav-item active open dep2")
				$parentLi.attr("class", "nav-item active open");
				$parentLi.children(".dep1-children").append(choosedMenuHtml);
			}

			$(".dep2").on("click", function() {
				sessionStorage.clear("menuId");
				sessionStorage.setItem("showMenuId", $(this).attr("id"));
			});
			console.log(leftBar.SampleData);
		}
		leftBar.SampleData = [
			{
				"parentMenuId":"ROOT",
				"pageUri":null,
				"menuId":"LAIS-BIZ-05",
				"menuDepthNo":1,
				"systemCategory":"LAIS",
				"menuName":"课程管理",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/information.do",
				"menuId":"LAIS-BIZ-05-01",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"课程信息管理",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/progress.do",
				"menuId":"LAIS-BIZ-05-02",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"课程进度管理",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/training.do",
				"menuId":"LAIS-BIZ-05-03",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"培训申请",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/mtraining.do",
				"menuId":"LAIS-BIZ-05-04",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"我的培训",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/record.do",
				"menuId":"LAIS-BIZ-05-05",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"课程履历",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-05",
				"pageUri":"/biz/ojt/mteaching.do",
				"menuId":"LAIS-BIZ-05-06",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"我的授课",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"ROOT",
				"pageUri":null,
				"menuId":"LAIS-BIZ-06",
				"menuDepthNo":1,
				"systemCategory":"LAIS",
				"menuName":"审批",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-06",
				"pageUri":"/biz/exam/apperExam.do",
				"menuId":"LAIS-BIZ-06-A",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"审批人审批",
				"menuCategory":"BIZ"
			},
			{
				"parentMenuId":"LAIS-BIZ-06",
				"pageUri":"/biz/ojt/SPYTest.do",
				"menuId":"LAIS-BIZ-06-B",
				"menuDepthNo":2,
				"systemCategory":"LAIS",
				"menuName":"查看",
				"menuCategory":"BIZ"
			}];
		
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
