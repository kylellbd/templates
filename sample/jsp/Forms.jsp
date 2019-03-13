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
		
		<div class="page-container">
			<!-- BEGIN SIDEBAR -->
			<%@include file="/WEB-INF/jsp/common/NewLeftBar.jsp"%>
			<!-- END SIDEBAR -->
			<div class="page-content-wrapper">

				<div class="page-content">
					<div class="portlet">
						<div class="page-bar">
							<ul class="page-breadcrumb">
								<li><a href="index.html">html标签上面那个东西的尖括号里面这么写!DOCTYPE
										html,要不会出莫名其妙的问题</a> <i class="fa fa-circle"></i></li>
								<li><span>span</span></li>
							</ul>
						</div>
						<div class="portlet light bordered" style="border-color: #fff !important;">
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-refresh font-green"></i> <span
										class="caption-subject bold font-green uppercase">
										<strong>页面标题</strong></span>
									<div class="caption-desc font-grey-cascade">
										Basic Validation表单验证通过标签里
										<pre class="mt-code">name</pre>
										的值和js里
										<pre class="mt-code">rules: {}</pre>
										相同的值控制,可以网上搜索
										<pre class="mt-code">bootstrapValidator</pre>
										找教程,可以参考框架里的
										<pre class="mt-code">form-validation.js</pre>
										文件或者我整理的 <pre class="mt-code">form-util.js</pre>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="row ">
									<div class="col-md-6">
										<!-- 没验证 -->
										
										<form id="form_sample_0">
											<div class="form-body">
												<div class="form-group">
													<label>Email Address</label>
													<div class="input-group">
														<span class="input-group-addon"><i
															class="fa fa-envelope"></i></span> <input type="text"
															class="form-control" placeholder="Email Address" name="name">
													</div>
												</div>

												<div class="form-group">
													<label>Circle
														Input//input-circle-left把左边变圆，input-circle-right右边</label>
													<div class="input-group">
														<span class="input-group-addon input-circle-left"><i
															class="fa fa-envelope"></i></span> <input type="text"
															class="form-control input-circle-right"
															placeholder="Email Address">
													</div>
												</div>

												<div class="form-group">
													<label for="exampleInputPassword1">Password</label>
													<div class="input-group">
														<input type="password" class="form-control"
															id="exampleInputPassword1" placeholder="Password">
														<span class="input-group-addon"><i
															class="fa fa-user font-red"></i></span>
													</div>
												</div>

												<div class="form-group">
													<label>Left
														Icon//在输入框左边显示图标，div的class是"input-icon"，不是之前的"input-group"</label>
													<div class="input-icon">
														<i class="fa fa-bell-o font-green"></i> <input type="text"
															class="form-control" placeholder="Left icon">
													</div>
												</div>

												<div class="form-group">
													<label>Right Icon</label>
													<div class="input-icon right">
														<i class="fa fa-microphone fa-spin font-blue"></i> <input
															type="text" class="form-control" placeholder="right icon">
													</div>
												</div>

												<div class="form-group">
													<input type="text" class="form-control"
														placeholder="Disabled" disabled> <br /> <input
														type="text" class="form-control" placeholder="Readonly"
														readonly>
												</div>

												<div class="form-group">
													<label>Dropdown</label> <select class="form-control">
														<option value="Option1">Option1</option>
														<option value="Option2">Option2</option>
														<option value="Option3">Option3</option>
														<option value="Option4">Option4</option>
													</select>
												</div>

												<div class="form-group">
													<label>Textarea</label>
													<textarea class="form-control" rows="3"></textarea>
												</div>

												<div class="form-group">
													<label>Outline Checkboxes</label>
													<div class="mt-checkbox-list">
														<label class="mt-checkbox mt-checkbox-outline">
															Checkbox 1 <input type="checkbox" value="1" name="test" />
															<span></span>
														</label> <label class="mt-checkbox mt-checkbox-outline">
															Checkbox 2 <input type="checkbox" value="1" name="test" />
															<span></span>
														</label> <label class="mt-checkbox mt-checkbox-outline">
															Checkbox 3 <input type="checkbox" value="1" name="test" />
															<span></span>
														</label>
													</div>
												</div>

												<div class="form-group">
													<label>Inline Checkboxes</label>
													<div class="mt-checkbox-inline">
														<label class="mt-checkbox"> <input type="checkbox"
															id="inlineCheckbox1" value="option1"> Checkbox 1
															<span></span>
														</label> <label class="mt-checkbox"> <input
															type="checkbox" id="inlineCheckbox2" value="option2">
															Checkbox 2 <span></span>
														</label> <label class="mt-checkbox mt-checkbox-disabled">
															<input type="checkbox" id="inlineCheckbox3"
															value="option3" disabled> Disabled <span></span>
														</label>
													</div>
												</div>

												<div class="form-group">
													<label>Outline Radios</label>
													<div class="mt-radio-list">
														<label class="mt-radio mt-radio-outline"> Radio 1
															<input type="radio" value="1" name="test" /> <span></span>
														</label> <label class="mt-radio mt-radio-outline"> Radio 2
															<input type="radio" value="1" name="test" /> <span></span>
														</label> <label class="mt-radio mt-radio-outline"> Radio 3
															<input type="radio" value="1" name="test" /> <span></span>
														</label>
													</div>
												</div>

												<div class="form-group">
													<label>Inline Radio</label>
													<div class="mt-radio-inline">
														<label class="mt-radio"> <input type="radio"
															name="optionsRadios" id="optionsRadios4" value="option1"
															checked> Option 1 <span></span>
														</label> <label class="mt-radio"> <input type="radio"
															name="optionsRadios" id="optionsRadios5" value="option2">
															Option 2 <span></span>
														</label> <label class="mt-radio"> <input type="radio"
															name="optionsRadios" id="optionsRadios6" value="option3"
															disabled> Disabled <span></span>
														</label>
													</div>
												</div>

												<div class="form-actions">
													<button type="submit" class="btn blue">type="Submit"</button>
													<button type="button" class="btn default">Cancel,貌似没用</button>
												</div>

											</div>
										</form>
									</div>
									<!-- 带验证 -->
									<div class="col-md-6">
										<div class="portlet light portlet-fit portlet-form bordered">
											<div class="portlet-title">
												<div class="caption">
													<i class=" icon-layers font-red"></i> <span
														class="caption-subject font-red sbold"> Basic
														Validation
													</span>

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
												<form action="#" class="form-horizontal" id="form_sample">
													<div class="form-body">

														<div class="alert alert-danger display-hide">
															<button class="close" data-close="alert"></button>
															填写有误
														</div>
														<div class="alert alert-success display-hide">
															<button class="close" data-close="alert"></button>
															Your form validation is successful!
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1"> Name<span class="required">*</span>
															</label>
															<div class="col-md-9">
																<input id="testInp" type="text" class="form-control json1" placeholder=""
																	name="name" data-key="name">
																<div class="form-control-focus"></div>
																<span class="help-block">enter your full name</span>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1"> Email<span
																class="required">*</span>
															</label>
															<div class="col-md-9">
																<input type="text" class="form-control json1" placeholder=""
																	name="email" data-key="email">
																<div class="form-control-focus"></div>
																<span class="help-block">输入邮箱</span>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1"> number<span
																class="required">*</span>
															</label>
															<div class="col-md-9">
																<input type="text" class="form-control json1" placeholder=""
																	name="number" data-key="number">
																<div class="form-control-focus"></div>
																<span class="help-block"></span>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1">好像是纯数字，不能带小数点啥的 <span
																class="required">*</span>
															</label>
															<div class="col-md-9">
																<div class="input-icon">
																	<input type="text" class="form-control"
																		placeholder="Enter digits" name="digits">
																	<div class="form-control-focus"></div>
																	<i class="fa fa-bell-o"></i>
																</div>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1">Delivery</label>
															<div class="col-md-9">
																<select id="select2" data-key="select2" class="form-control json1" name="select">
																	<option></option>
																	<option></option>
																	<option></option>
																</select>
																<div class="form-control-focus"></div>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1">Payment</label>
															<div class="col-md-9">
																<select class="form-control json1" data-key="selectMultiple" name="selectMultiple" multiple>
																	<option></option>
																	<option></option>
																	<option></option>
																	<option></option>
																	<option></option>
																</select>
																<div class="form-control-focus"></div>
															</div>
														</div>

														<div class="form-group form-md-line-input">
															<label class="col-md-3 control-label"
																for="form_control_1">Memo</label>
															<div class="col-md-9">
																<textarea class="form-control json1" data-key="textarea2" name="textarea" rows="5"></textarea>
																<div class="form-control-focus"></div>
															</div>
														</div>

														<div class="form-group form-md-checkboxes">
															<label class="col-md-3 control-label"
																for="form_control_1">Checkboxes</label>
															<div class="col-md-9">
																<div class="md-checkbox-inline">
																	<div class="md-checkbox">
																		<input id="c1" type="checkbox" name="checkboxes1" value=""
																		id="checkbox1_1" class="md-check json1" data-key="checkbox1_1"> 
																		<label for="checkbox1_1">
																		</label>
																	</div>
																	<div class="md-checkbox">
																		<input type="checkbox" name="checkboxes1" value=""
																			id="checkbox1_2" class="md-check json1" data-key="checkbox1_2">
																		<label for="checkbox1_2">
																		</label>
																	</div>
																	<div class="md-checkbox">
																		<input type="checkbox" name="checkboxes1" value=""
																			id="checkbox1_3" class="md-check json1" data-key="checkbox1_3">
																		<label for="checkbox1_3">
																		</label>
																	</div>
																</div>
															</div>
														</div>

														<div class="form-group form-md-radios">
															<label class="col-md-3 control-label"
																for="form_control_1">Radios</label>
															<div class="col-md-9">
																<div class="md-radio-inline">
																	<div class="md-radio">
																		<input type="radio" id="radio1_1" name="radio1"
																			value="" class="md-radiobtn json1" data-key="radio1_1"> 
																		<label for="radio1_1">
																		</label>
																	</div>
																	<div class="md-radio">
																		<input type="radio" id="radio1_2" name="radio1"
																			value="" class="md-radiobtn json1" data-key="radio1_2">
																		<label for="radio1_2">
																		</label>
																	</div>
																	<div class="md-radio">
																		<input type="radio" id="radio1_3" name="radio1"
																			value="" class="md-radiobtn json1" data-key="radio1_3">
																		<label for="radio1_3">
																		</label>
																	</div>
																</div>
															</div>
														</div>

														<div class="form-actions">
															<div class="row">
																<div class="col-md-offset-3 col-md-9">
																	<button type="submit" class="btn green">Validate,type="submit"</button>
																	<!-- 原先有  type="submit"-->
																	<button type="reset" class="btn default">Reset</button>
																	<button id="tu" type="button" class="btn default">see</button>
																</div>
															</div>
														</div>

													</div>
												</form>
											</div>
										</div>
									</div>
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
	<div class="quick-nav-overlay"></div>
</body>
<%@include file="/WEB-INF/jsp/common/NewJS.html"%>
<script src="/resources/js/app/biz/common-lais-util.js"></script>
<script src="/resources/js/app/biz/form-util.js"></script>
<script src="/resources/js/app/biz/Dom2Json&Json2Dom.js"></script>
<script type="text/javascript">
	$(function() {
		
		var doLoginMainList = new loginMainList();//common-lais-util.js
		doLoginMainList.menu();

		var doHeaderInit = new headerInit();
		doHeaderInit.manageLanguage();

		var doLeftBarInit = new leftBarInit();
		doLeftBarInit.Init();
		
		var doFormValidations = new formValidations();
		var $form1 = $('#form_sample');
		var $error1 = $('.alert-danger', $form1);
		var $success1 = $('.alert-success', $form1);
		doFormValidations.formValidation1($form1,null,$error1,$success1);
		
		var doD_J = new dom2Json_Json2Dom();
		
		
		$("#tu").click(function(){
			console.time("Time：");
			var jArray = {
					email: "email112",
					name: "name123",
					number: "number134",
					select2: [{
						val: "",
						text: "default",
					},{
						val: "v1",
						text: "t1"
					},{
						val: "v2",
						text: "t2"
					}],
					selectMultiple: [{
						val: "v1M",
						text: "t1M"
					},{
						val: "v2M",
						text: "t2M"
					},{
						val: "v3M",
						text: "t3M"
					},{
						val: "v4M",
						text: "t4M"
					},{
						val: "v5M",
						text: "t5M"
					}],
					textarea2: "testarea2testarea2testarea2",
					checkbox1_1: {
						val: "checkboxV1",
						text: "checkboxT1",
						checked: false
					},
					checkbox1_2: {
						val: "checkboxV2",
						text: "checkboxT2",
						checked: true
					},
					checkbox1_3: {
						val: "checkboxV3",
						text: "checkboxT3",
						checked: true
					},
					radio1_1: {
						val: "radioV1",
						text: "radioT1",
						checked: true
					},
					radio1_2: {
						val: "radioV2",
						text: "radioT2",
						checked: false
					},
					radio1_3: {
						val: "radioV3",
						text: "radioT3",
						checked: false
					}
					
			};
			
			doD_J.setVal(false, $(".json1"), jArray);
			var getVal = doD_J.getVal(false, $(".json1"));
			console.log(getVal);
			console.timeEnd("Time：");
		});
		
	});
	
</script>
</html>