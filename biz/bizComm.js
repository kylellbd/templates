var Comm = function() {

    var setHeader = function(userId, token) {
        var headerItem = {
            "type": "client",
            "user": userId,
            "token": token,
            "pt": "pc"
        };

        sessionStorage.setItem("header", JSON.stringify(headerItem));

    }

    var getHeader = function() {
        return JSON.parse(sessionStorage.getItem("header"));
    }

    var getPostHeader = function() {
        var header = getHeader();
        header['Content-Type'] = 'application/json';
        return header;
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

    return {
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
        },
        alert: function(v_text, v_type, url) {
            /*
            v_type : success, error, warning, info
            */
            innerAlert(v_text, v_type, url);
        },
    }
}();