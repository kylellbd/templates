<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="/WEB-INF/jsp/lai/common/NewCSS&Meta.html"%>
<style type="text/css">
/* *{border:1px solid #000;} */
td {
	vertical-align: middle !important;
}

.floatRight{
	float:right;
}

.floatLeft{
	float:left;
}

.clearFloat {
	content: '';
	display: block;
	clear: both;
}

.border1 {
	border: 1px solid #000;
}

.relative1{
	position: relative;
}

.absolute1{
	position: absolute;
}

.height50{
	height:50px !important;
}

.pagination {
	position: relative;
}

/*sweetAlert class begin*/
.silver-dark{
	background-color: #B0B0B0;
}
.silver-dark>h2{
	color: #fff !important;
}
/*sweetAlert class end*/

th,td{
	/* background-color: #E1E5EC !important;
	color: #000; */
	
}

.btn-in-table-delete{
 	width: 100%;
	height: 100%;
	padding-top:5px;
	padding-bottom:5px;
	font-weight: bolder;
}

.sweet-alert{
	z-index: 10051 !important;
}

/* .mt-checkbox>span{
	margin-left:0px !important;
	background-color: #fff !important;
} */
.mt-sweetalert{
	position: relative;
	bottom: -2px;
}

/* 调整分页CSS */
.page-list,.page-size,.caret{/* 左侧note */
	font-size:small;
}
.page-size{
	text-decoration: underline;
}
.page-list>.dropup>button{
	margin-top:-2.8px;
	padding-left:3px;
	border:0px;
}
.pagination>li>a{
	border-left:0px;
	border-right:0px;
	border-top:0px;
	background-color:#fff;
	font-size:small;
	color: #5E738B !important;
}
.pagination>li>a:hover{
	border-bottom:1px solid #578EBE;
}
.page-number.active a{
	/* border-color: #578EBE !important; */
	background-color: #578EBE;
	color: #E9EDEF !important;
}

</style>
</head>
<body
	class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
	<div class="page-wrapper">
		<!-- BEGIN HEADER -->
		<%@include file="/WEB-INF/jsp/lai/common/NewHeader.jsp"%>
		<!-- END HEADER -->
		<div class="clearfix"></div>
		<div class="page-container">
			<!-- BEGIN SIDEBAR -->
			<%@include file="/WEB-INF/jsp/lai/common/NewLeftBar.jsp"%>
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
					<h1 class="page-title">
						bootstrap table <small>我整理的js源码在bootstrapTableClientPaging&ServerPaging.js</small>
					</h1>

					<!-- client Paging Table begin-->
					<div class="mt-bootstrap-tables">
						<div class="row">
							<div class="col-md-12">
								<div class="portlet box green">
									<div class="portlet-title">
										<div class="caption">
											<i class="icon-layers"></i>&nbsp;客户端分页
										</div>
										<!-- btn green-haze btn-outline sbold uppercase -->
										<div class="actions">
											<button type="button"
												class="btn default btn-circle btn-outline sbold ">
												<i class="fa fa-plus"></i>&nbsp;Add
											</button>
										</div>
									</div>
									<div class="portlet-body">
										<button id="" type="button"
											class="btn green-haze btn-outline">
											<i class="fa fa-check"></i> button
										</button>
										<button type="button" class="btn btn-default" style="float: right; margin-left:-2px;">
											<span aria-hidden="true" class="icon-magnifier" ></span>
										</button>
										<label id="searchInp" style="float: right;"><input
											type="search" class="form-control input-inline"
											placeholder="搜索" ></label>
										<div class="clearFloat"></div>
										<table id="clientTable" class=""></table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- client Paging Table end-->

					<!-- server Paging Table begin-->
					<div class="mt-bootstrap-tables">
						<div class="row">
							<div class="col-md-12">
								<div class="portlet box blue-madison">
									<div class="portlet-title">
										<div class="caption">
											<i class="fa fa-cogs"></i>Table
										</div>
										<div class="actions">
											<!-- <a href="javascript:;" class="btn default btn-outline"> <i
												class="fa fa-plus"></i> Add
											</a> <a href="javascript:;" class="btn default btn-outline">
												<i class="fa fa-print"></i> Print
											</a> -->
										</div>
									</div>
									<div class="portlet-body">
										<div id="table-toolbar" class="table-toolbar ">
											<div class="row">
												<div class="portlet light bordered grey-steel">
													<div class="caption">
														<h4>多行插入</h4>
													</div>
													<form id="form-multi-insert" class="form-horizontal">
														<div class="form-body">
															<div id="multi-insert-input-parent" class="form-group form-md-line-input">
																<div class="col-md-4 height50">
																	<input 
																	id="inp-id-m" data-key="id-m" type="text" class="form-control" placeholder="输入ID">
																</div>
																<div class="col-md-4 height50">
																	<input 
																	id="inp-empNo-m" data-key="empNo-m" type="text" class="form-control" placeholder="输入empNo">
																</div>
																<div class="col-md-4 height50">
																	<input 
																	id="inp-empNm-m" data-key="empNm-m" type="text" class="form-control" placeholder="输入empNm">
																</div>
																<div class="col-md-4 height50">
																	<input 
																	id="inp-stat-m" data-key="stat-m" type="text" class="form-control" placeholder="输入stat">
																</div>															
															</div>
															<div class="form-actions floatRight relative1" style="bottom: 30px;">
																<button id="btn-continue-insert-m" type="button" class="btn blue">&nbsp;继续&nbsp;</button>
																<button id="btn-submit-insert-m" type="button" class="btn green-jungle">&nbsp;提交&nbsp;</button>
															</div>
														</div>
													</form>
												</div>
											</div>
										<br/>
										<button id="btn-send-param" type="button" class="btn blue-madison btn-outline">
											<i class="fa fa-plus"></i>&nbsp;发送参数
										</button>
										<a id="btn-insert" href="#add-tr-modal" type="button" class="btn blue-madison btn-outline" data-toggle="modal">
											<i class="fa fa-plus"></i>&nbsp;增加
										</a>
										<a href="#update-tr-modal" id="btn-update" type="button" class="btn blue-madison btn-outline" data-toggle="modal">
											<i class="fa fa-gear"></i>&nbsp;修改
										</a>
										<button id="btn-delete" class="btn blue-madison btn-outline mt-sweetalert">
											<i class="fa fa-close"></i>&nbsp;删除
										</button>
										<button id="btn-search" type="button" class="btn btn-default" style="float: right; margin-left:-2px;">
											<span aria-hidden="true" class="icon-magnifier" ></span>
										</button>
										<label style="float: right;"><input id="inp-search"
											type="search" class="form-control input-inline"
											placeholder="搜索" ></label>
										<select id="select-search" class="form-control input-inline" style="min-width:60px;float: right;margin-right:-2px;">
											<option>id</option>
											<option>empNo</option>
											<option>empNm</option>
										</select>
										<span style="float: right;">可能做成多个输入框的比较好</span>
										</div>
										<div class="clearFloat"></div>
										<table id="serverTable" style="">
											
										</table>
										
										<!-- add-tr-modal begin -->
										<div id="add-tr-modal" class="modal fade" tabindex="-1" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
														<h4 class="modal-title">加行</h4>
													</div>
													
													<div class="modal-body">
														<div class="scroller" style="height: 300px" ><!-- data-always-visible="1" data-rail-visible1="1" -->
															<div class="row">
																<div class="col-md-12">
																	<form id="form-insert" class="form-horizontal">
																		<div class="form-body">
																			<div class="form-group form-md-line-input">
																				<label class="col-md-3 control-label" > 
																					输入id<span aria-required="true">*</span>
																				</label>
																				<div class="col-md-9">
																					<input id="inp-id" data-key="id" type="text" class="col-md-12 form-control" >
																					<div class="form-control-focus"></div>
																				</div>
																			</div>
																			<div class="form-group form-md-line-input">
																				<label class="col-md-3 control-label" > 
																					输入empNo<span aria-required="true">*</span>
																				</label>
																				<div class="col-md-9">
																					<input id="inp-empNo"  data-key="empNo" type="text" class="col-md-12 form-control" >
																					<div class="form-control-focus"></div>
																				</div>
																			</div>
																			<div class="form-group form-md-line-input">
																				<label class="col-md-3 control-label" > 
																					输入empNm<span aria-required="true">*</span>
																				</label>
																				<div class="col-md-9">
																					<input id="inp-empNm" data-key="empNm" type="text" class="col-md-12 form-control" >
																					<div class="form-control-focus"></div>
																				</div>
																			</div>
																			<div class="form-group form-md-line-input">
																				<label class="col-md-3 control-label" > 
																					输入stat<span aria-required="true">*</span>
																				</label>
																				<div class="col-md-9">
																					<input id="inp-stat" data-key="stat" type="text" class="col-md-12 form-control" >
																					<div class="form-control-focus"></div>
																				</div>
																			</div>
																		</div>
																	</form>
																	
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<p id="insert-tr-modal-success"></p>
														<button id="insert-tr-modal-alert-test">alert测试</button>
														<button id="close-btn" type="button" data-dismiss="modal" class="btn dark btn-outline">Close</button>
														<button id="save-btn" type="button" class="btn green">Save changes</button>
													</div>
												</div>
											</div>
										</div>
										<!-- add-tr-modal end -->
										
										<!-- update-tr-modal begin -->
										<div id="update-tr-modal" class="modal fade" tabindex="-1" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
														<h4 class="modal-title">修改</h4>
													</div>
													
													<div class="modal-body">
														<div class="scroller" style="height: 300px" >
															<div class="row">
																<div class="col-md-12">
																	<form id="form-update" class="form-horizontal">
																		<div id="update-tr-modal-form-body" class="form-body">
																			没选要修改的行？
																		</div>
																	</form>
																	
																</div>
															</div>
														</div>
													</div>
													<div class="modal-footer">
														<p id="update-tr-modal-success" class="mt-sweetalert" tabindex="1"></p>
														<button id="update-tr-modal-close-btn" type="button" data-dismiss="modal" class="btn dark btn-outline">Close</button>
														<button id="update-tr-modal-save-btn" type="button" class="btn green">Save changes</button>
													</div>
												</div>
											</div>
										</div>
										<!-- update-tr-modal end -->
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- server Paging Table end-->


				</div>
			</div>
			<!-- BEGIN FOOTER -->
			<%@include file="/WEB-INF/jsp/lai/common/NewFooter.jsp"%>
			<!-- END FOOTER -->
		</div>
	</div>
	<input id="textHelper" type="hidden">
</body>
<%@include file="/WEB-INF/jsp/lai/common/NewJS.html"%>

<script src="/assets/lai_js/bootstrapTableClientPaging&ServerPaging.js"></script>
<script src="/assets/lai_js/Dom2Json&Json2Dom.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	funfun();
	var doLoginMainList = new loginMainList();//common-lais-util.js
	doLoginMainList.menu();
	doLoginMainList.label();
	
	var doHeaderInit = new headerInit();
	doHeaderInit.manageLanguage();
	
	var doLeftBarInit = new leftBarInit();
	doLeftBarInit.Init();
	
	var doD_J = new dom2Json_Json2Dom();
	
	var makeTable = new bootstrapTableCus();
	
	var $clientTable = $("#clientTable");//table便签对象
	var clientUrl = '/lais/lais/selectTableC.json';//请求路径
	var clientOptions = {//重写bootstrapTableClientPaging&ServerPaging.js里我写的参数，可以直接在那里改，也可以自己写bootstrapTable
		pageSize: 4,//每页显示几行，默认10
		pageList: [1, 3, 5],//可选每页显示几行，默认[1, 10, 50]
		//showToggle: true,
		columns: [{//table列，title随便，Field里是返回的key
			title: "",
			field: "state",
			checkbox: true
		},{
			title: "applyId",
			field: "APPLY_ID",
			formatter: function(value, row, index){
				return '<a href="#" class="btn green btn-xs disabled"><i class="fa fa-lock"></i>  '+value+' </a>';
			}
		},{
			title: "applId",
			field: "APPL_ID"
		},{
			title: "applNm",
			field: "APPL_NM",
			formatter: function(value,row,index){
				return '<button type="button" class="btn btn-info btn-xs">'
				+'<i class="fa fa-user"></i> '+value
				+' </button>'
			}
		},{
			title: "applNo",
			field: "APPL_NO"
		},{
			title: "applStatCd",
			field: "APPL_STAT_CD"
		},{
			title: "applStatNm",
			field: "APPL_STAT_NM",
			formatter: function(value, row, index){
				return '<span class="label label-sm label-danger"> '+value+' </span>'
			}
		},{
			title: "skillId",
			field: "SKILL_ID"
		},{
			title: "appr1Id",
			field: "APPR1_ID"
		},{
			title: "appr2Id",
			field: "APPR2_ID"
		},{
			title: "操作",
			formatter: function(value, row, index){
				return '<a href=\"javascript:go()\" class="btn btn-circle btn-sm dark btn-outline mt-sweetalert btn-sweetAlert-example">'
               + '<i class="fa fa-edit"></i> sweetAlert </a>';//  通过\"javascript:go()\"找到 function go(){}
			}
		},{
			align: "center",
			title: "点击单元格",
			formatter: function(value, row, index){
				return '<button type="button" class="btn btn-link btn-in-table-delete">删除 </button>';
			}
		}],
		onClickCell: function (field, value, row, $element) {
        	if(field == 11){
        		swal({
        			title: "删除吗?(假的)",
        			text: "删除选中的列(假的)" ,
        			type: "info",
        			showConfirmButton: true,
        			showCancelButton: true,
        			confirmButtonClass: "btn-info",
        			cancelButtonClass: "btn-default",
        			allowEscapeKey: false,
        			closeOnConfirm: false,
        			closeOnCancel: false,
        			confirmButtonText: "删除(假的)",
        			cancelButtonText: "不(假的)",
        			containerClass: ""
        		},
        		function(isConfirm){
        			if (isConfirm){
        				swal({
        					title: "删除了(假的)",
        	        		text: "删除选中的列了(假的)",
        	        		type: "success",
        	        		showConfirmButton: true,
        	        		confirmButtonClass: "btn-success" ,
        	        		closeOnConfirm: true,
        	        		confirmButtonText: "知道了(假的)"
        	        	});
        			} else {
        				swal({
        					title: "没删除(假的)",
        	        		text: "没删除选中的列(假的)",
        	        		type: "warning",
        	        		showConfirmButton: true,
        	        		confirmButtonClass: "btn-info" ,
        	        		closeOnConfirm: true,
        	        		confirmButtonText: "知道了(假的)"
        	        	});
        		    }
        		});
        	}
            return false;
        },
		queryParams: function(params){//参数
			
		}
	};
	makeTable.makeBootstrapTable($clientTable,'client',clientUrl,clientOptions);
	
	//selectTable开始
	var $serverTable = $("#serverTable");
	var serverUrl = '/lais/lais/selectTable.json';
	var columns = [{//field是controller返回时数据
			checkbox: true/* ,
			formatter: function(value, row, index){
				//console.log(overAllIds);
				//if($.inArray(row.id,Array.from(overAllIds)))
				return {checked: true}
			} */
		},{
			title: "序号",
			width: "55px",
			align: 'center',
			formatter: function(value, row, index){
				return (index+1);
			}
		},{
			title: "id",
			field: "ID",
			formatter: function(value, row, index){
				return '<a class="btn blue-hoki btn-xs disabled"><i class="fa fa-lock"></i>  '+value+' </a>';
			}
		},{
			title: "empNo",
			field: "EMP_NO",
			formatter: function(value, row, index){
				return value;
			}
		},{
			title: "empNm",
			field: "EMP_NM"
		},{
			title: "stat",
			field: "STAT"
		},{
			title: "操作",
			formatter: funfun
		}];
	
	var serverOptions = {
			pageSize: 5,
			pageList: [1, 5, 10, 50],
			columns: columns,
			queryParams: function(params){
				var rowPerPage;
				var pageNo;
				var firstRowIndex;
				var lastRowIndex;
				var pageParam = {};
				var dataSet = {};
				var fields = {};
				
				fields = {
						rowPerPage: params.limit,
						pageNo: (params.offset/params.limit)+1,
						firstRowIndex: params.offset+1,
						lastRowIndex: (params.offset/params.limit+1)*params.limit
				};
				dataSet["fields"] = fields;
				pageParam["dataSet"] = dataSet;
				return pageParam;
			}
		};
	makeTable.makeBootstrapTable($serverTable,'server',serverUrl,serverOptions);
	//selectTable结束
	
	
	
	//传选中一行或多行的数据getParam
	$("#btn-send-param").click(function(){
		var tableId = "serverTable";
		var serviceId = tableId;
		var param = {};
		var dataSet = {};
		var recordSets = {};
		recordSets[serviceId] = {
				list: $("#"+tableId).bootstrapTable("getSelections"), function(row){
					return row;
				}//获取选中checkbox的那行数据
		};
		dataSet["recordSets"] = recordSets;
		param["dataSet"] = dataSet;
		param["serviceId"] = serviceId;
		stringifiedParam = JSON.stringify(param);//这么套是为了让DataStructure接收
		
		$.ajax({
			url: "/lais/lais/getParam.json",
			data: stringifiedParam,
			type: "POST",
			contentType: "application/json",
			success: function(res){
			},
			error: function(e){
				alert('error at Tables.jsp');
				console.log(e);
			}
		});
	});
	//getParam结束
	
	//selectTable-search开始
	$("#btn-search").click(function(){
		var searchCol = $("#select-search").val();
		var searchData = {
				id : "",
				empNo : "",
				empNm : ""
		};//搜索项
		var searchInpVal = $("#inp-search").val();//搜索啥
		
		if(searchCol == "id"){
			searchData.id = searchInpVal;
		}else if(searchCol == "empNo"){
			searchData.empNo = searchInpVal;
		}else if(searchCol == "empNm"){
			searchData.empNm = searchInpVal;
		}
		
		serverOptions.queryParams = function(params){//传参
			var rowPerPage;
			var pageNo;
			var firstRowIndex;
			var lastRowIndex;
			var pageParam = {};
			var dataSet = {};
			var fields = {};
			fields = {
					rowPerPage: params.limit,
					pageNo: (params.offset/params.limit)+1,
					firstRowIndex: params.offset+1,
					lastRowIndex: (params.offset/params.limit+1)*params.limit,
					id: searchData.id,
					empNo: searchData.empNo,
					empNm: searchData.empNm
			};
			dataSet["fields"] = fields;
			pageParam["dataSet"] = dataSet;
			return pageParam;
		}
		makeTable.makeBootstrapTable($serverTable,'server',serverUrl,serverOptions);//重新加载bootstrapTable
	});
	//selectTable-search结束
	
//insertTable开始
	$("#btn-insert").on('click',function(){
		$("#insert-tr-modal-success").html("&nbsp;");//往标签里插个空格，好留个提示的地方
	});

	$("#save-btn").on('click',function(){
		var pageParam = {};
		var dataSet = {};
		var fields = {};
		fields = doD_J.getVal(true, $("#form-insert"));//从指定标签的  带有data-key属性的子标签里获取value值，以{data-key的值: 标签的value值}的形式生成json数据
		dataSet["fields"] = fields;
		pageParam["dataSet"] = dataSet;
		
		$.ajax({
			url: "/lais/lais/insertTable.json",
			data: JSON.stringify(pageParam),
			type: "POST",
			contentType: "application/json",
			success: function(res){
				var rowCount = res.rowCount;
				if(res.flag){
					$("#insert-tr-modal-success").empty();
					$("#insert-tr-modal-success").text("增加了"+res.rowCount+"条");
				}else{
					$("#insert-tr-modal-success").empty();
					$("#insert-tr-modal-success").text("增加失败");
				}
				
			},
			error: function(e){
				alert('error at Tables.jsp');
				console.log(e);
			}
		});
	});
	
	$("#close-btn").on('click',function(){
		$("#insert-tr-modal-success").empty();
		makeTable.makeBootstrapTable($serverTable,'server',serverUrl,serverOptions);
	});
	//insertTable结束
	
	//updateTable开始
	$("#btn-update").on('click',function(){
		$("#update-tr-modal-success").html("&nbsp;");
		var list = $("#serverTable").bootstrapTable("getSelections");
		var html = "";
		var length = list.length;

		for(var i=0;i<length;i++){
			delete list[i]["ROWNUMBER"];
			delete list[i]["state"];
			delete list[i]["TOTALCNT"];
			delete list[i]["0"];//把不当修改的从数组里删了
			
			for(var k in list[i]){
				html += '<div class="form-group form-md-line-input">'
				+ '<label class="col-md-3 control-label">' + '输入'+k+'<span aria-required="true">*</span>' + '</label>'
				+ '<div class="col-md-9">'
				+ '<input name='+list[i]["ID"]+' data-key='+k+' type="text" class="form-control inp-update" value='+list[i][k]+'>'
				+ '</div></div>';
				
			}
			
		}
		
		if(html != ""){
			$("#update-tr-modal-form-body").empty();
			$("#update-tr-modal-form-body").append(html);
		}
		
	});
	
	$("#update-tr-modal-save-btn").on('click',function(){
		var param = {};
		var dataSet = {};
		var fields = {};
		fields = doD_J.getVal(false, $(".inp-update"));//从指定class的标签里获取value值，以{data-key的值: 标签的value值}的形式生成json数据
		dataSet["fields"] = fields;
		param["dataSet"] = dataSet;
		
		$.ajax({
			url: "/lais/lais/updateTable.json",
			data: JSON.stringify(param),
			type: "POST",
			contentType: "application/json",
			success: function(res){
				var rowCount = res.rowCount;
				if(res.flag){
					$("#update-tr-modal-success").empty();
					$("#update-tr-modal-success").text("修改了"+rowCount+"条");
				}else{
					$("#update-tr-modal-success").empty();
					$("#update-tr-modal-success").text("没修改");
				}
				
			},
			error: function(e){
				alert('error at Tables.jsp');
				console.log(e);
			}
		});
	});
	
	$("#update-tr-modal-close-btn").on("click",function(){
		$("#update-tr-modal-success").empty();
		makeTable.makeBootstrapTable($serverTable,'server',serverUrl,serverOptions);
	});
//updateTable结束
	
//deleteTable开始
	$("#btn-delete").on('click',function(){
		//框架里的属性
		/* var defaultParams = {
				  title: '',
				  text: '',
				  type: null,
				  allowOutsideClick: false,
				  showConfirmButton: true,
				  showCancelButton: false,
				  closeOnConfirm: true,
				  closeOnCancel: true,
				  confirmButtonText: 'OK',
				  confirmButtonClass: 'btn-primary',
				  cancelButtonText: 'Cancel',
				  cancelButtonClass: 'btn-default',
				  containerClass: '',
				  titleClass: '',
				  textClass: '',
				  imageUrl: null,
				  imageSize: null,
				  timer: null,
				  customClass: '',
				  html: false,
				  animation: true,
				  allowEscapeKey: true,
				  inputType: 'text',
				  inputPlaceholder: '',
				  inputValue: '',
				  showLoaderOnConfirm: false
				}; */
		
		swal({
			  title: "删除吗?",
			  text: "删除选中的列",
			  type: "info",//弹窗上的图标
			  allowOutsideClick: false,//在同时有确认和取消按钮时，点击弹窗外边触发取消按钮
			  showConfirmButton: true,
			  showCancelButton: true,
			  confirmButtonClass: "btn-info" ,
			  cancelButtonClass: "btn-default",
			  closeOnConfirm: false,
			  closeOnCancel: false,
			  confirmButtonText: "删除",
			  cancelButtonText: "不",
			  containerClass: undefined
			},
			function(isConfirm){//isConfirm返回点的是确认还是取消(true,false)
		        if (isConfirm){
		        	var param = {};
		    		var dataSet = {};
		    		var fields = {};
		    		
		    		fields = $("#serverTable").bootstrapTable("getSelections")[0];
		    		dataSet["fields"] = fields;
		    		param["dataSet"] = dataSet;
		    		
		    		$.ajax({
		    			url: "/lais/lais/deleteTable.json",
		    			data: JSON.stringify(param),
		    			type: "POST",
		    			contentType: "application/json",
		    			success: function(res){
		    				var rowCount = res.rowCount;
		    				
		    				if(res.flag){
		    					swal({
		        					title: "删除了",
		        	        		text: "删除选中的行了",
		        	        		type: "success",
		        	        		showConfirmButton: true,
		        	        		confirmButtonClass: "btn-success" ,
		        	        		closeOnConfirm: true,
		        	        		confirmButtonText: "知道了"
		        	        	});
		    					makeTable.makeBootstrapTable($serverTable,'server',serverUrl,serverOptions);
		    				}else{
		    					swal({
		        					title: "删除失败了",
		        	        		text: "是不是没选要删除的行？",
		        	        		type: "warning",
		        	        		showConfirmButton: true,
		        	        		confirmButtonClass: "btn-warning" ,
		        	        		closeOnConfirm: true,
		        	        		confirmButtonText: "知道了"
		        	        	});
		    				}
		    				
		    			},
		    			error: function(e){
		    				swal({
	        					title: "出错了",
	        	        		text: "in error",
	        	        		type: "error",
	        	        		showConfirmButton: true,
	        	        		confirmButtonClass: "btn-error" ,
	        	        		closeOnConfirm: true,
	        	        		confirmButtonText: "那好吧"
	        	        	});
		    			}
		    		});
		        } else {
		        	swal({
    					title: "没删除",
    	        		text: "删除取消了",
    	        		type: "info",
    	        		showConfirmButton: true,
    	        		confirmButtonClass: "btn-info" ,
    	        		closeOnConfirm: true,
    	        		confirmButtonText: "知道了"
    	        	});
		        }
			});
	});
	//deleteTable结束
	
	//multiInsertTable开始
	/* $("#btn-continue-insert-m").on("click",function(){
		
	}); */
	//multiInsertTable结束
	
});


//让table里显示有后台数据的下拉框
function funfun(value, row, index){
	
	var html = "";
	$.ajax({
		url: "/lais/lais/selectTableC.json",
		data: {},
		type: "POST",
		contentType: "application/json",
		success: function(res){
			var length = res.length;	
			for(var i=0;i<length;i++){
				html += '<option>'+res[i]["APPL_NM"]+'</option>';
			}
			
			$("#textHelper").empty();
			$("#textHelper").val(html);//往隐藏的input里插html代码，原因在后面
		},
		error: function(e){
			alert('error at Tables.jsp');
			console.log(e);
		}
	});
	
	//console.log(html);//输出的是html的初始值，所以在ajax里把要返回的html代码插进隐藏的input，用的时候在取出来
	
	return ['<select class="form-control" style="min-width:100px; max-width:300px;">'
	+ $("#textHelper").val() 
	+ '</select>'];//这么写而不是一起把标签拼完效率可能会好一点，因为不需要因为在for循环里写if
};
//让table里显示有后台数据的下拉框结束


//sweetAlert in bootstrapTable开始
function go(){
	swal({
		title: "删除吗?(假的)",
		text: "删除选中的列(假的)" ,
		type: "warning",
		showConfirmButton: true,
		showCancelButton: true,
		confirmButtonClass: "btn-warning",
		cancelButtonClass: "btn-default",
		allowEscapeKey: false,
		closeOnConfirm: true,
		closeOnCancel: true,
		confirmButtonText: "删除(假的)",
		cancelButtonText: "不(假的)",
		containerClass: ""
	});
	
}
//sweetAlert in bootstrapTable结束

//alert in surface开始
$("#insert-tr-modal-alert-test").click(function(){
	swal({
		title: "see",
		text: "seesee" ,
		type: "warning",
		showConfirmButton: true,
		showCancelButton: false,
		confirmButtonClass: "btn-default",
		allowEscapeKey: false,
		closeOnConfirm: true,
		confirmButtonText: "close",
		containerClass: "silver-dark"
	});
});
//alert in surface结束
</script>
</html>