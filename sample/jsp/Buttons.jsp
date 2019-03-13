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
						Buttons <small>metronic & bootstrap style buttons,
							dropdowns, dropdown buttons, icon buttons, social icons, toolbars
							and more</small>
					</h1>
					<!-- END PAGE TITLE-->
					<!-- END PAGE HEADER-->
					<div class="row">
						<div class="col-md-12">
							<div class="tabbable-line">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#tab_1_1" data-toggle="tab">Square
											Buttons</a></li>
									<li><a href="#tab_1_2" data-toggle="tab">Circle &
											Spinner Buttons，不只是圆角，有特效 <span
											class="label label-sm label-danger circle">new</span>
									</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="tab_1_1">
										<div class="row">
											<div class="col-md-6">
												<!-- BEGIN BUTTONS PORTLET-->
												<div class="portlet light tasks-widget bordered">
													<div class="portlet-title">
														<div class="caption">
															<span
																class="caption-subject font-green-haze bold uppercase">Buttonsasd</span>
															<span class="caption-helper">还有一些，不过虽然CLASS不一样但颜色跟后边有一样或者几乎一样的，为了找起来方便就没写上去</span>
														</div>

													</div>
													<div class="portlet-body util-btn-margin-bottom-5">
														<div class="clearfix">
															<h4 class="block">Default Bootstrap</h4>
															<button type="button" class="btn btn-default">btn-default</button>
															<button type="button" class="btn btn-warning">btn-warning</button>
															<button type="button" class="btn btn-link">btn-link</button>
														</div>
														<div class="clearfix">
															<h4 class="block">Metronic Custom Buttons</h4>
															<p>
																<button type="button" class="btn default">Default</button>
																<button type="button" class="btn red">Red</button>
																<button type="button" class="btn blue">Blue</button>
																<button type="button" class="btn green">Green</button>
																<button type="button" class="btn yellow">Yellow</button>
																<button type="button" class="btn purple">Purple</button>
																<button type="button" class="btn dark">Dark</button>
															</p>
															<p>
																<button type="button" class="btn red-mint">red-mint</button>
																<button type="button" class="btn blue-hoki">blue-hoki</button>
																<button id="green-haze-btn" type="button" class="btn green-haze">green-haze</button>
																<button type="button" class="btn yellow-mint">yellow-mint</button>
																<button type="button" class="btn purple-sharp">purple-sharp</button>
																<button type="button" class="btn grey-mint">grey-mint</button>
															</p>
														</div>
														<div class="clearfix">
															<h4 class="block">Metronic btn-outline</h4>
															<p>
																<button type="button" class="btn default btn-outline">Default</button>
																<button type="button" class="btn red btn-outline">Red</button>
																<button type="button" class="btn blue btn-outline">Blue</button>
																<button type="button" class="btn green btn-outline">Green</button>
																<button type="button" class="btn yellow btn-outline">Yellow</button>
																<button type="button" class="btn purple btn-outline">Purple</button>
																<button type="button" class="btn dark btn-outline">Dark</button>
															</p>
															<p>
																<button type="button"
																	class="btn dark btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn red-mint btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn blue-hoki btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn green-haze btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn yellow-mint btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn purple-sharp btn-outline sbold uppercase">sbold
																	uppercase</button>
																<button type="button"
																	class="btn grey-mint btn-outline sbold uppercase">sbold
																	uppercase</button>
															</p>
														</div>
														<div class="clearfix">
															<h4 class="block">
																More Button Colors(go to <a href="ui_colors.html">
																	ui_colors.html </a> for more colors)
															</h4>
															<button type="button" class="btn blue-madison">Blue
																Madison</button>
															<button type="button" class="btn green-meadow">Green
																Meadow</button>
															<button type="button" class="btn red-sunglo">Red
																Sunglo</button>
															<button type="button" class="btn yellow-crusta">Yellow
																Crusta</button>
															<button type="button" class="btn purple-plum">Purple
																Plum</button>
															<button type="button" class="btn grey-cascade">Grey
																Cascade</button>
														</div>
														<div class="clearfix">
															<h4 class="block">Button Stripe</h4>
															<a href="javascript:;" class="btn default red-stripe">
																Red </a> <a href="javascript:;"
																class="btn default blue-stripe"> Blue </a> <a
																href="javascript:;" class="btn default green-stripe">
																Green </a> <a href="javascript:;"
																class="btn default yellow-stripe"> Yellow </a> <a
																href="javascript:;" class="btn default purple-stripe">
																Purple </a> <a href="javascript:;"
																class="btn default green-stripe"> Green </a> <a
																href="javascript:;" class="btn default dark-stripe">
																Dark </a>
														</div>
														<div class="clearfix">
															<h4 class="block">Disabled</h4>
															<a href="javascript:;" class="btn default disabled">
																Default </a> <a href="javascript:;" class="btn red disabled">
																Red </a> <a href="javascript:;" class="btn blue disabled">
																Blue </a> <a href="javascript:;" class="btn green disabled">
																Green </a> <a href="javascript:;"
																class="btn yellow disabled"> Yellow </a> <a
																href="javascript:;" class="btn purple disabled">
																Purple </a> <a href="javascript:;" class="btn dark disabled">
																Dark </a>
														</div>
														<div class="clearfix">
															<h4 class="block">Button Sizes</h4>
															<button type="button" class="btn default btn-lg">Large
																button</button>
															<button type="button" class="btn red">Default
																button</button>
															<button type="button" class="btn blue btn-sm">Small
																button</button>
															<button type="button" class="btn green btn-xs">Extra
																small button</button>
														</div>
														<div class="clearfix">
															<h4 class="block">Block Buttons</h4>
															<a href="javascript:;" class="btn default btn-block">
																Link </a>
															<button class="btn blue btn-block">Button</button>
															<input type="button" class="btn red btn-block"
																value="Input"> <input type="submit"
																class="btn purple btn-block" value="Submit">
															<button class="btn blue btn-block btn-outline ">Button</button>
															<input type="button"
																class="btn red btn-outline btn-block" value="Input">
															<input type="submit"
																class="btn purple btn-outline  btn-block" value="Submit">
															<button
																class="btn yellow-mint btn-block btn-outline sbold uppercase">Button</button>
															<input type="button"
																class="btn red-mint btn-outline btn-block sbold uppercase"
																value="Input"> <input type="submit"
																class="btn green-sharp btn-outline  btn-block sbold uppercase"
																value="Submit">
														</div>
													</div>
												</div>

											</div>
											<div class="col-md-6">
												<!-- BEGIN BLOCK BUTTONS PORTLET-->
												<div class="portlet light bordered">
													<div class="portlet-title">
														<div class="caption">
															<i class="icon-settings font-red-mint"></i> <span
																class="caption-subject font-red-mint bold uppercase">Button
																Groups还有一些，因为class是一样的就没写，为了找起来方便</span>
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
														<div class="clearfix">
															<h4 class="block">Basic Example</h4>
															<div class="btn-group">
																<button type="button" class="btn btn-default">Left</button>
																<button type="button" class="btn btn-default">Middle</button>
																<button type="button" class="btn btn-default">Right</button>
															</div>
														</div>
														<div class="clearfix">
															<h4 class="block">Button Toolbar</h4>
															<div class="btn-toolbar">
																<div class="btn-group btn-group-solid">
																	<button type="button" class="btn red">1</button>
																	<button type="button" class="btn green">2</button>
																	<button type="button" class="btn blue">3</button>
																	<button type="button" class="btn yellow">4</button>
																</div>
																<div class="btn-group btn-group-solid">
																	<button type="button" class="btn purple">5</button>
																	<button type="button" class="btn dark">6</button>
																	<button type="button" class="btn default">7</button>
																</div>
																<div class="btn-group btn-group-solid">
																	<button type="button" class="btn red">8</button>
																</div>
															</div>
														</div>
														<div class="clearfix">
															<h4 class="block">Button Group Sizing</h4>
															<div class="btn-toolbar">
																<div
																	class="btn-group btn-group-lg btn-group-solid margin-bottom-10">
																	<button type="button" class="btn red">Left</button>
																	<button type="button" class="btn green">Middle</button>
																	<button type="button" class="btn blue">Right</button>
																</div>
															</div>
															<div class="btn-toolbar margin-bottom-10">
																<div class="btn-group btn-group-solid">
																	<button type="button" class="btn red">Left</button>
																	<button type="button" class="btn green">Middle</button>
																	<button type="button" class="btn blue">Right</button>
																</div>
															</div>
															<div class="btn-toolbar margin-bottom-10">
																<div class="btn-group btn-group-sm btn-group-solid">
																	<button type="button" class="btn red">Left</button>
																	<button type="button" class="btn green">Middle</button>
																	<button type="button" class="btn blue">Right</button>
																</div>
															</div>
															<div class="btn-toolbar margin-bottom-10">
																<div class="btn-group btn-group-xs btn-group-solid">
																	<button type="button" class="btn red">Left</button>
																	<button type="button" class="btn green">Middle</button>
																	<button type="button" class="btn blue">Right</button>
																</div>
															</div>
														</div>
														<div class="clearfix">
															<h4 class="block">Nesting Button Group</h4>
															<div class="btn-group">
																<button type="button" class="btn btn-default">
																	<i class="fa fa-user"></i> Profile
																</button>
																<button type="button" class="btn btn-default">
																	<i class="fa fa-cogs"></i> Settings
																</button>
																<button type="button" class="btn btn-default">
																	<i class="fa fa-bullhorn"></i> Feeds
																</button>
																<div class="btn-group">
																	<button type="button"
																		class="btn btn-default dropdown-toggle"
																		data-toggle="dropdown">
																		<i class="fa fa-ellipsis-horizontal"></i> More <i
																			class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Dropdown link </a></li>
																		<li><a href="javascript:;"> Dropdown link </a></li>
																	</ul>
																</div>
															</div>
															<div class="clearfix margin-bottom-10"></div>
														</div>
														<div class="clearfix">
															<h4 class="block">Vertical variation</h4>
															<div class="btn-group-vertical margin-right-10">
																<button type="button" class="btn btn-default">Button</button>
																<div class="btn-group">
																	<button id="btnGroupVerticalDrop1" type="button"
																		class="btn btn-default dropdown-toggle"
																		data-toggle="dropdown">
																		Dropdown <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu" role="menu"
																		aria-labelledby="btnGroupVerticalDrop1">
																		<li><a href="javascript:;"> Dropdown link </a></li>
																		<li><a href="javascript:;"> Dropdown link </a></li>
																	</ul>
																</div>
																<button type="button" class="btn btn-default">Button</button>
																<div class="btn-group">
																	<button id="btnGroupVerticalDrop4" type="button"
																		class="btn btn-default dropdown-toggle"
																		data-toggle="dropdown">
																		Dropdown <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu" role="menu"
																		aria-labelledby="btnGroupVerticalDrop4">
																		<li><a href="javascript:;"> Dropdown link </a></li>
																		<li><a href="javascript:;"> Dropdown link </a></li>
																	</ul>
																</div>
															</div>
															<div class="btn-group-vertical btn-group-solid">
																<button type="button" class="btn green">Button</button>
																<div class="btn-group">
																	<button id="btnGroupVerticalDrop5" type="button"
																		class="btn yellow dropdown-toggle"
																		data-toggle="dropdown">
																		Dropdown <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu" role="menu"
																		aria-labelledby="btnGroupVerticalDrop5">
																		<li><a href="javascript:;"> Dropdown link </a></li>
																		<li><a href="javascript:;"> Dropdown link </a></li>
																	</ul>
																</div>
																<button type="button" class="btn dark">Button</button>
																<div class="btn-group">
																	<button id="btnGroupVerticalDrop8" type="button"
																		class="btn yellow dropdown-toggle"
																		data-toggle="dropdown">
																		Dropdown <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu" role="menu"
																		aria-labelledby="btnGroupVerticalDrop8">
																		<li><a href="javascript:;"> Dropdown link </a></li>
																		<li><a href="javascript:;"> Dropdown link </a></li>
																	</ul>
																</div>
															</div>
														</div>
														<div class="clearfix">
															<h4 class="block">Justified Link Variation</h4>
															<div class="btn-group btn-group-justified">
																<a href="javascript:;" class="btn btn-default"> Left
																</a> <a href="javascript:;" class="btn btn-default">
																	Middle </a> <a href="javascript:;" class="btn btn-default">
																	Right </a>
															</div>
															<div class="clearfix margin-bottom-10"></div>
														</div>
													</div>
												</div>
												<!-- END BLOCK BUTTONS PORTLET-->
												<!-- BEGIN DROPDOWNS PORTLET-->
												<div class="portlet light bordered">
													<div class="portlet-title">
														<div class="caption">
															<i class="icon-settings font-green-sharp"></i> <span
																class="caption-subject font-green-sharp bold uppercase">Dropdowns</span>
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
														<div class="tab-content">
															<div class="tab-pane active" id="dropdown_1">
																<h4 class="block">Dropdown buttons</h4>
																<div class="btn-group">
																	<a class="btn btn-default dropdown-toggle"
																		data-toggle="dropdown" href="javascript:;"> Tools
																		<i class="fa fa-angle-down"></i>
																	</a>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Settings <span
																				class="badge badge-success"> 3 </span>
																		</a></li>
																		<li><a href="javascript:;"> Preferences </a></li>
																		<li><a href="javascript:;"> Window Options </a></li>
																		<li><a href="javascript:;"> Help <span
																				class="badge badge-danger"> 7 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-group">
																	<button class="btn red dropdown-toggle"
																		data-toggle="dropdown">
																		Primary <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Action </a></li>
																		<li><a href="javascript:;"> Another action <span
																				class="badge badge-warning"> 2 </span>
																		</a></li>
																		<li><a href="javascript:;"> Something else
																				here </a></li>
																		<li class="divider"></li>
																		<li><a href="javascript:;"> Separated link <span
																				class="badge badge-info"> 7 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-group">
																	<button class="btn green-meadow dropdown-toggle"
																		data-toggle="dropdown">
																		Success <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Action <span
																				class="badge badge-inverse"> 7 </span>
																		</a></li>
																		<li><a href="javascript:;"> Another action </a></li>
																		<li><a href="javascript:;"> Something else
																				here </a></li>
																		<li class="divider"></li>
																		<li><a href="javascript:;"> Separated link <span
																				class="badge"> 4 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-toolbar hide">
																	<div class="btn-group">
																		<button class="btn green dropdown-toggle"
																			data-toggle="dropdown">
																			Success <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																	<div class="btn-group">
																		<button class="btn blue dropdown-toggle"
																			data-toggle="dropdown">
																			Info <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																	<div class="btn-group">
																		<button class="btn black dropdown-toggle"
																			data-toggle="dropdown">
																			Inverse <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu opens-left">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																</div>
																<h4 class="block">Dropdown button with icons</h4>
																<div class="btn-toolbar">
																	<div class="btn-group">
																		<a class="btn green" href="javascript:;"
																			data-toggle="dropdown"> <i class="fa fa-user"></i>
																			User <i class="fa fa-angle-down"></i>
																		</a>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> <i
																					class="fa fa-pencil"></i> Edit
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-trash-o"></i> Delete
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-ban"></i> Ban
																			</a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> <i class="i"></i>
																					Make admin
																			</a></li>
																		</ul>
																	</div>
																	<div class="btn-group">
																		<a class="btn blue-madison" href="javascript:;"
																			data-toggle="dropdown"> <i class="fa fa-user"></i>
																			Settings <i class="fa fa-angle-down"></i>
																		</a>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> <i
																					class="fa fa-plus"></i> Add
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-trash-o"></i> Edit
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-times"></i> Delete
																			</a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> <i class="i"></i>
																					Full Settings
																			</a></li>
																		</ul>
																	</div>
																</div>
															</div>
															<div class="tab-pane" id="dropdown_2">
																<h4 class="block">Hoverable Dropdown Buttons</h4>
																<div class="btn-group">
																	<a class="btn dropdown-toggle" data-toggle="dropdown"
																		data-hover="dropdown" data-delay="1000"
																		data-close-others="true" href="javascript:;">
																		Tools <i class="fa fa-angle-down"></i>
																	</a>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Settings <span
																				class="badge badge-success"> 3 </span>
																		</a></li>
																		<li><a href="javascript:;"> Preferences </a></li>
																		<li><a href="javascript:;"> Window Options </a></li>
																		<li><a href="javascript:;"> Help <span
																				class="badge badge-danger"> 7 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-group">
																	<button class="btn red dropdown-toggle"
																		data-toggle="dropdown" data-hover="dropdown"
																		data-delay="1000" data-close-others="true">
																		Primary <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Action <span
																				class="badge badge-warning"> 7 </span>
																		</a></li>
																		<li><a href="javascript:;"> Another action <span
																				class="badge badge-danger"> 2 </span>
																		</a></li>
																		<li><a href="javascript:;"> Something else
																				here </a></li>
																		<li class="divider"></li>
																		<li><a href="javascript:;"> Separated link <span
																				class="badge badge-info"> 4 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-group">
																	<button class="btn purple dropdown-toggle"
																		data-toggle="dropdown" data-hover="dropdown"
																		data-delay="1000" data-close-others="true">
																		Success <i class="fa fa-angle-down"></i>
																	</button>
																	<ul class="dropdown-menu">
																		<li><a href="javascript:;"> Action <span
																				class="badge badge-inverse"> 7 </span>
																		</a></li>
																		<li><a href="javascript:;"> Another action </a></li>
																		<li><a href="javascript:;"> Something else
																				here </a></li>
																		<li class="divider"></li>
																		<li><a href="javascript:;"> Separated link <span
																				class="badge"> 4 </span>
																		</a></li>
																	</ul>
																</div>
																<div class="btn-toolbar hide">
																	<div class="btn-group">
																		<button class="btn green dropdown-toggle"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Success <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																	<div class="btn-group">
																		<button class="btn blue dropdown-toggle"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Info <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																	<div class="btn-group">
																		<button class="btn black dropdown-toggle"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Inverse <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu opens-left">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																</div>
																<h4 class="block">Hoverable Dropdown Buttons with
																	Icons</h4>
																<div class="btn-toolbar">
																	<div class="btn-group">
																		<a class="btn green" href="javascript:;"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true"> <i
																			class="fa fa-user"></i> User <i
																			class="fa fa-angle-down"></i>
																		</a>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> <i
																					class="fa fa-pencil"></i> Edit
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-trash-o"></i> Delete
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-ban"></i> Ban
																			</a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> <i class="i"></i>
																					Make admin
																			</a></li>
																		</ul>
																	</div>
																	<div class="btn-group">
																		<a class="btn purple" href="javascript:;"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true"> <i
																			class="fa fa-user"></i> Settings <i
																			class="fa fa-angle-down"></i>
																		</a>
																		<ul class="dropdown-menu">
																			<li><a href="javascript:;"> <i
																					class="fa fa-plus"></i> Add
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-trash-o"></i> Edit
																			</a></li>
																			<li><a href="javascript:;"> <i
																					class="fa fa-times"></i> Delete
																			</a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> <i class="i"></i>
																					Full Settings
																			</a></li>
																		</ul>
																	</div>
																</div>
																<div class="well">
																	<h4 class="block">Hoverable Dropdown Buttons
																		Dropdown with Checkboxes.</h4>
																	<div class="btn-group">
																		<a class="btn green" href="javascript:;"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Options #1 <i class="fa fa-angle-down"></i>
																		</a>
																		<div
																			class="dropdown-menu hold-on-click dropdown-checkboxes">
																			<label> <input type="checkbox">Option
																				1
																			</label> <label> <input type="checkbox">Option
																				2
																			</label> <label> <input type="checkbox">Option
																				3
																			</label> <label> <input type="checkbox">Option
																				4
																			</label> <label> <input type="checkbox">Option
																				5
																			</label>
																		</div>
																	</div>
																	<div class="btn-group">
																		<a class="btn red" href="javascript:;"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Options #2 <i class="fa fa-angle-down"></i>
																		</a>
																		<div
																			class="dropdown-menu hold-on-click dropdown-checkboxes">
																			<label> <input type="checkbox">Option
																				1
																			</label> <label> <input type="checkbox" checked>Option
																				2
																			</label> <label> <input type="checkbox">Option
																				3
																			</label> <label> <input type="checkbox" checked>Option
																				4
																			</label> <label> <input type="checkbox">Option
																				5
																			</label>
																		</div>
																	</div>
																	<p>
																		<span class="label label-success"> NOTE: </span>
																		&nbsp; By adding
																		<code>hold-on-click</code>
																		class you can avoid closing the dropdown on click
																	</p>
																</div>
																<div class="well">
																	<h4 class="block">Hoverable Dropup Buttons.</h4>
																	<div class="btn-group">
																		<button class="btn blue dropdown-toggle"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Info <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu bottom-up">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<!-- /btn-group -->
																	<div class="btn-group">
																		<button class="btn black dropdown-toggle"
																			data-toggle="dropdown" data-hover="dropdown"
																			data-delay="1000" data-close-others="true">
																			Inverse <i class="fa fa-angle-down"></i>
																		</button>
																		<ul class="dropdown-menu bottom-up">
																			<li><a href="javascript:;"> Action </a></li>
																			<li><a href="javascript:;"> Another action </a>
																			</li>
																			<li><a href="javascript:;"> Something else
																					here </a></li>
																			<li class="divider"></li>
																			<li><a href="javascript:;"> Separated link </a>
																			</li>
																		</ul>
																	</div>
																	<p>
																		<span class="label label-success"> NOTE: </span>
																		&nbsp; By adding
																		<code>bottom-up</code>
																		class you make dropup menu.
																	</p>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="tab-pane" id="tab_1_2">
										<div class="row">
											<div class="col-md-12">
												<!-- BEGIN BUTTONS PORTLET-->
												<div class="portlet light tasks-widget bordered">
													<div class="portlet-title">
														<div class="caption">
															<i class="icon-refresh font-green"></i> <span
																class="caption-subject bold font-green uppercase">
																Circle Buttons</span> <span class="caption-helper">Click
																on buttons to view spinner in action</span>
														</div>
													</div>
													<div class="portlet-body util-btn-margin-bottom-5">
														<div class="clearfix">
															<h4 class="block">Icon Buttons</h4>
															<button type="button"
																class="btn btn-default mt-ladda-btn ladda-button btn-circle"
																data-style="expand-left" data-spinner-color="#333">
																<span class="ladda-label"> <i
																	class="icon-arrow-left"></i> Expand Left
																</span>
															</button>
															<button type="button"
																class="btn btn-primary mt-ladda-btn ladda-button btn-circle"
																data-style="expand-right">
																<span class="ladda-label"> <i
																	class="icon-arrow-right"></i> Expand Right
																</span>
															</button>
															<button type="button"
																class="btn btn-success mt-ladda-btn ladda-button"
																data-style="expand-up">
																<span class="ladda-label"> <i
																	class="icon-arrow-up"></i> 去掉class里的 btn-circle就不是圆角
																</span>
															</button>
															<button type="button"
																class="btn btn-info mt-ladda-btn ladda-button btn-circle"
																data-style="expand-down">
																<span class="ladda-label"> <i
																	class="icon-arrow-down"></i> Expand Down
																</span>
															</button>
															<button type="button"
																class="btn btn-warning mt-ladda-btn ladda-button btn-circle"
																data-style="zoom-in">
																<span class="ladda-label"> <i
																	class="icon-magnifier"></i> Zoom In
																</span>
															</button>
															<button type="button"
																class="btn purple mt-ladda-btn ladda-button btn-circle btn-outline"
																data-style="slide-left" data-spinner-color="#333">
																<span class="ladda-label"> <i class="icon-logout"></i>
																	Slide Left
																</span>
															</button>
															<button type="button"
																class="btn red mt-ladda-btn ladda-button btn-circle btn-outline"
																data-style="slide-right" data-spinner-color="#333">
																<span class="ladda-label"> <i class="icon-login"></i>
																	Slide Right
																</span>
															</button>
															<button type="button"
																class="btn blue mt-ladda-btn ladda-button btn-circle btn-outline"
																data-style="slide-up" data-spinner-color="#333">
																<span class="ladda-label"> <i class="icon-layers"></i>
																	Slide Up
																</span>
															</button>
															<button type="button"
																class="btn green mt-ladda-btn ladda-button btn-circle btn-outline"
																data-style="slide-down" data-spinner-color="#333">
																<span class="ladda-label"> <i
																	class="icon-present"></i> Slide Down
																</span>
															</button>
															<button type="button"
																class="btn yellow mt-ladda-btn ladda-button btn-circle btn-outline"
																data-style="contract" data-spinner-color="#333">
																<span class="ladda-label"> <i
																	class="icon-size-actual"></i> Contract
																</span>
															</button>
														</div>
													</div>
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
</body>
<%@include file="/WEB-INF/jsp/common/NewJS.html"%>
<script src="/assets/pages/scripts/ui-buttons.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		var doLoginMainList = loginMainList();//common-lais-util.js
		doLoginMainList.menu();

		var doHeaderInit = headerInit();
		doHeaderInit.manageLanguage();

		var doLeftBarInit = leftBarInit();
		doLeftBarInit.Init();
				
		$("#green-haze-btn").click(function(){
			
			alert($(this).css("background-color"));
		});
	});
</script>
</html>