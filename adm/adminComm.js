var Comm = function() {

    var setHeader = function(userId, token) {
        var headerItem = {
            "type": "admin",
            "user": userId,
            "token": token,
            "pt": "pc"
        };

        sessionStorage.setItem("header", JSON.stringify(headerItem));

    }

    var getHeader = function() {
        return JSON.parse(sessionStorage.getItem("header"));
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

    var getFormData = function($FORM) {
        var params = {};
        var formItems = $FORM.find("[data-key]");
        formItems.each(function(index, item) {
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
            }
            params[itemNm] = itemValue;

        });
        return params;

    }

    var setFormData = function($FORM, params) {

    }

    return {
        setHeader: function(userId, token) {
            setHeader(userId, token);
        },
        getHeader: function() {
            return getHeader();
        },
        getFormData: function($FORM) {
            return getFormData($FORM);
        },
        setFormData: function($FORM, params) {
            setFormData($FORM, params);
        },
        init: function() {
            checkUserSession();

            //init all swithch
            initSwitch();

            //init inputmask aliases
            extendInputmask();

            //init inputmask
            initInpumask();
        }
    }
}();