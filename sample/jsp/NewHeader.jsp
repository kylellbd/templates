
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<div class="page-header navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner ">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a href="index.html"> <img
				src="/assets/layouts/layout/img/logo.png" alt="logo"
				class="logo-default" />
			</a>
			<div class="menu-toggler sidebar-toggler">
				<span></span>
			</div>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler"
			data-toggle="collapse" data-target=".navbar-collapse"> <span></span>
		</a>
		
		<span id="adminbutton"></span>
		
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<div class="top-menu">
			<ul class="nav navbar-nav pull-right">
				<!-- BEGIN NOTIFICATION DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after "dropdown-extended" to change the dropdown styte -->
				<!-- DOC: Apply "dropdown-hoverable" class after below "dropdown" and remove data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to enable hover dropdown mode -->
				<!-- DOC: Remove "dropdown-hoverable" and add data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to the below A element with dropdown-toggle class -->
				<!-- END NOTIFICATION DROPDOWN -->
				<!-- BEGIN INBOX DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<!-- END INBOX DROPDOWN -->
				<!-- BEGIN TODO DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<!-- END TODO DROPDOWN -->
				<!-- BEGIN USER LOGIN DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->

				<li class="dropdown dropdown-user"><a href="javascript:;"
					class="dropdown-toggle" data-toggle="dropdown"
					data-hover="dropdown" data-close-others="true"> <img alt=""
						class="img-circle" src="" /> <span
						class="username username-hide-on-mobile"> Nick </span> <i
						class="fa fa-angle-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-menu-default">
						<li><a href="/sqrlogln.do"> <i class="icon-key"></i> 切换用户
						</a></li>
					</ul></li>
				<li class="dropdown dropdown-user"><a href="javascript:;"
					class="dropdown-toggle" data-toggle="dropdown"
					data-hover="dropdown" data-close-others="true"> <img alt=""
						class="img-circle" src="" /> <span id="chooseLanguage"
						class="username username-hide-on-mobile"></span> <i
						class="fa fa-angle-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-menu-default">
						<li><a href="" id="chooseLanguage_zh_CN"></a></li>
						<li><a href="" id="chooseLanguage_ko_KR"></a></li>
					</ul></li>

				<!-- END USER LOGIN DROPDOWN -->
				<!-- BEGIN QUICK SIDEBAR TOGGLER -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown"><a href="" class="dropdown-toggle"> <i
						class="icon-logout" style="color: #eee;"></i>
				</a></li>
				<!-- END QUICK SIDEBAR TOGGLER -->
			</ul>
		</div>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END HEADER INNER -->
</div>
<script type="text/javascript">

	var headerInit = function() {
		var header = new Object();

		header.manageLanguage = function(LANGUAGE_GROUP) {
					
			var doLoginMainList = loginMainList();
			var levels = doLoginMainList.userLevel();
			if(levels==2){
				var url = document.location.toString();
				
				if(url.indexOf("/")!=-1){
					sessionStorage.setItem("lasturl",url);
					url = url.substring(url.lastIndexOf("/"),url.length).toLowerCase();			
					last = url.substring(url.lastIndexOf("."),url.length).toLowerCase();			
					url = url.substring(url.length-(last.length+3));
					url = url.substring(0,3);
				}
				
				
				
				if(url=="adm"){
					var adminbutton = "<a href='/index.do' id='indexbtn' style='color:#FFFFFF; position: absolute; top:15.5px;'><li class='icon-user-unfollow'></li></a>";
					$("#adminbutton").html(adminbutton);
				}else{
					var adminbutton = "<a href='/indexadm.do' id='indexbtn' style='color:#FFFFFF; position: absolute; top:15.5px;'><li class='icon-user'></li></a>";
					$("#adminbutton").html(adminbutton);
				}
			}		
			$("#chooseLanguage").text($COM_UTIL.getUserLanguage());
			$("#chooseLanguage_zh_CN").text($COM_UTIL.LANGUAGE_GROUP["zh_CN"]);
			$("#chooseLanguage_ko_KR").text($COM_UTIL.LANGUAGE_GROUP["ko_KR"]);

			$("#chooseLanguage_zh_CN").click(function() {
				$COM_UTIL.setUserLanguage($COM_UTIL.LANGUAGE_GROUP["zh_CN"]);
				$("#chooseLanguage").text($COM_UTIL.getUserLanguage());
			});

			$("#chooseLanguage_ko_KR").click(function() {
				$COM_UTIL.setUserLanguage($COM_UTIL.LANGUAGE_GROUP["ko_KR"]);
				$("#chooseLanguage").text($COM_UTIL.getUserLanguage());
			});	
		};				
		return header;
	};
	

		
	
	
</script>