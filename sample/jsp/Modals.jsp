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
					<div class="row">
						<div class="col-md-12">
							<div class="portlet light bordered">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-social-dribbble font-green hide"></i> <span
											class="caption-subject font-dark bold">
											bootstrapModals.jsp模态框 </span>
									</div>
								</div>

								<!-- Responsive & Scrollable Modal begin-->
								<div class="portlet-body">
									<div class="row">
										<a id="modalBtn_id" class="btn red btn-outline sbold"
											data-toggle="modal" href="#responsive">Responsive &
											Scrollable（这是a标签，它的href和模态框本体的id绑定）</a>
										<div class="col-md-4">
											<input id="showDataInp_id" type="text" class="form-control"
												placeholder="通过简单的js，可以让数据在这显示">
										</div>
									</div>
								</div>

								<!-- modal body begin -->
								<div id="responsive" class="modal fade" tabindex="-1"
									aria-hidden="true">
									<div class="modal-dialog">
										<div id="modal-contentId" class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"></button>
												<h4 class="modal-title">Responsive & Scrollable</h4>
											</div>
											<div class="modal-body">
												<div class="scroller" style="height: 300px"
													data-always-visible="1" data-rail-visible1="1">
													<div class="row">
														<div class="col-md-12">
															<input id="modalInp_id" type="text"
																class="col-md-12 form-control" placeholder="输入框">
															<p>给按钮加属性：data-dismiss="modal"就能关闭modal</p>
														</div>
													</div>
												</div>
											</div>
											<div class="modal-footer">
												<button id="close_btn" type="button" data-dismiss="modal"
													class="btn dark btn-outline">Close</button>
												<button id="saveChangeBtn_id" type="button"
													class="btn green">Save changes</button>

											</div>
										</div>
									</div>
								</div>
								<!-- modal body end-->
								<!-- Responsive & Scrollable Modal end-->

								<br />

								<!-- Full Width Modal begin-->
								<div class="portlet-body">
									<a class="btn dark btn-outline sbold" data-toggle="modal"
										href="#full"> Full Width Modal</a>
								</div>
								<!-- modal body begin-->
								<div class="modal fade" id="full" tabindex="-1" role="dialog"
									aria-hidden="true">
									<div class="modal-dialog modal-full">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"></button>
												<h4 class="modal-title">full Modal</h4>
											</div>
											<div class="modal-body"></div>
											<div class="modal-footer">
												<button type="button" class="btn dark btn-outline"
													data-dismiss="modal">Close</button>
												<button type="button" class="btn green">Save
													changes</button>
											</div>
										</div>
									</div>
								</div>
								<!-- modal body end-->
								<!-- Full Width Modal end-->

								<!-- Large modal begin -->
								<div class="portlet-body">
									<a class="btn purple btn-outline sbold" data-toggle="modal"
										href="#large"> Large Modal </a>
								</div>
								<div class="modal fade bs-modal-lg" id="large" tabindex="-1"
									role="dialog" aria-hidden="true">
									<div class="modal-dialog modal-lg">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true"></button>
												<h4 class="modal-title">Modal Title</h4>
											</div>
											<div class="modal-body">Modal body goes here</div>
											<div class="modal-footer">
												<button type="button" class="btn dark btn-outline"
													data-dismiss="modal">Close</button>
												<button type="button" class="btn green">Save
													changes</button>
											</div>
										</div>
										<!-- /.modal-content -->
									</div>
									<!-- /.modal-dialog -->
								</div>

								<!-- modal body begin-->

								<!-- modal body end-->
								<!-- Large modal end -->
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
<script src="/resources/js/app/biz/common-lais-util.js"></script>
<script
	src="/resources/js/app/biz/bootstrapTableClientPaging&ServerPaging.js"></script>
<script type="text/javascript">
	$(function() {
		var doLoginMainList = loginMainList();//common-lais-util.js
		doLoginMainList.menu();

		var doHeaderInit = headerInit();
		doHeaderInit.manageLanguage();

		var doLeftBarInit = leftBarInit();
		doLeftBarInit.Init();

		$("#saveChangeBtn_id").click(function() {
			var data = $("#modalInp_id").val();
			$("#showDataInp_id").val(data);
		});
	});
</script>
</html>