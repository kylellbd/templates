<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/common/NewCSS&Meta.html"%>
<link
	href="/assets/global/plugins/jstree/dist/themes/default/style.min.css"
	rel="stylesheet" type="text/css" />
</head>
<!-- END HEAD -->

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
			<!-- BEGIN CONTENT -->
			<div class="page-content-wrapper">
				<!-- BEGIN CONTENT BODY -->
				<div class="page-content">
					<!-- BEGIN PAGE HEADER-->
					<!-- BEGIN THEME PANEL -->
					<!-- END THEME PANEL -->
					<!-- BEGIN PAGE BAR -->
					<div class="page-bar">
						<ul class="page-breadcrumb">
							<li><a href="index.html">Home</a> <i class="fa fa-circle"></i>
							</li>
							<li><a href="#">Tables</a> <i class="fa fa-circle"></i></li>
							<li><span>Datatables</span></li>
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
						Tree Views &amp; Controls <small>interactive tree views
							and controls based on popular jsTree jquery plugin</small>
					</h1>
					<div class="row">
						<div class="col-md-6">
							<div class="portlet light bordered">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-social-dribbble font-blue-sharp"></i> <span
											class="caption-subject font-blue-sharp bold uppercase">Default
											Tree，在html里写，加载得慢的话会没样式</span>
									</div>
									<div class="actions">
										<a class="btn btn-circle btn-icon-only btn-default"
											href="javascript:;"> <i class="icon-cloud-upload"></i>
										</a> <a class="btn btn-circle btn-icon-only btn-default"
											href="javascript:;"> <i class="icon-wrench"></i>
										</a> <a class="btn btn-circle btn-icon-only btn-default"
											href="javascript:;"> <i class="icon-trash"></i>
										</a>
									</div>
								</div>
								<div class="portlet-body">
									<div id="tree_1" class="tree-demo">
										<ul>
											<li>根节点
												<ul>
													<li data-jstree='{ "selected" : true }'><a
														href="javascript:;"> "selected" : true,默认选中状态，父节点会被打开
													</a></li>
													<li
														data-jstree='{ "icon" : "fa fa-briefcase icon-state-success " }'>
														自定义图标节点</li>
													<li data-jstree='{ "opened" : true }'>"opened" :
														true，默认打开状态
														<ul>
															<li data-jstree='{ "disabled" : true }'>Disabled
																Node</li>
															<li data-jstree='{ "type" : "file" }'>Another node</li>
														</ul>
													</li>
													<li data-jstree='{ "icon" : "fa fa-battery-quarter" }'>
														自定义图标节点</li>
												</ul>
											</li>
											<li data-jstree='{ "type" : "file" }'><a
												href="TreeViews.jsp"> 跳页面节点 </a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="portlet light bordered">
								<div class="portlet-title">
									<div class="caption">
										<i class="icon-bubble font-green-sharp"></i> <span
											class="caption-subject font-green-sharp bold uppercase">Checkable
											Tree，在js里写</span>
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
								<div class="portlet-body">
									<div id="tree_2" class="tree-demo"></div>
								</div>
							</div>
						</div>
					</div>
<!-- 					<div class="row">
						<div class="col-md-6">
							<div class="portlet yellow-lemon box">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-cogs"></i>Contextual Menu with Drag & Drop，没研究呢
									</div>
									<div class="tools">
										<a href="javascript:;" class="collapse"> </a> 
										<a href="#portlet-config" data-toggle="modal" class="config"></a> 
										<a href="javascript:;" class="reload"> </a> 
										<a href="javascript:;" class="remove"> </a>
									</div>
								</div>
								<div class="portlet-body">
									<div id="tree_3" class="tree-demo"></div>
									<div class="alert alert-success no-margin margin-top-10">
										Note! Opened and selected nodes will be saved in the user's
										browser, so when returning to the same tree the previous state
										will be restored.</div>
								</div>
							</div>
						</div>
					</div> -->
				</div>
			</div>
			<!-- BEGIN FOOTER -->
			<%@include file="/WEB-INF/jsp/common/NewFooter.jsp"%>
			<!-- END FOOTER -->
		</div>
	</div>
</body>
<%@include file="/WEB-INF/jsp/common/NewJS.html"%>
<!-- <script src="/assets/pages/scripts/ui-tree.js" type="text/javascript"></script> -->
<script src="/resources/js/app/biz/common-lais-util.js"></script>
<script type="text/javascript">
	$(function() {
		var doLoginMainList = loginMainList();//common-lais-util.js
		doLoginMainList.menu();

		var doHeaderInit = headerInit();
		doHeaderInit.manageLanguage();

		var doLeftBarInit = leftBarInit();
		doLeftBarInit.Init();

		handleSample1();
	});

	var handleSample1 = function() {

		$('#tree_1').jstree({
			"core" : {
				"themes" : {
					"responsive" : false
				}
			},
			"types" : {
				"default" : {
					"icon" : "fa fa-folder icon-state-warning icon-lg"
				},
				"file" : {
					"icon" : "fa fa-file icon-state-warning icon-lg"
				}
			},
			"plugins" : [ "types" ]
		});

		// handle link clicks in tree nodes(support target="_blank" as well)
		$('#tree_1').on(
				'select_node.jstree',
				function(e, data) {
					var link = $('#' + data.selected).find('a');
					if (link.attr("href") != "#"
							&& link.attr("href") != "javascript:;"
							&& link.attr("href") != "") {
						if (link.attr("target") == "_blank") {
							link.attr("href").target = "_blank";
						}
						document.location.href = link.attr("href");
						return false;
					}
				});

		$('#tree_2').jstree({
			'plugins' : [ "wholerow", "checkbox", "types" ],
			'core' : {
				"themes" : {
					"responsive" : false
				},
				'data' : [ {
					"text" : "Same but with checkboxes1",
					"state" : {
						"opened" : false
					},
					"children" : [ {
						"text" : "initially selected",
						"state" : {
							"selected" : false
						}
					}, {
						"text" : "custom icon",
						"icon" : "fa fa-amazon"
					}, {
						"text" : "initially open",
						"icon" : "fa fa-folder icon-state-success", //"fa fa-folder icon-state-default"
						"state" : {
							"opened" : false
						},
						"children" : [ {
							"text" : "看看",
							"state" : {
								"selected" : false
							}
						} ]
					}, {
						"text" : "custom icon",
						"icon" : "fa fa-warning icon-state-warning"
					}, {
						"text" : "disabled node",
						"icon" : "fa fa-check icon-state-success",
						"state" : {
							"disabled" : true
						}
					} ]
				}, "额外的行", {
					"text" : "Same but with checkboxes2",
					"children" : [ {
						"text" : "initially selected",
						"state" : {
							"selected" : true
						}
					}, {
						"text" : "custom icon",
						"icon" : "fa fa-warning icon-state-danger"
					} ]
				} ],

			},
			"types" : {
				"default" : {
					"icon" : "fa fa-folder icon-state-warning icon-lg"
				},
				"file" : {
					"icon" : "fa fa-file icon-state-warning icon-lg"
				}
			}
		});
		
/* 		$("#tree_3").jstree({
            "core" : {
                "themes" : {
                    "responsive": false
                }, 
                // so that create works
                "check_callback" : true,
                'data': [{
                        "text": "Parent Node",
                        "children": [{
                            "text": "Initially selected",
                            "state": {
                                "selected": true
                            }
                        }, {
                            "text": "Custom Icon",
                            "icon": "fa fa-warning icon-state-danger"
                        }, {
                            "text": "Initially open",
                            "icon" : "fa fa-folder icon-state-success",
                            "state": {
                                "opened": true
                            },
                            "children": [
                                {"text": "Another node", "icon" : "fa fa-file icon-state-warning"}
                            ]
                        }, {
                            "text": "Another Custom Icon",
                            "icon": "fa fa-warning icon-state-warning"
                        }, {
                            "text": "Disabled Node",
                            "icon": "fa fa-check icon-state-success",
                            "state": {
                                "disabled": true
                            }
                        }, {
                            "text": "Sub Nodes",
                            "icon": "fa fa-folder icon-state-danger",
                            "children": [
                                {"text": "Item 1", "icon" : "fa fa-file icon-state-warning"},
                                {"text": "Item 2", "icon" : "fa fa-file icon-state-success"},
                                {"text": "Item 3", "icon" : "fa fa-file icon-state-default"},
                                {"text": "Item 4", "icon" : "fa fa-file icon-state-danger"},
                                {"text": "Item 5", "icon" : "fa fa-file icon-state-info"}
                            ]
                        }]
                    },
                    "Another Node"
                ]
            },
            "types" : {
                "default" : {
                    "icon" : "fa fa-folder icon-state-warning icon-lg"
                },
                "file" : {
                    "icon" : "fa fa-file icon-state-warning icon-lg"
                }
            },
            "state" : { "key" : "demo2" },
            "plugins" : [ "contextmenu", "dnd", "state", "types" ]
        }); */
		
	}
</script>
</html>