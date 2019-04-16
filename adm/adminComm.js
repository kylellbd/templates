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

    return {
        "setHeader": function(userId, token) {
            setHeader(userId, token);
        },
        "getHeader": function() {
            return getHeader();
        }
    }
}();


jQuery(document).ready(function() {


});