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
							<li><a href="index.html">html标签上面那个东西的尖括号里面这么写!DOCTYPE
									html,要不会出莫名其妙的问题</a> <i class="fa fa-circle"></i></li>
							<li><span>span</span></li>
						</ul>
					</div>
					<h1 class="page-title">Tabs</h1>
					<div class="row">
						<div class="col-md-6">

							<!-- Begin Left Tabs -->
							<div class="portlet box blue">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-gift"></i>Left Tabs
									</div>
									<div class="tools">
										<a class="collapse"> </a> <a href="#portlet-config"
											data-toggle="modal" class="config"> </a>
									</div>
								</div>
								<div class="portlet-body">
									<div class="row">
										<div class="col-md-3 col-sm-3 col-xs-3">
											<ul class="nav nav-tabs tabs-left">
												<li class="active"><a href="#tab_1_1" data-toggle="tab">
														to tab_1_1 </a></li>
												<li><a href="#tab_1_2" data-toggle="tab"> to
														tab_1_2 </a></li>
												<li class="dropdown"><a class="dropdown-toggle"
													data-toggle="dropdown"> More <i
														class="fa fa-angle-down"></i>
												</a>
													<ul class="dropdown-menu" role="menu">
														<li><a href="#tab_1_3" tabindex="-1"
															data-toggle="tab"> to tab_1_3 </a></li>
														<li><a href="#tab_1_4" tabindex="-1"
															data-toggle="tab"> to tab_1_4 </a></li>
														<li><a href="#tab_1_5" tabindex="-1"
															data-toggle="tab"> to tab_1_5 </a></li>
														<li><a href="#tab_1_6" tabindex="-1"
															data-toggle="tab"> to tab_1_6 </a></li>
													</ul></li>
												<li><a href="#tab_1_7" data-toggle="tab"> to
														tab_1_7 </a></li>
												<li><a href="#tab_1_8" data-toggle="tab"> to
														tab_1_8 </a></li>
											</ul>
										</div>
										<div class="col-md-9 col-sm-9 col-xs-9">
											<div class="tab-content">
												<div class="tab-pane active" id="tab_1_1">
													<p>tab_1_1</p>
												</div>
												<div class="tab-pane fade" id="tab_1_2">
													<p>tab_1_2</p>
												</div>
												<div class="tab-pane fade" id="tab_1_3">
													<p>tab_1_3</p>
												</div>
												<div class="tab-pane fade" id="tab_1_4">
													<p>tab_1_4</p>
												</div>
												<div class="tab-pane fade" id="tab_1_5">
													<p>tab_1_5</p>
												</div>
												<div class="tab-pane fade" id="tab_1_6">
													<p>tab_1_6</p>
												</div>
												<div class="tab-pane fade" id="tab_1_7">
													<p>tab_1_7</p>
												</div>
												<div class="tab-pane fade" id="tab_1_8">
													<p>tab_1_8</p>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>
							<!-- end Left Tabs -->

						</div>
						<div class="col-md-6">

							<!-- begin TAB DROP -->
							<div class="portlet light bordered">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-anchor font-green-sharp"></i> <span
											class="caption-subject font-green-sharp bold uppercase">Tab
											drop</span>
									</div>
									<div class="actions">
										<div class="btn-group">
											<a class="btn green-haze btn-outline btn-circle btn-sm"
												data-toggle="dropdown" data-hover="dropdown"
												data-close-others="true"> Actions <i
												class="fa fa-angle-down"></i>
											</a>
											<ul class="dropdown-menu pull-right">
												<li><a> Option 1</a></li>
												<li class="divider"></li>
												<li><a>Option 2</a></li>
												<li><a>Option 3</a></li>
												<li><a>Option 4</a></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="portlet-body">
									<p>Basic exemple. Resize the window to see how the tabs are
										moved into the dropdown</p>
									<div class="tabbable tabbable-tabdrop">
										<ul class="nav nav-tabs">
											<li class="active"><a href="#tab1" data-toggle="tab">Section
													1</a></li>
											<li><a href="#tab2" data-toggle="tab">Section 2</a></li>
											<li><a href="#tab3" data-toggle="tab">Section 3</a></li>
											<li><a href="#tab4" data-toggle="tab">Section 4</a></li>
											<li><a href="#tab5" data-toggle="tab">Section 5</a></li>
										</ul>
										<div class="tab-content">
											<div class="tab-pane active" id="tab1">
												<p>I'm in Section 1.</p>
											</div>
											<div class="tab-pane" id="tab2">
												<p>Howdy, I'm in Section 2.</p>
											</div>
											<div class="tab-pane" id="tab3">
												<p>Howdy, I'm in Section 3.</p>
											</div>
											<div class="tab-pane" id="tab4">
												<p>Howdy, I'm in Section 4.</p>
											</div>
											<div class="tab-pane" id="tab5">
												<p>Howdy, I'm in Section 5.</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- end TAB DROP -->





						</div>
					</div>

					<div class="row">
						<!-- begin TAB justified -->
						<div class="col-md-6">
							<div class="portlet box yellow">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-gift"></i>Styled Tabs(justified)
									</div>
									<div class="tools">
										<a href="javascript:;" class="collapse"> </a> <a
											href="#portlet-config" data-toggle="modal" class="config">
										</a>
									</div>
								</div>
								<div class="portlet-body">
									<div class="tabbable-custom nav-justified">
										<ul class="nav nav-tabs nav-justified">
											<li class="active"><a href="#tab_1_1_1"
												data-toggle="tab"> Section 1 </a></li>
											<li><a href="#tab_1_1_2" data-toggle="tab"> Section
													2 </a></li>
											<li><a href="#tab_1_1_3" data-toggle="tab"> Section
													3 </a></li>
										</ul>
										<div class="tab-content">
											<div class="tab-pane active" id="tab_1_1_1">
												<p>I'm in Section 1.</p>
												<p>tab_1_1_1</p>
											</div>
											<div class="tab-pane" id="tab_1_1_2">
												<p>Howdy, I'm in Section 2.</p>
												<p>tab_1_1_2</p>
												<p>
													<a class="btn green" href="Tabs.jsp#tab_1_1_2"
														target="_blank"> Activate this tab via URL </a>
												</p>
											</div>
											<div class="tab-pane" id="tab_1_1_3">
												<p>Howdy, I'm in Section 3.</p>
												<p>tab_1_1_3</p>
												<p>
													<a class="btn yellow" href="Tabs.jsp#tab_1_1_3"
														target="_blank"> Activate this tab via URL </a>
												</p>
											</div>
										</div>
									</div>
									<div class="tabbable-custom tabs-below nav-justified">
										<div class="tab-content">
											<div class="tab-pane active" id="tab_17_1">
												<p>I'm in Section 1.</p>
												<p>tab_17_1</p>
												<p>tab_17_1</p>
											</div>
											<div class="tab-pane" id="tab_17_2">
												<p>Howdy, I'm in Section 2.</p>
												<p>tab_17_2</p>
												<p>
													<a class="btn yellow" href="Tabs.jsp#tab_17_2"
														target="_blank"> Activate this tab via URL </a>
												</p>
											</div>
											<div class="tab-pane" id="tab_17_3">
												<p>Howdy, I'm in Section 3.</p>
												<p>tab_17_3</p>
												<p>
													<a class="btn purple" href="Tabs.jsp#tab_17_3"
														target="_blank"> Activate this tab via URL </a>
												</p>
											</div>
										</div>
										<ul class="nav nav-tabs nav-justified">
											<li class="active"><a href="#tab_17_1" data-toggle="tab">
													Section 1 </a></li>
											<li><a href="#tab_17_2" data-toggle="tab"> Section 2
											</a></li>
											<li><a href="#tab_17_3" data-toggle="tab"> Section 3
											</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<!-- end TAB justified -->
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