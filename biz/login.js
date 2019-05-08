var Login = function() {

    var handleLogin = function() {
        $('.login-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                username: {
                    required: true
                },
                password: {
                    required: true
                },
                remember: {
                    required: false
                }
            },

            messages: {
                username: {
                    required: "Username is required."
                },
                password: {
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
                    "url": "http://62.234.152.219:90/api/User/Login?userId=" + form.UserId.value + "&pwd=" + form.Pwd.value + "&pt=pc",
                    "method": "GET",
                    "headers": {
                        "userId": form.UserId.value,
                        "cache-control": "no-cache",
                        "Postman-Token": "f12c4eef-02ab-4184-a229-6b0e3bf6ec31"
                    }
                }

                $.ajax(settings).done(function(response) {
                    console.log(response);
                    if (response.Result == 0) {
                        Comm.setHeader(response.Data.UserId, response.Data.Token);
                        Comm.alert('login success', 'success', '/templates/biz/main.html');
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

    var handleForgetPassword = function() {
        $('.forget-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                email: {
                    required: true,
                    email: true
                }
            },

            messages: {
                email: {
                    required: "Email is required."
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   

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
                form.submit();
            }
        });

        $('.forget-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.forget-form').validate().form()) {
                    $('.forget-form').submit();
                }
                return false;
            }
        });

        jQuery('#forget-password').click(function() {
            jQuery('.login-form').hide();
            jQuery('.forget-form').show();
        });

        jQuery('#back-btn').click(function() {
            jQuery('.login-form').show();
            jQuery('.forget-form').hide();
        });

    }

    var handleRegister = function() {

        var checkCodeCnt = 0;

        function format(state) {
            if (!state.id) { return state.text; }
            var $state = $(
                '<span><img src="/assets/global/img/flags/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
            );

            return $state;
        }

        if (jQuery().select2 && $('#country_list').size() > 0) {
            $("#country_list").select2({
                placeholder: '<i class="fa fa-map-marker"></i>&nbsp;Select a Country',
                templateResult: format,
                templateSelection: format,
                width: 'auto',
                escapeMarkup: function(m) {
                    return m;
                }
            });


            $('#country_list').change(function() {
                $('.register-form').validate().element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
            });
        }


        $('.register-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {

                Name: {
                    required: true
                },
                Email: {
                    required: true,
                    email: true
                },
                Tel: {
                    required: true
                },
                UserId: {
                    required: true
                },
                Pwd: {
                    required: true
                },
                rPwd: {
                    equalTo: "#register_password"
                },
                tnc: {
                    required: true
                }
            },

            messages: { // custom messages for radio buttons and checkboxes
                Name: {
                    required: "이름을 입력하세요."
                },
                Email: {
                    required: "메일주소를 입력하세요.",
                    email: "유효한 메일주소를 입력하세요."
                },
                Tel: {
                    required: "핸드폰 번호를 입력하세요."
                },
                UserId: {
                    required: "아이디를 입력하세요."
                },
                Pwd: {
                    required: "비밀번호를 입력하세요."
                },
                rPwd: {
                    equalTo: "동일한 비밀번호를 입력하세요."
                },
                tnc: {
                    required: '개인정보보호정책과 이용약관에 동의하세요.'
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   

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
                if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
                    error.insertAfter($('#register_tnc_error'));
                } else if (element.closest('.input-icon').size() === 1) {
                    error.insertAfter(element.closest('.input-icon'));
                } else {
                    error.insertAfter(element);
                }
            },

            submitHandler: function(form) {
                console.log("test login ");
                console.log("checkCodeCnt=" + checkCodeCnt);
                //check Code once
                if (checkCodeCnt == 0) {
                    Comm.alert('추천코드를 확인해주세요.', 'info');
                    checkCodeCnt += 1;
                    return false;
                }


                var formDatas = {};
                formDatas.Name = form.Name.value;
                formDatas.UserId = form.UserId.value;
                formDatas.Pwd = form.Pwd.value;
                formDatas.Tel = form.Tel.value;
                formDatas.Email = form.Email.value;
                formDatas.Code = form.Code.value;

                var settings = {
                    "async": false,
                    "crossDomain": true,
                    "url": "http://62.234.152.219:90/api/User/Regist",
                    "method": "POST",
                    "headers": { "Content-Type": "application/json" },
                    "data": JSON.stringify(formDatas)
                }
                $.ajax(settings).done(function(response) {
                    console.log(response);
                    if (response.Result == 0) {
                        Comm.alert('회원가입 성공하셨습니다.', 'success');
                    } else {
                        Comm.alert(response.errorMsg, 'error');
                    }
                    jQuery('#register-back-btn').click();
                });

                return false;
            }
        });

        $('.register-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.register-form').validate().form()) {
                    $('.register-form').submit();
                }
                return false;
            }
        });

        jQuery('#register-btn').click(function() {
            jQuery('.login-form').hide();
            jQuery('.register-form').show();
            checkCodeCnt = 0;

        });

        jQuery('#register-back-btn').click(function() {
            jQuery('.login-form').show();
            jQuery('.register-form').hide();
            checkCodeCnt = 0;
        });
    }

    return {
        //main function to initiate the module
        init: function() {

            handleLogin();
            // handleForgetPassword();
            handleRegister();

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