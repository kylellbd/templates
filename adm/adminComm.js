var Comm = function() {
    var DEV_API_URL = "http://62.234.152.219:90";
    var PROD_API_URL = "http://api.szaitech.com";
    var SYSTEM_MODE = "DEV"; //PROD
    var HEADER = 'shrubHeader';
    var LOGINER_INFO = 'loginerInfo';

    var getApiUrl = function() {
        if (SYSTEM_MODE == 'PROD') {
            return PROD_API_URL;
        } else {
            return DEV_API_URL;
        }
    }

    var setHeader = function(userId, token) {
        var headerItem = {
            "type": "admin",
            "user": userId,
            "token": token,
            "pt": "pc"
        };

        sessionStorage.setItem(HEADER, JSON.stringify(headerItem));
    }

    var getHeader = function() {
        return JSON.parse(sessionStorage.getItem(HEADER));
    }

    var getPostHeader = function() {
        var header = getHeader();
        header['Content-Type'] = 'application/json';
        return header;
    }

    var setLoginerInfo = function(userData) {
        sessionStorage.setItem(LOGINER_INFO, JSON.stringify(userData));
    }

    var getLoginerInfo = function() {
        var strLoginerInfo = sessionStorage.getItem(LOGINER_INFO);
        var header = getPostHeader();
        if (strLoginerInfo == null) {
            var settings = {
                "async": false,
                "crossDomain": true,
                "url": getApiUrl() + "/api/Admin/GetUserList",
                "method": "POST",
                "headers": header,
                "data": JSON.stringify({ UserId: header.user })
            }

            $.ajax(settings).done(function(response) {
                console.log(response);
                if (response.Result == 0) {
                    var datas = response.Data;
                    setLoginerInfo(datas[0]);
                }
            });
        }
        return JSON.parse(sessionStorage.getItem(LOGINER_INFO));
    }

    var clearSession = function() {
        sessionStorage.clear();
    }

    var checkUserSession = function() {
        var header = sessionStorage.getItem("header");
        if (header == null || header == "") {
            //alert and redirect to login
        }
    }

    var innerAlert = function(v_text, v_type, url) {
        swal({
                title: "Alert",
                text: v_text,
                type: v_type,
                showConfirmButton: "btn-success",
                allowOutsideClick: true,
                showCancelButton: false,
                confirmButtonText: "确认",
                closeOnConfirm: false,
                closeOnCancel: true
            },
            function(isConfirm) {
                swal.close();
                if (url != null && url != "") {
                    window.location.href = url;
                }
            }
        );
    }

    var innerConfirm = function(v_text, v_type, func) {
        swal({
                title: "Alert",
                text: v_text,
                type: v_type,
                showConfirmButton: "btn-success",
                allowOutsideClick: true,
                showCancelButton: true,
                confirmButtonText: "확인",
                cancelButtonText: "취소",
                closeOnConfirm: true,
                closeOnCancel: true
            },
            function(isConfirm) {
                swal.close();
                if (isConfirm) {
                    func();
                }

            }
        );
    }

    var extendInputmask = function() {
        /*
            type:
            date currentcy email url ip numberic decimal integer percentage 
        */
        Inputmask.extendAliases({
            "currency_normal": {
                prefix: "",
                groupSeparator: ",",
                alias: "numeric",
                placeholder: "0",
                autoGroup: true,
                digits: 2,
                digitsOptional: false,
                clearMaskOnLostFocus: false,
                rightAlign: false
            },
            "leftInteger": {
                alias: "integer",
                rightAlign: false
            },
            "leftPercent": {
                alias: "percentage",
                placeholder: "",
                digits: 2,
                rightAlign: false
            },

        });
    }

    var initInpumask = function() {
        $(":input").inputmask();
    }

    var initSwitch = function() {
        $(".make-switch").each(function() {
            $(this).bootstrapSwitch();
        });
    }

    var extendValidate = function() {
        // jQuery.validator.addMethod("notEqual", function(value, element, param) {
        //     return this.optional(element) || value != param;
        // }, "Please specify a different (non-default) value");
    }

    var getDomData = function($DOM) {
        var params = {};
        var domItems = $DOM.find("[data-key]");
        domItems.each(function(index, item) {
            item = $(item);
            var itemNm = item.attr("data-key");
            var itemType = item.attr("data-type");
            var itemValue;
            switch (itemType) {
                case "SWITCH":
                    itemValue = item.bootstrapSwitch("state");
                    if (itemValue) {
                        itemValue = 'Y';
                    } else {
                        itemValue = 'N';
                    }
                    break;
                case "TEXT":
                    itemValue = item.val();
                    if (itemValue == null) {
                        itemValue = "";
                    }
                    break;
                case "MONEY":
                    itemValue = Inputmask.unmask(item.val(), { alias: "currency" });
                    if (itemValue == null) {
                        itemValue = 0;
                    }
                    break;
                case "SELECT":
                    itemValue = item.val();
                    break;
                case "INTEGER":
                    itemValue = item.val();
                    if (itemValue == null || itemValue == "") {
                        itemValue = 0;
                    }
                    break;
                case "PERCENT":
                    itemValue = Inputmask.unmask(item.val(), { alias: "leftPercent" });
                    console.log("percent=" + itemValue);
                    if (itemValue == null) {
                        itemValue = 0;
                    }
                    break;
            }
            params[itemNm] = itemValue;

        });
        return params;

    }

    var setDomData = function($DOM, params) {
        var domItems = $DOM.find("[data-key]");
        domItems.each(function(index, item) {
            item = $(item);
            var itemNm = item.attr("data-key");

            if (!params.hasOwnProperty(itemNm)) {
                return;
            }

            var itemValue = params[itemNm];
            var itemType = item.attr("data-type");
            switch (itemType) {
                case "SWITCH":
                    console.log("switch: " + itemNm + "=" + itemValue);
                    if (itemValue == "Y") {
                        item.bootstrapSwitch("state", true);
                    }

                    if (itemValue == "N") {
                        item.bootstrapSwitch("state", false);
                    }
                    break;
                case "TEXT":
                    item.val(itemValue);
                    break;
                case "MONEY":
                    itemValue = Inputmask.format(itemValue, { alias: "currency_normal" });
                    item.val(itemValue);
                    break;
                case "SELECT":
                    // console.log('setdata_select_value=' + itemValue);
                    item.val(itemValue);
                    // console.log('setdata_select_value after=' + item.val());
                    break;
                case "INTEGER":
                    item.val(itemValue);
                    break;
                case "PERCENT":
                    itemValue = Inputmask.format(itemValue, { alias: "leftPercent" });
                    item.val(itemValue);
                    break;
                case "HTML":
                    item.empty();
                    item.html(itemValue);
                    break;
            }
        });
    }

    var getItemsData = function($ITEMS) {
        var params = {};

        $ITEMS.each(function(index, item) {
            item = $(item);
            var itemNm = item.attr("data-key");
            var itemType = item.attr("data-type");
            var itemValue;
            switch (itemType) {
                case "SWITCH":
                    itemValue = item.bootstrapSwitch("state");
                    if (itemValue) {
                        itemValue = 'Y';
                    } else {
                        itemValue = 'N';
                    }
                    break;
                case "TEXT":
                    itemValue = item.val();
                    if (itemValue == null) {
                        itemValue = "";
                    }
                    break;
                case "MONEY":
                    itemValue = Inputmask.unmask(item.val(), { alias: "currency" });
                    if (itemValue == null) {
                        itemValue = 0;
                    }
                    break;
                case "SELECT":
                    itemValue = item.val();
                    break;
                case "INTEGER":
                    itemValue = item.val();
                    console.log(itemValue);
                    if (itemValue == null || itemValue == "") {
                        itemValue = 0;
                    }
                    break;
                case "PERCENT":
                    itemValue = Inputmask.unmask(item.val(), { alias: "leftPercent" });
                    console.log("percent=" + itemValue);
                    if (itemValue == null) {
                        itemValue = 0;
                    }
                    break;
            }
            params[itemNm] = itemValue;

        });
        return params;

    }

    var setItemsData = function($ITEMS, params) {

        $ITEMS.each(function(index, item) {
            item = $(item);
            var itemNm = item.attr("data-key");

            if (!params.hasOwnProperty(itemNm)) {
                return;
            }

            var itemValue = params[itemNm];
            var itemType = item.attr("data-type");
            switch (itemType) {
                case "SWITCH":
                    // console.log("switch: " + itemNm + "=" + itemValue);
                    if (itemValue == "Y") {
                        item.bootstrapSwitch("state", true);
                    }

                    if (itemValue == "N") {
                        item.bootstrapSwitch("state", false);
                    }
                    break;
                case "TEXT":
                    item.val(itemValue);
                    break;
                case "MONEY":
                    itemValue = Inputmask.format(itemValue, { alias: "currency_normal" });
                    item.val(itemValue);
                    break;
                case "SELECT":
                    // console.log('setdata_select_value=' + itemValue);
                    item.val(itemValue);
                    // console.log('setdata_select_value after=' + item.val());
                    break;
                case "INTEGER":
                    item.val(itemValue);
                    break;
                case "PERCENT":
                    itemValue = Inputmask.format(itemValue, { alias: "leftPercent" });
                    item.val(itemValue);
                    break;
                case "HTML":
                    item.empty();
                    item.html(itemValue);
                    break;
            }
        });
    }
    var cleanDomData = function($DOM) {
        var domItems = $DOM.find("[data-key]");
        domItems.each(function(index, item) {
            item = $(item);
            var itemType = item.attr("data-type");
            switch (itemType) {
                case "SWITCH":
                    item.bootstrapSwitch("state", true);
                    break;
                case "TEXT":
                    item.val("");
                    break;
                case "MONEY":
                    item.val(0);
                    break;
                case "SELECT":
                    item.find("option:selected").attr("selected", false);
                    item.find("option").first().attr("selected", true);
                    break;
                case "INTEGER":
                    item.val(0);
                    break;
                case "PERCENT":
                    item.val(0);
                    break;
            }
        });
    }

    var getElementByDataKey = function(dataKey) {
        return $("[data-key='" + dataKey + "']");
    }

    return {
        getApiUrl: function() {
            return getApiUrl();
        },
        setHeader: function(userId, token) {
            setHeader(userId, token);
        },
        getHeader: function() {
            return getHeader();
        },
        getPostHeader: function() {
            return getPostHeader();
        },
        getDomData: function($DOM) {
            return getDomData($DOM);
        },
        setDomData: function($DOM, params) {
            setDomData($DOM, params);
        },
        getItemsData: function($ITEMS) {
            return getItemsData($ITEMS);
        },
        setItemsData: function($ITEMS, params) {
            setItemsData($ITEMS, params);
        },
        cleanDomData: function($DOM) {
            cleanDomData($DOM);
        },
        init: function() {
            checkUserSession();

            //init all swithch
            initSwitch();

            //init inputmask aliases
            extendInputmask();

            //init inputmask
            initInpumask();

            //init jq validate
            extendValidate();
        },
        alert: function(v_text, v_type, url) {
            /*
            v_type : success, error, warning, info
            */
            innerAlert(v_text, v_type, url);
        },
        confirm: function(v_text, v_type, func) {
            return innerConfirm(v_text, v_type, func);
        },
        getElementByDataKey: function(dataKey) {
            return getElementByDataKey(dataKey);
        },
        getLoginerInfo: function() {
            return getLoginerInfo();
        }
    }
}();