/**
 * by shiPengYi施彭译  qq:1441499497  微信wechat:ShiPengYi123
 * **/

var formValidations = function() {
		var validation = new Object();
		
		validation.formValidation1 = function($form,options,$error){
			var invalidHandler = null;
			var submitHandler = null;
			
			if($error!=undefined){
				invalidHandler = function(event, validator) { //display error alert on form submit              
					$error.show();
					/*App.scrollTo($error, -1000);*/
				};
				submitHandler = function(form) {
					$error.hide();
				};
			};
			
			options = $.extend(true,{
				errorElement: 'span',//装错误提示的标签
				errorClass: 'help-block help-block-error',//错误提示标签的class，这个值是框架里的
				focusInvalid: false,//把焦点集中在失败的Input上
				ignore: "",//忽略哪个field
				messages : {
					name : {
						required : "required",
						minlength : jQuery.validator.format("min length{0}")
					},
					email : {
						required : "required",
						email : "invalid"
					},
					email2 : {
						email : "invalid"
					},
					url : {
						required : "required",
						url : "invalid"
					},
					url2 : {
						url : "invalid"
					},
					number : {
						required : "required",
						number : "invalid"
					},
					number2:{
						number : "invalid"
					},
					digits : {
						required : "required",
						digits : "invalid"
					},
					creditcard : {
						required : "required",
						creditcard : "invalid"
					},
					select: {
						required : "required"
					},
					selectMultiple : {
						required: "required",
						minlength : jQuery.validator.format("min length {0}")
					},
					textarea : {
						required : "required",
						minlength : jQuery.validator.format("min length {0}"),
						maxlength : jQuery.validator.format("max length {0}")
					},
					textarea2: {
						minlength : jQuery.validator.format("min length {0}"),
						maxlength : jQuery.validator.format("max length {0}")
					},
					checkboxes : {
						required : 'required.',
						minlength : jQuery.validator.format("at least {0}")
					},
					checkboxes2 : {
						required : 'required.',
						minlength : jQuery.validator.format("at least {0}")
					},
					radio : {
						required : 'required.'
					}
				},
				rules : {
					name : {
						minlength : 1,
						required : true
					},
					email : {
						required : true,
						email : true
					},
					email2 : {
						required : false,
						email : true
					},
					url : {
						required : true,
						url : true
					},
					url2 : {
						url : true
					},
					number : {
						required : true,
						number : true
					},
					number2 : {
						number : true
					},
					digits : {
						required : true,
						digits : true
					},
					creditcard : {
						required : true,
						creditcard : true
					},
					select : {
						required : true
					},
					selectMultiple : {
						required : true,
						minlength : 2
					},
					textarea : {
						required : true,
						minlength : 1,
						maxlength : 200
					},
					textarea2 : {
						minlength : 1,
						maxlength : 200
					},
					checkboxes : {
						required : true,
						minlength : 2,
					},
					checkboxes2 : {
						minlength : 2,
					},
					radio : {
						required : true
					}
				},
				errorPlacement : function(error, element) {
					if (element.is(':checkbox')) {
						error.insertAfter(element.closest(".md-checkbox-list, .md-checkbox-inline, .checkbox-list, .checkbox-inline"));
					} else if (element.is(':radio')) {
						error.insertAfter(element.closest(".md-radio-list, .md-radio-inline, .radio-list,.radio-inline"));
					} else {
						error.insertAfter(element); // for other inputs, just perform default behavior
					}
				},
				highlight : function(element) { // hightlight error inputs
					$(element).closest('.form-group').addClass('has-error'); // set error class to the control group
				},
				unhighlight : function(element) { // revert the change done by hightlight
					$(element).closest('.form-group').removeClass('has-error'); // set error class to the control group
				},
				success : function(label) {
					label.closest('.form-group').removeClass('has-error'); // set success class to the control group
				},
				onclick: function( element ) {
					// click on selects, radiobuttons and checkboxes
					if ( element.name in this.submitted ) {
						this.element( element );

					// or option elements, check parent select in that case
					} else if ( element.parentNode.name in this.submitted ) {
						this.element( element.parentNode );
					}
				},
			},options);
			
			$form.validate({
	            errorElement: options.errorElement,
	            errorClass: options.errorClass, // default input error message class
	            focusInvalid: options.focusInvalid, // do not focus the last invalid input
	            ignore: options.ignore, // validate all fields including form hidden input
	            messages: options.messages,//
	            rules: options.rules,
	            invalidHandler: invalidHandler,
	            errorPlacement: options.errorPlacement,
	            highlight: options.highlight,
	            unhighlight: options.unhighlight,
	            success: options.success,
	            onclick: options.onclick,
	            submitHandler: submitHandler
	        });
		};
		return validation;
	}