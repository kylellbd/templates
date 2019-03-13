var formValidations = function() {
		var validation = new Object();
		
		validation.formValidation1 = function($form,options,$error,$success){
			var invalidHandler = null;
			var submitHandler = null;
			
			if($error!=undefined && $success!=undefined){
				invalidHandler = function(event, validator) { //display error alert on form submit              
					$success.hide();
					$error.show();
					App.scrollTo($error, -200);
				};
				submitHandler = function(form) {
					$success.show();
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
						required : "必填项，这显示啥搜逗号后面这句话",
						minlength : "最少{0}位，这显示啥搜逗号后面这句话"
					},
					email : {
						email : "限制格式的代码在框架里"
					},
					select: {
						required: "这项是必选的，不可以选默认值"
					},
					selectMultiple : {
						required: "这项是必选的，最少选2个",
						maxlength : jQuery.validator.format("最多选择 {0}"),
						minlength : jQuery.validator.format("最少选择 {0}")
					},
					'checkboxes1' : {
						required : 'Please check some options',
						minlength : jQuery.validator.format("最少选择 {0}"),
					},
					'checkboxes2' : {
						required : 'Please check some options',
						minlength : jQuery.validator.format("最少选择 {0}"),
					}
				},
				rules : {
					name : {
						minlength : 2,
						required : true
					},
					email : {
						required : true,
						email : true
					},
					email2 : {
						required : true,
						email : true
					},
					url : {
						required : true,
						url : true
					},
					url2 : {
						required : true,
						url : true
					},
					number : {
						required : true,
						number : true
					},
					number2 : {
						required : true,
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
						minlength : 2,
						maxlength : 8
					},
					textarea : {
						required : true,
						minlength : 1,
						maxlength : 200
					},
					'checkboxes1' : {
						required : true,
						minlength : 2,
					},
					'checkboxes2' : {
						required : true,
						minlength : 2,
					},
					'radio1' : {
						required : true
					},
					'radio2' : {
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
					$(element).closest('.form-group').removeClass(
							'has-error'); // set error class to the control group
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