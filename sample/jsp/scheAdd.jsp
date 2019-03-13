<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="/WEB-INF/jsp/lai/common/NewCSS&Meta.html" %>
<style type="text/css">
	#test{
		position: absolute;
	}
.modal-content{
		width:500px;
}
.table {
    width: 100%;
    margin-bottom: 20px;
    margin-left: 15px;
}
.bootstrap-table .table:not(.table-condensed){
         margin-left:0px;
         margin-right:0px;
}

	
</style>
</head>
<link href="/assets/global/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet" type="text/css" />
<link href="/assets/global/plugins/typeahead/typeahead.css" rel="stylesheet" type="text/css" />
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white" style="overflow:-Scroll;overflow-x:hidden">
        <div class="page-wrapper">
            <%@include file="/WEB-INF/jsp/lai/common/NewHeader.jsp" %>        
            <div class="clearfix"> </div>
            <div class="page-container">                
                <div class="page-sidebar-wrapper">
                    <%@include file="/WEB-INF/jsp/lai/common/NewLeftBar.jsp" %>
                </div>
                <div class="page-content-wrapper">
                    <!-- BEGIN CONTENT BODY -->
                    <div class="page-content">
                        <div class="page-bar">
                            <ul class="page-breadcrumb">
                                <li>
                                    <a href="index.html">Home</a>
                                    <i class="fa fa-circle"></i>
                                </li>
                                <li>
                                    <span>教育管理</span>
                                    <i class="fa fa-circle"></i>
                                </li>
                                <li>
                                    <span>课程期数登录</span>
                                </li>
                            </ul>
                            <div class="page-toolbar">
                                <div class="page-toolbar">
                                         <button type="button"
                                                 class="btn green btn-sm btn-outline dropdown-toggle"
                                                 data-toggle="dropdown">
                                                 Made by Tao mi</i>
                                         </button>
                                </div>
                            </div>
                            
                        </div>   
                        <!-- 主体开始 -->
                        <h1 class="page-title ">教育管理</h1>
                      	  
                      	<div class="row">   
                      	  <div class="col-md-12">
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption ">
                                            <span class="caption-subject font-green-haze sbold uppercase" >课程期数登录</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <!-- BEGIN FORM-->
                                        <form action="#" class="form-horizontal" id="form_sample_1" novalidate="novalidate">
                                            <div class="form-body">
                                                <div class="alert alert-danger display-hide">
                                                    <button class="close" data-close="alert"></button> You have some form errors. Please check below. </div>
                                                <div class="alert alert-success display-hide">
                                                    <button class="close" data-close="alert"></button> Your form validation is successful! </div>
                                                <!--   --------------------------------------------------------------------------------------------------- 第1行信息 -->
                                                <div class="form-group form-md-line-input">
                                                    <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true" ></span>课程期数分类:
                                                    </label>
                                                    <div class="col-md-3">
                                                        <input type="text" class="form-control" placeholder="" name="name" value="IT/页面开发/Java语言">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your information</span>
                                                    </div>
                                                    
                                                    <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>课程期数名称:
                                                    </label>
                                                   <div class="col-md-3">
                                                        <input type="text" class="form-control" placeholder="" name="name">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your information</span>
                                                    </div>
                                                   
                                                        <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>课程期数编号:
                                                    </label>
                                                    <div class="col-md-3">
                                                        <input type="text" class="form-control" placeholder="" name="name">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your information</span>
                                                    </div>
                                                    
                                                	</div>
                                                	<!--   --------------------------------------------------------------------------------------------------- 第2行信息 -->
                                                <div class="form-group form-md-line-input">
                                                      <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>进行状态:
                                                    </label>
                                                   <div class="col-md-3">
                                                        <select class="form-control">
                                                            <option value="">선택</option>
                                                            <option value="2">申请未开启</option>
                                                            <option value="3">申请进行中</option>
                                                            <option value="4">申请结束</option>
                                                        </select>
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your full information</span>
                                                    </div>
                                                    
                                                     <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>限制人数(人):
                                                    </label>
                                                    <div class="col-md-3">
                                                        <input type="text" class="form-control" placeholder="" name="name">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your information</span>
                                                    </div>
                                            
	                                            	<label class="col-md-1 control-label" for="form_control_1" >
                                                    <span class="required" aria-required="true" ></span>课程期数讲师:
                                                    </label>
                                                	<div class="col-md-2">
                                                        <input type="text" class="form-control" placeholder="">
                                                        <div class="form-control-focus"> </div>
                                                        </div>
                                                    <div class="col-md-1">
                                                     <a class="btn red btn-outline sbold" data-toggle="modal" href="#responsive"> 검색</a>
                                                    </div> 
                                                    
                                                    </div>
                                                   <!--  modal内容开始 -->
		                                           <div id="responsive" class="modal fade " tabindex="-1" aria-hidden="true">
		                                            <div class="modal-dialog">
		                                                <div class="modal-content">
		                                                    <div class="modal-header">
		                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                                                        <h4 class="modal-title">讲师</h4>
		                                                    </div>
		                                                    <div class="modal-body ">
		                                                        <div class="scroller" style="height:300px" data-always-visible="1" data-rail-visible1="1">
		                                                            <div class="row">
		                                                            	<table class="table table-hover table-striped table-bordered  ">
								                                            <tr>
								                                               <td> CS50001 </td>
								                                                <td>王小明 </td>
								                                            </tr><tr>
								                                                <td> CS50002 </td>
								                                                <td>张华 </td>
								                                            </tr><tr>
								                                                <td> CS50003 </td>
								                                                <td>李春明 </td>
								                                            </tr><tr>
								                                               <td> CS50004 </td>
								                                                <td>单瑞其</td>
								                                            </tr><tr>
								                                                <td> CS50005 </td>
								                                                <td>张建南 </td>
								                                            </tr><tr>
								                                                <td> CS50006 </td>
								                                                <td>李明玉</td>
								                                            </tr><tr>
								                                               <td> CS50007 </td>
								                                                <td>王思吉 </td>
								                                            </tr>
		                                                            	</table>
		                                                            </div>
		                                                        </div>
		                                                    </div>
		                                                    <div class="modal-footer">
		                                                        <button type="button" data-dismiss="modal" class="btn dark btn-outline">Close</button>
		                                                    </div>
		                                                </div>
		                                            </div>
		                                        </div>
                                                   <!--  modal内容结束 -->
                                                <!--   --------------------------------------------------------------------------------------------------- 第3行信息 -->
                                                     <div class="form-group form-md-line-input">
                                                    <label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>听课申请开始日:
												</label>
												<div class="col-md-3 input-icon right ">
													<input type="text" class="form-control date-picker"
														data-date="2019-02-10" data-date-format="yyyy-mm-dd"
														placeholder="">
													<div class="form-control-focus"></div>
													<i class="icon-calendar"></i>
												</div>
                                                    
                                                    <label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>听课申请结束日:
												</label>
												<div class="col-md-3 input-icon right ">
													<input type="text" class="form-control date-picker"
														data-date="2019-02-10" data-date-format="yyyy-mm-dd"
														placeholder="">
													<div class="form-control-focus"></div>
													<i class="icon-calendar"></i>
												</div>
                                                    
                                                    <label class="col-md-1 control-label" for="form_control_1">考试与否:</label>
                                                    <div class="col-md-3">
                                                        <div class="md-radio-inline">
                                                            <div class="md-radio">
                                                                <input type="radio" id="checkbox1_8" name="radio2" value="1" class="md-radiobtn">
                                                                <label for="checkbox1_8">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> 考试 </label>
                                                            </div>
                                                            <div class="md-radio">
                                                                <input type="radio" id="checkbox1_9" name="radio2" value="2" class="md-radiobtn">
                                                                <label for="checkbox1_9">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> 不考试 </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                   <!--   --------------------------------------------------------------------------------------------------- 第4行信息 -->
                                                <div class="form-group form-md-line-input">
                                                    <label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>课程期数开始日:
												</label>
												<div class="col-md-3 input-icon right ">
													<input type="text" class="form-control date-picker"
														data-date="2019-02-10" data-date-format="yyyy-mm-dd"
														placeholder="">
													<div class="form-control-focus"></div>
													<i class="icon-calendar"></i>
												</div>
                                                    
                                                    <label class="col-md-1 control-label" for="form_control_1">
													<span class="required" aria-required="true"></span>课程期数结束日:
												</label>
												<div class="col-md-3 input-icon right ">
													<input type="text" class="form-control date-picker"
														data-date="2019-02-10" data-date-format="yyyy-mm-dd"
														placeholder="">
													<div class="form-control-focus"></div>
													<i class="icon-calendar"></i>
												</div>
                                                        <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>公开与否:
                                                    </label>
                                                    <div class="col-md-3">
                                                        <div class="md-radio-inline">
                                                            <div class="md-radio">
                                                                <input type="radio" id="checkbox1_1" name="radio3" value="1" class="md-radiobtn">
                                                                <label for="checkbox1_1">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span>公开 </label>
                                                            </div>
                                                            <div class="md-radio">
                                                                <input type="radio" id="checkbox1_2" name="radio3" value="2" class="md-radiobtn">
                                                                <label for="checkbox1_2">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> 不公开</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                  
                                                </div>
                                                
                                                <!--   --------------------------------------------------------------------------------------------------- 第5行信息 -->
                                                <div class="form-group form-md-line-input">
                                                        <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>课程期数开始时间:
                                                    </label>
                                                    <div class="col-md-1">
                                                        <select class="form-control">
                                                            <option value="">선택</option>
                                                            <option value="2">01</option>
                                                            <option value="3">02</option>
                                                            <option value="4">03</option>
                                                        </select>
                                                        	<span style="position:absolute;left:125px;top:8px;">时</span>
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your full information</span>
                                                    </div>
                                                    
                                                    <div class="col-md-1">
                                                        <select class="form-control">
                                                           <option value="">선택</option>
                                                            <option value="2">01</option>
                                                            <option value="3">02</option>
                                                            <option value="4">03</option>
                                                        </select>
                                                        	<span style="position:absolute;left:125px;top:8px;">分</span>
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your full information</span>
                                                    </div>	
                                                  <div class="col-md-1"></div>
                                                      <label class="col-md-1 control-label" for="form_control_1">
                                                        <span class="required" aria-required="true"></span>课程期数结束时间:
                                                    </label>
                                                     <div class="col-md-1">
                                                        <select class="form-control">
                                                            <option value="">선택</option>
                                                            <option value="2">01</option>
                                                            <option value="3">02</option>
                                                            <option value="4">03</option>
                                                        </select>
                                                        	<span style="position:absolute;left:125px;top:8px;">时</span>
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your full information</span>
                                                    </div>
                                                    
                                                    <div class="col-md-1">
                                                        <select class="form-control">
                                                           <option value="">선택</option>
                                                            <option value="2">01</option>
                                                            <option value="3">02</option>
                                                            <option value="4">03</option>
                                                        </select>
                                                        	<span style="position:absolute;left:125px;top:8px;">分</span>
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">enter your full information</span>
                                                    </div>	
                                                  <div class="col-md-1"></div>
                                       	         <label class="col-md-1 control-label" for="form_control_1">结果报告书:</label>
                                                    <div class="col-md-3">
                                                        <div class="md-radio-inline">
                                                            <div class="md-radio">
                                                                <input type="radio" id="ch6" name="radio444" value="123" class="md-radiobtn">
                                                                <label for="ch6">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> 考试 </label>
                                                            </div>
                                                            <div class="md-radio">
                                                                <input type="radio" id="ch_9" name="radio444" value="321" class="md-radiobtn">
                                                                <label for="ch_9">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> 不考试 </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                  
                                                    </div>
                                                   <!--   --------------------------------------------------------------------------------------------------- 第6行信息 -->
                                                <div class="form-group form-md-line-input">
                                                	<label class="col-md-1 control-label" for="form_control_1" >教育场所:</label>
                                                	<div class="col-md-11">
                                                        <input type="text" class="form-control" placeholder="" name="title">
                                                    	<div class="form-control-focus"> </div>
                                                    </div>
                                                </div>
                                                <!--   --------------------------------------------------------------------------------------------------- 第7行信息 -->
                                                <div class="form-group form-md-line-input">
                                                    <label class="col-md-1 control-label" for="form_control_1">课程期数简介:</label>
                                                    <div class="col-md-11">
                                                        <textarea class="form-control" name="memo" rows="4" placeholder=""></textarea>
                                                        <div class="form-control-focus"> </div>
                                                    </div>
                                                </div>
                                                 <!--   --------------------------------------------------------------------------------------------------- 内容结束 -->
                         		</div>
                                            <div class="form-actions">
                                                <div class="row">
                                                    <div class="col-md-offset-5 col-md-9">
                                                    <button class="btn red bold uppercase" 
                                                    	data-title="是否确认登录？" 
                                                    	data-message="" 
                                                    	data-type="info" data-show-confirm-button="true" data-confirm-button-class="btn-success" 
                                                    	data-show-cancel-button="true" data-cancel-button-class="btn-default" data-close-on-confirm="false" 
                                                    	data-close-on-cancel="false" data-confirm-button-text="submit" data-cancel-button-text="cancel" 
                                                    	data-popup-title-success="登录成功" data-popup-message-success="" 
                                                    	data-popup-title-cancel="Cancelled" data-popup-message-cancel="You have disagreed to our Terms and Conditions">등 록</button>
                                                    	&nbsp;&nbsp;
												<button class="btn btn-outline sbold red mt-sweetalert" 
                                                    			type="button">취 소</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                        <!-- END FORM-->
                                    </div>
                                </div>
                                <!-- END VALIDATION STATES-->
                            </div>
                      	  </div> 
                      	  
						<!-- 主体结束 -->                
                	</div>             
            	</div>
				<%@include file="/WEB-INF/jsp/common/NewFooter.jsp" %>
        	</div>
        </div>
	<div class="quick-nav-overlay"></div>
</body>
<%@include file="/WEB-INF/jsp/lai/common/NewJS.html" %>
<script src="/resources/js/app/biz/common-lais-util.js"></script> 
<script src="/assets/pages/scripts/form-validation-md.min.js" type="text/javascript"></script>
<script src="/assets/global/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/components-bootstrap-tagsinput.min.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/form-validation-md.min.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/ui-buttons.min.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/ui-blockui.min.js" type="text/javascript"></script>
<script src="/assets/pages/scripts/ui-sweetalert.min.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	var doLoginMainList = loginMainList();
	doLoginMainList.menu();
	
 	var doLeftBarInit = leftBarInit();
	doLeftBarInit.Init();
	

	var doHeaderInit = headerInit();
	doHeaderInit.manageLanguage($COM_UTIL.LANGUAGE_GROUP);
});

</script>
</html>