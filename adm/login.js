var Login = function() {

    var handleLogin = function() {
        $('.login-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                userId: {
                    required: true,
                    alpha: true,
                },
                pwd: {
                    required: true
                },
                remember: {
                    required: false
                }
            },

            messages: {
                userId: {
                    required: "ID is required.",
                    alpha: "영문과 숫자만 가능합니다."
                },
                pwd: {
                    required: "Password is required."
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   
                $('.alert-danger', $('.login-form')).show();
            },

            highlight: function(element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                error.insertAfter(element.closest('.input-icon'));
            },

            submitHandler: function(form) {


                var settings = {
                    "async": true,
                    "crossDomain": true,
                    "url": Comm.getApiUrl() + "/api/Admin/Login?userId=" + form.userId.value + "&pwd=" + form.pwd.value + "&pt=pc",
                    "method": "GET",
                    "headers": {
                        "userId": form.userId.value,
                        "cache-control": "no-cache",
                        // "Postman-Token": "f12c4eef-02ab-4184-a229-6b0e3bf6ec31"
                    }
                }

                $.ajax(settings).done(function(response) {
                    console.log(response);
                    if (response.Result == 0) {
                        if (form.LoginRemember.checked) {
                            $.cookie("SHRUB_ADM_LoginUserId", form.userId.value, { expires: 10 });
                            $.cookie("SHRUB_ADM_LoginRemember", form.LoginRemember.checked, { expires: 10 });
                        } else {
                            $.cookie("SHRUB_ADM_LoginUserId", null, { expires: 10 });
                            $.cookie("SHRUB_ADM_LoginRemember", null, { expires: 10 });
                        }
                        Comm.setHeader(response.Data.UserId, response.Data.Token);

                        Comm.alert('login success', 'success', '/templates/adm/index_cn.html');
                    } else {
                        Comm.alert(response.ErrorMsg, 'error');
                    }

                });

                return false;
            }
        });

        $('.login-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.login-form').validate().form()) {
                    $('.login-form').submit();
                }
                return false;
            }
        });
    }



    return {
        //main function to initiate the module
        init: function() {
            jQuery.validator.addMethod("alpha", function(value, element) {
                var alpha = /^[0-9a-zA-Z]+$/;
                return this.optional(element) || (alpha.test(value));
            }, "영문과 숫자만 가능합니다.");


            //remember ID
            if ($.cookie("SHRUB_ADM_LoginRemember") != null && $.cookie("SHRUB_ADM_LoginRemember") != undefined) {
                $("#userId").val($.cookie("SHRUB_ADM_LoginUserId"));
                $("#LoginRemember").attr('checked', true);
            }

            handleLogin();

            // init background slide images
            $.backstretch([
                "/assets/pages/media/bg/1.jpg",
                "/assets/pages/media/bg/2.jpg",
                "/assets/pages/media/bg/3.jpg",
                "/assets/pages/media/bg/4.jpg"
            ], {
                fade: 1000,
                duration: 8000
            });
        }
    };

}();

jQuery(document).ready(function() {
    Login.init();
});