var loginMainList = function(){

	   var commonInit = new Object();
	   
	   commonInit.menu = function(){
		   
		   $COM_UTIL = {
				   KEY_GET_LOGIN_MENU_LIST : "getloginmenulist",
				   KET_GET_LOGIN_MENU_LIST_CN : "getloginmenulistCN",
				   KEY_GET_LOGIN_MENU_ADMIN_LIST : "getLoginMenuAdminList",
				   KET_GET_LOGIN_MENU_ADMIN_LIST_CN : "getLoginMenuAdminListCN",
		    	   KEY_MENU_ID : "menuId",
		    	   KEY_PARENT_MENU_ID : "parentMenuId",
		    	   KEY_MENU_DEPTH_NO : "menuDepthNo",
		    	   KEY_MENU_CATEGORY : "menuCategory",
		    	   KEY_SYSTEM_CATEGORY : "systemCategory",
		    	   KEY_MENU_NAME : "menuName",
		    	   KEY_PAGE_URI :　"pageUri",
		    	   KEY_USER_LANGUAGE : "userLanguage",
		    	   KEY_GET_USER_LEVEL : "getUserLevel",
		    	   KEY_GET_LOGIN_MESSAGE : "getloginmessage",
				   KET_GET_LOGIN_MESSAGE_CN : "getloginmessageCN",
				   KEY_GET_LOGIN_LABEL : "getloginlabel",
				   KET_GET_LOGIN_LABEL_CN : "getloginlabelCN",
				   KEY_UPLOAD_LEFT_LIST : "uploadLeftList",
				   KEY_UPLOAD_TOP_LIST : "uploadTopList",	
				   KEY_UPLOAD_CENTER_LIST : "uploadCenterList",
		    	   LANGUAGE_GROUP : {
		    		   "zh_CN" : "中文",
		    		   "ko_KR" : "한국어"
		    	   },
		    	   setUserLanguage: function(lang){
		    		   localStorage.setItem($COM_UTIL.KEY_USER_LANGUAGE, lang);
		    	   },
		    		  
		    	   getUserLanguage: function(){
		    		   if($COM_UTIL.isEmpty(localStorage.getItem($COM_UTIL.KEY_USER_LANGUAGE))){
		    			   localStorage.setItem($COM_UTIL.KEY_USER_LANGUAGE, $COM_UTIL.LANGUAGE_GROUP["ko_KR"]);
		    		   }
		    		   return localStorage.getItem($COM_UTIL.KEY_USER_LANGUAGE);
		    	   },
		    		  
		    	   isEmpty: function(o) {
		    		   if(undefined == o || null == o) {
		    			   return true;
		    		   }
		    		   if($.isArray(o) && o.length < 1) {
		    			   return true;
		    		   }
		    		   if("object" === typeof o && $.isEmptyObject(o)) {
		    			   return true;
		    		   }
		    		   if("string" === typeof o && ("" == o || "undefined" == o)) {
		    			   return true;
		    		   }
		    		   return false;
		    	   },
		    	   
		    	   getMenuList: function(){
		    		   var menuList = [];
		    		   if(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_LIST)==null || sessionStorage.getItem($COM_UTIL.KET_GET_LOGIN_MENU_LIST_CN)==null || sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST)==null || sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST_CN)==null){
	    				   $.ajax({
	    					   type: "POST",
	    					   async: false,
	    					   //data: languageTitle,
	    					   dataType: 'JSON',
	    					   url: "/biz/ojt/selectMenu.json",
	    					   success: function(res){ 
	    						   sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_MENU_LIST, JSON.stringify(res[0]));
	    						   sessionStorage.setItem($COM_UTIL.KET_GET_LOGIN_MENU_LIST_CN, JSON.stringify(res[1]));
	    						   sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST, JSON.stringify(res[2]));
	    						   sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST_CN, JSON.stringify(res[3]));
	    					   },
	    					   error: function(e){
	    						   console.log(e);
	    					   }
	    				   });
	    			   }
		    		      
		    		   var url = document.location.toString();	
		    		   if(url.indexOf("/")!=-1){
		    			   url = url.substring(url.lastIndexOf("/"),url.length).toLowerCase();	
							last = url.substring(url.lastIndexOf("."),url.length).toLowerCase();			
							url = url.substring(url.length-(last.length+3));
							url = url.substring(0,3);
						}
						if(url=="adm"){
							if($COM_UTIL.getUserLanguage() == $COM_UTIL.LANGUAGE_GROUP["ko_KR"]){
				    			   menuList = JSON.parse(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST));
				    			   return menuList;
				    		   }
				    		   if($COM_UTIL.getUserLanguage() == $COM_UTIL.LANGUAGE_GROUP["zh_CN"]){
				    			   menuList = JSON.parse(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_ADMIN_LIST_CN));
				    			   return menuList;
				    		   }
						}else{ 
				    		   if($COM_UTIL.getUserLanguage() == $COM_UTIL.LANGUAGE_GROUP["ko_KR"]){
				    			   menuList = JSON.parse(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MENU_LIST));
				    			   return menuList;
				    		   }
				    		   if($COM_UTIL.getUserLanguage() == $COM_UTIL.LANGUAGE_GROUP["zh_CN"]){
				    			   menuList = JSON.parse(sessionStorage.getItem($COM_UTIL.KET_GET_LOGIN_MENU_LIST_CN));
				    			   return menuList;
				    		   }
						}
		    		  return menuList;
		    	   }   
		      }; 
	   }
	   
	   commonInit.clearSsn = function(){
	      sessionStorage.clear();
	   }
	      
	   commonInit.message = function(){
			if(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_MESSAGE)==null&&sessionStorage.getItem($COM_UTIL.KET_GET_LOGIN_MESSAGE_CN)==null){
				$.ajax({
					 type: "POST",
					 async: false,
			 		 dataType: 'JSON',
					 url: "/biz/ojt/selectMessage.json",
					 success: function(res){		 
						sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_MESSAGE,JSON.stringify(res[0]));
						sessionStorage.setItem($COM_UTIL.KET_GET_LOGIN_MESSAGE_CN,JSON.stringify(res[1]));		
					 },
					 error: function(e){
						 console.log(e);
					 }
				 });		
			}
		}
		
		commonInit.label = function(){
			if(sessionStorage.getItem($COM_UTIL.KEY_GET_LOGIN_LABEL)==null&&sessionStorage.getItem($COM_UTIL.KET_GET_LOGIN_LABEL_CN)==null){
				$.ajax({
					 type: "POST",
					 async: false,
			 		 dataType: 'JSON',
					 url: "/biz/ojt/selectLabel.json",
					 success: function(res){	
						 //alert(JSON.stringify(res[0].L0201));
						 sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_LABEL,JSON.stringify(res[0]));
						 sessionStorage.setItem($COM_UTIL.KEY_GET_LOGIN_LABEL_CN,JSON.stringify(res[1]));
					 },
					 error: function(e){
						 console.log(e);
					 }
				 });		
			}
		}
		
		commonInit.uploadExcel = function(fileid){	
			var xls = fileid.val();
			if(xls==''){
				alert("请先上传文件");
			} else if((xls.substring(xls.lastIndexOf("."),xls.length).toLowerCase())!='.xlsx'&&(xls.substring(xls.lastIndexOf("."),xls.length).toLowerCase())!='.xls'){
				alert("上传格式不正确修改后缀名为：xlsx/xls");
			} else{
				var file = fileid[0].files[0];
				var formData =new FormData();
				formData.append("file",file);
				formData.append("suffix",xls.substring(xls.lastIndexOf("."),xls.length).toLowerCase());
				$.ajax({
					 type: "POST",
					 url: "/biz/ojt/selectUpload.json",	 
					 data: formData,
					 dataType: 'JSON',
					 async: false,  
				     cache: false,  
				     contentType: false,  
				     processData: false,
					 success: function(res){
						 alert("上传成功");
						// JSON.stringify(res.attributes.uploadLeftList[1])
						 sessionStorage.setItem($COM_UTIL.KEY_UPLOAD_LEFT_LIST,JSON.stringify(res.uploadLeftList));
						 sessionStorage.setItem($COM_UTIL.KEY_UPLOAD_TOP_LIST,JSON.stringify(res.uploadTopList));
						 sessionStorage.setItem($COM_UTIL.KEY_UPLOAD_CENTER_LIST,JSON.stringify(res.uploadCenterList));
					 },
					 error: function(e){
						 alert("上传失败");
						 console.log(e);
					 }
				 });			
			}		
		}   		 
		
		commonInit.userLevel = function(){	
		if(sessionStorage.getItem($COM_UTIL.KEY_GET_USER_LEVEL)==null){
			$.ajax({
				 type: "POST",
				 async: false,
		 		 dataType: 'JSON',
				 url: "/biz/ojt/selectLevel.json",
				 success: function(res){	
					sessionStorage.setItem($COM_UTIL.KEY_GET_USER_LEVEL,JSON.stringify(res.userLevel));	
				 },
				 error: function(e){
					 console.log(e);
				 }
			 });		
		}
		return sessionStorage.getItem($COM_UTIL.KEY_GET_USER_LEVEL);
		}
	   return commonInit;
	}
