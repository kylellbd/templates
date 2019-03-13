<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="shortcut icon" href="favicon.ico" />
<link href="/assets/global/plugins/bootstrap-sweetalert/sweetalert.css"
	rel="stylesheet" type="text/css" />
<%@include file="/WEB-INF/jsp/common/NewCSS&Meta.html"%>
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
	<div class="page-wrapper">
		<!-- BEGIN HER -->
		<%@include file="/WEB-INF/jsp/lai/common/NewHeader.jsp"%>
		<!-- END HEADER -->
		<!-- BEGIN HEADER & CONTENT DIVIDER -->
		<div class="clearfix"></div>
		<!-- END HEADER & CONTENT DIVIDER -->
		<!-- BEGIN CONTAINER -->
		<div class="page-container">
			<!-- BEGIN SIDEBAR -->
			<div class="page-sidebar-wrapper">
				<%@include file="/WEB-INF/jsp/lai/common/NewLeftBar.jsp"%>
			</div>
			<!-- END SIDEBAR -->

			<!-- BEGIN CONTENT -->
			<div class="page-content-wrapper">
				<!-- BEGIN CONTENT BODY -->
				<div class="page-content">
					<!-- BEGIN PAGE HEADER-->
					<!-- BEGIN THEME PANEL -->
					<div class="theme-panel hidden-xs hidden-sm">
						<div class="theme-options">
							<div class="theme-option theme-colors clearfix">
								<span> THEME COLOR </span>
								<ul>
									<li class="color-default current tooltips" data-style="default"
										data-container="body" data-original-title="Default"></li>
									<li class="color-darkblue tooltips" data-style="darkblue"
										data-container="body" data-original-title="Dark Blue"></li>
									<li class="color-blue tooltips" data-style="blue"
										data-container="body" data-original-title="Blue"></li>
									<li class="color-grey tooltips" data-style="grey"
										data-container="body" data-original-title="Grey"></li>
									<li class="color-light tooltips" data-style="light"
										data-container="body" data-original-title="Light"></li>
									<li class="color-light2 tooltips" data-style="light2"
										data-container="body" data-html="true"
										data-original-title="Light 2"></li>
								</ul>
							</div>
							<div class="theme-option">
								<span> Theme Style </span> <select
									class="layout-style-option form-control input-sm">
									<option value="square" selected="selected">Square
										corners</option>
									<option value="rounded">Rounded corners</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Layout </span> <select
									class="layout-option form-control input-sm">
									<option value="fluid" selected="selected">Fluid</option>
									<option value="boxed">Boxed</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Header </span> <select
									class="page-header-option form-control input-sm">
									<option value="fixed" selected="selected">Fixed</option>
									<option value="default">Default</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Top Menu Dropdown</span> <select
									class="page-header-top-dropdown-style-option form-control input-sm">
									<option value="light" selected="selected">Light</option>
									<option value="dark">Dark</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Sidebar Mode</span> <select
									class="sidebar-option form-control input-sm">
									<option value="fixed">Fixed</option>
									<option value="default" selected="selected">Default</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Sidebar Menu </span> <select
									class="sidebar-menu-option form-control input-sm">
									<option value="accordion" selected="selected">Accordion</option>
									<option value="hover">Hover</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Sidebar Style </span> <select
									class="sidebar-style-option form-control input-sm">
									<option value="default" selected="selected">Default</option>
									<option value="light">Light</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Sidebar Position </span> <select
									class="sidebar-pos-option form-control input-sm">
									<option value="left" selected="selected">Left</option>
									<option value="right">Right</option>
								</select>
							</div>
							<div class="theme-option">
								<span> Footer </span> <select
									class="page-footer-option form-control input-sm">
									<option value="fixed">Fixed</option>
									<option value="default" selected="selected">Default</option>
								</select>
							</div>
						</div>
					</div>
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
								<!-- <button type="button"
									class="btn green btn-sm btn-outline dropdown-toggle"
									data-toggle="dropdown">
									Actions <i class="fa fa-angle-down"></i>
								</button> -->
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
								<div class="page-toolbar">
                                 	<div class="page-toolbar">
                                    	<button type="button"
                                                     class="btn green btn-sm btn-outline dropdown-toggle" data-toggle="dropdown">
                                                    <i>Made by Ma Li Na</i>
                                        </button>
                                     </div>
                                </div>
								
							</div>
						</div>
					</div>
					<!-- END PAGE BAR -->
					<!-- BEGIN PAGE TITLE-->
					<h1 class="page-title">
						교육과정 관리
					</h1>
					<!-- END PAGE TITLE-->
					<!-- END PAGE HEADER-->
					<div class="row">
						<div class="col-md-12">
							<!-- BEGIN EXAMPLE TABLE PORTLET-->
							<div class="portlet light portlet-fit bordered">
								<!-- BEGIN PORTLET TITLE-->
								<div class="portlet-title" style="background-color: #E9EDEF">
									<form action="#" class="form-horizontal" id="form_sample_1" novalidate="novalidate">
										<div class="form-body">
											<!-- LINE 1 -->
											<!-- <div class="form-group form-md-line-input has-success">
												
                                                    <input type="text" class="form-control" id="form_control_1" placeholder="" >
                                                   
                                                    <label for="form_control_1">Success input</label>
                                                </div>
											 -->
											<div class="form-group form-md-line-input " style="margin-bottom:0px">
												<label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>교육과정명
												</label>
												<div class="col-md-2">
													<input type="text" class="form-control" placeholder=""  name="name">
													<div class="form-control-focus"></div>
												</div>
												
												<label class="col-md-1 control-label" for="form_control_1">교육유형</label>
												<div class="col-md-2">
													<select class="form-control">
														    <option value="1">전체</option>
                                                            <option value="2">사내교육</option>
                                                            <option value="3">사외교육</option>
                                                            <option value="4">Learning Portal</option>
                                                            <option value="5">Learning Mate</option>
                                                            <option value="6">동영상</option>
                                                            <option value="7">세미나</option>
													</select>
													<div class="form-control-focus"></div>
												</div>
												
												<label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>등록일
												</label>
												<div class="col-md-2 input-icon right ">
													<input type="text" class="form-control date-picker"
														data-date="2019-02-10" data-date-format="yyyy-mm-dd"
														placeholder="">
													<div class="form-control-focus"></div>
													<i class="icon-calendar"></i>
												</div>
											</div>
											
											
											
											<!-- LINE 2  -->
											<div class="form-group form-md-line-input"  style="margin-bottom:0px">
												<label class="col-md-1 control-label" for="form_control_1">교육과정코드</label>
													<div class="col-md-2">
													   <input type="text" class="form-control" placeholder=""  name="name">
													   <div class="form-control-focus"></div>
												    </div>
												    
												<label class="col-md-1 control-label" for="form_control_1">공개여부</label>
												<div class="col-md-2">
													<select class="form-control">
													        <option value="">전체</option>
														    <option value="1">공개</option>
                                                            <option value="2">비공개</option>
													</select>
													<div class="form-control-focus"></div>
												</div>
												
												
												<div class="col-md-3"></div>
												<div class="col-md-3  hei">
													 <div  style="float: right;">
								                         <button type="button" class="btn red btn-outline sbold uppercase" >조회</button>
								                         <button type="button" class="btn red bold"  >신규등록 <i class="fa fa-plus"></i></button> 
								                         <button type="button" class="btn red bold"  >일괄등록 <i class="fa fa-plus"></i></button> 
							                         </div>
													<!-- <div style="float: right;">
														<button type="button" class="btn red bold" style="position: absolute; right: 50px; bottom: 0px;">New <i class="fa fa-plus"></i>
														</button>
														<button type="button"
															class="btn red btn-outline sbold uppercase"
															style="position: absolute; right: 130px; bottom: 0px">Search</button>
													</div> -->
												</div>
											</div>
										</div>
									</form>
								</div>
								<!-- END PORTLET TITLE-->
								<!-- BEGIN PORTLET BODY-->
						<div class="portlet-body">
								<table id="clientTable" class=""></table>
						</div>
								<!-- END PORTLET BODY-->
					</div>
							<!-- END EXAMPLE TABLE PORTLET-->
				</div>
		<!-- END CONTENT BODY -->
	</div>
	<!-- END CONTENT -->

	</div>
	</div>

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<%@include file="/WEB-INF/jsp/lai/common/NewFooter.jsp"%>
		</div>
	</div>
	
	<input id="textHelper" type="text">
	
<script src="/assets/global/plugins/bootstrap-sweetalert/sweetalert.min.js" type="text/javascript"></script>		
<script src="/assets/pages/scripts/ui-sweetalert.min.js" type="text/javascript"></script>
<script src="/assets/global/scripts/datatable.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/table-bootstrap.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/table-datatables-scroller.js" type="text/javascript"></script>
<script src="/resources/js/app/biz/bootstrapTableClientPaging&ServerPaging.js"></script>
</body>
<%@include file="/WEB-INF/jsp/common/NewJS.html"%>
<script type="text/javascript">
	$(function() {
	 	var doLoginMainList = loginMainList();
		doLoginMainList.menu();

		var doLeftBarInit = leftBarInit();
		doLeftBarInit.Init();

		var doHeaderInit = headerInit();
		doHeaderInit.manageLanguage($COM_UTIL.LANGUAGE_GROUP); 
		
		
		
		funfun();
		var makeTable = new bootstrapTableCus();
		var $clientTable = $("#clientTable");//table便签对象
		var clientUrl = '/biz/ojt/selectTableH.json';   //请求路径
		var clientOptions = {//重写bootstrapTableClientPaging&ServerPaging.js里我写的参数，可以直接在那里改，也可以自己写bootstrapTable
			pageSize: 4,                     //每页显示几行，默认10
			pageList: [4, 30, 50],      //可选每页显示几行，默认[1, 10, 50]
			columns: [{                      //table列，title随便，Field里是返回的key
			 	title: "번호",
			 	formatter: function(value, row, index){
					return index+1;
				}
			},{ 
				title: "교육과정코드",
				field: "applyId"
			/* 	formatter: function(value, row, index){
					return '<a href="#" class="btn green btn-xs disabled">'+row.applyId+' </a>';
				} */
			},{
				title: "교육과정명",
				field: "applId"
			},{
				title: "기술능력항목",
				field: "applNm"
				/* formatter: function(value,row,index){
					return '<button type="button" class="btn btn-info btn-xs">'
					+'<i class="fa fa-user"></i> '+value
					+' </button>'
				} */
			},{
				title: "교육유형",
				field: "applNo"
			},{
				title: "교육기관",
				field: "applStatCd"
			},{
				title: "교육과정설명",
				field: "applStatNm"
			},{
				title: "교육담당자",
				field: "skillId"
			},{
				title: "등록일",
				field: "appr1Id"
			},{
				title: "공개여부",
				field: "appr2Id"
			},{
				title: "기능",
				formatter: function(value, row, index){
					//看一下这3个参数是啥				
					//alert("value"+value);
					console.log(row)//row里东西挺多，可能有用
					//alert("row=============="+JSON.stringify(row));
					//alert("index=============="+JSON.stringify(index));
					console.log(index)
					return '<a href="eduMgt.do" class="btn btn-circle btn-sm dark btn-outline ">'
	               + '<i class="fa fa-edit"></i> 상세보기 </a>';
				}
			}],
			queryParams: function(params){//参数
				
			}
		};
		makeTable.makeClientPagingTable($clientTable,clientUrl,clientOptions);
		
	});
		
	    
		
		
		
		function funfun(value, row, index){
		          //alert("111111");
			var html = "";
			
			$.ajax({
				url: "/biz/ojt/selectTableC.json",
				data: {},
				type: "POST",
				contentType: "application/json",
				success: function(res){
					                                            //alert(JSON.stringify(res));
					var length = res.length;	
					for(var i=0;i<length;i++){
						html += '<option>'+res[i]["applNm"]+'</option>';
						//alert(html);
					}
					$("#textHelper").val(html);//往隐藏的input里插html代码，原因在后面
				},
				error: function(e){
					alert('error at Tables.jsp');
					console.log(e);
				}
			});
			
			console.log(html);//输出的是html的初始值，所以在ajax里把要返回的html代码插进隐藏的input，用的时候在取出来
			
			return ['<select class="form-control" style="min-width:100px;">'
			+ $("#textHelper").val() 
			+ '</select>'];//这么写而不是一起把标签拼完效率可能会好一点，因为不需要因为在for循环里写if
		};
	
</script>
<style type="text/css">
#sample_editable_1_filter {
	display: none;
}
/* .form-group .form-md-line-input{
	margin-bottom:0px!important;
}  */
.portlet.light.portlet-fit>.portlet-title {
    padding: 10px 20px 20px 20px;
}
.form-group.form-md-line-input.has-error .form-control.edited:not ([readonly]
	)~.form-control-focus:after, .form-group.form-md-line-input.has-error .form-control.edited:not
	([readonly] )~label:after, .form-group.form-md-line-input.has-error .form-control.focus:not
	([readonly] )~.form-control-focus:after, .form-group.form-md-line-input.has-error .form-control.focus:not
	([readonly] )~label:after, .form-group.form-md-line-input.has-error .form-control.form-control-static
	~.form-control-focus:after, .form-group.form-md-line-input.has-error .form-control.form-control-static
	~label:after, .form-group.form-md-line-input.has-error .form-control:focus:not
	([readonly] )~.form-control-focus:after, .form-group.form-md-line-input.has-error .form-control:focus:not
	([readonly] )~label:after{
	background: red !important;
}
.th-inner {
		color: white;
		background-color: #44b6ae;
	} 
</style>
</html>