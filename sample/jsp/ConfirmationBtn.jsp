<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/jsp/common/NewCSS&Meta.html"%>
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
	<div class="page-wrapper">
		<!-- BEGIN HEADER -->
		<%@include file="/WEB-INF/jsp/common/NewHeader.jsp"%>
		<!-- END HEADER -->
		<div class="clearfix"></div>
		<div class="page-container">
			<!-- BEGIN SIDEBAR -->
			<%@include file="/WEB-INF/jsp/common/NewLeftBar.jsp"%>
			<!-- END SIDEBAR -->
			<div class="page-content-wrapper">
				<div class="page-content">

					<div class="page-bar">
						<ul class="page-breadcrumb">
							<li><a href="index.html">Home</a> <i class="fa fa-circle"></i>
							</li>
							<li><span>UI Features</span></li>
						</ul>
						<div class="page-toolbar">
							<div class="btn-group pull-right">
								<button type="button"
									class="btn green btn-sm btn-outline dropdown-toggle"
									data-toggle="dropdown">
									Actions <i class="fa fa-angle-down"></i>
								</button>
								<ul class="dropdown-menu pull-right" role="menu">
									<li><a href="#"> <i class="icon-bell"></i> Action
									</a></li>
									<li><a href="#"> <i class="icon-shield"></i> Another
											action
									</a></li>
									<li><a href="#"> <i class="icon-user"></i> Something
											else here
									</a></li>
									<li class="divider"></li>
									<li><a href="#"> <i class="icon-bag"></i> Separated
											link
									</a></li>
								</ul>
							</div>
						</div>
					</div>
					<h1 class="page-title">
						Bootstrap Confirmation <small>metronic popover
							confirmation demos using bootstrap confirmation plugin</small>
					</h1>
					<div class="row">
						<div class="col-md-12">
							<div class="portlet light bordered">

								<!-- portlet title b-->
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-bubble font-green-sharp"></i> <span
											class="caption-subject font-green-sharp bold uppercase">Popover
											Confirmation Demos</span>
									</div>
									<div class="actions">
										<div class="btn-group">
											<a class="btn green-haze btn-outline btn-circle btn-sm"
												href="javascript:;" data-toggle="dropdown"
												data-hover="dropdown" data-close-others="true"> Actions
												<i class="fa fa-angle-down"></i>
											</a>
											<ul class="dropdown-menu pull-right">
												<li><a href="javascript:;"> Option 1</a></li>
												<li class="divider"></li>
												<li><a href="javascript:;">Option 2</a></li>
												<li><a href="javascript:;">Option 3</a></li>
												<li><a href="javascript:;">Option 4</a></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- portlet title e-->

								<div class="portlet-body">
									<h3>Popout</h3>
									<p>Click anywhere on the page to close all boxes.</p>
									<button class="btn green-sharp btn-circle" data-toggle="confirmation" data-popout="true">
										点击屏幕弹框消失
									</button>
									<button class="btn red-mint btn-circle" data-toggle="confirmation" data-popout="true" data-singleton="true">
										点击屏幕弹框消失，弹框出现时让别的按钮弹框消失
									</button>
									<button class="btn btn-outline purple-sharp  uppercase" data-toggle="confirmation" data-placement="right">
										弹框在右侧
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- BEGIN FOOTER -->
			<%@include file="/WEB-INF/jsp/common/NewFooter.jsp"%>
			<!-- END FOOTER -->
		</div>
	</div>

</body>
<%@include file="/WEB-INF/jsp/common/NewJS.html"%>
<script src="/assets/pages/scripts/ui-confirmations.min.js" type="text/javascript"></script>
<script src="/resources/js/app/biz/common-lais-util.js"></script>
<script type="text/javascript">
	$(function() {
		var doLoginMainList = loginMainList();//common-lais-util.js
		doLoginMainList.menu();

		var doHeaderInit = headerInit();
		doHeaderInit.manageLanguage();

		var doLeftBarInit = leftBarInit();
		doLeftBarInit.Init();

	});
</script>
</html>