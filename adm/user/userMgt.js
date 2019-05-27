var User = function() {
    var header = Comm.getPostHeader();
    header.crossDomain = true;
    var loginer = Comm.getLoginerInfo();
    var isOwner = false;
    if (loginer != null && loginer.USERTYPE == '0004') {
        isOwner = true;
    }
    var make_table_users = function() {
        $("#table_user").bootstrapTable({
            url: Comm.getApiUrl() + '/api/Admin/GetUserList', // 请求后台的URL（*）
            method: 'post', // 请求方式（*）
            dataType: 'json',
            // toolbar : '#toolbar', // 工具按钮用哪个容器
            striped: true, // 是否显示行间隔色
            cache: false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true, // 是否显示分页（*）
            sortable: false, // 是否启用排序
            sortOrder: "asc", // 排序方式
            sidePagination: "client", // 分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1, // 初始化加载第一页，默认第一页
            pageSize: 10, // 每页的记录行数（*）
            pageList: [10, 25, 50, 100], // 可供选择的每页的行数（*）
            search: false, // 是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            // contentType : "application/x-www-form-urlencoded",
            contentType: "application/json",
            strictSearch: false,
            showColumns: false, // 是否显示所有的列
            showRefresh: false, // 是否显示刷新按钮
            minimumCountColumns: 2, // 最少允许的列数
            clickToSelect: false, // 是否启用点击选中行
            // height : 300, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "USERID", // 每一行的唯一标识，一般为主键列
            showToggle: false, // 是否显示详细视图和列表视图的切换按钮
            cardView: false, // 是否显示详细视图
            detailView: true, // 是否显示父子表
            ajaxOptions: {
                headers: header
            },
            queryParams: function(params) {
                return {
                    Active: $('#Active').val(),
                    UserId: $('#searchUserId').val(),
                    Sts: $('#searchSts').val(),
                }
            },
            columns: [{
                    checkbox: true,
                    formatter: function(value, row, index) {
                        if (row.ACTIVE == 'Y')
                            return {
                                disabled: true //设置选中
                            };
                        return value;
                    }
                }, {
                    field: 'USERID',
                    title: 'USERID',
                    align: "center"
                }, {
                    field: 'USERTYPE',
                    title: 'USERTYPE',
                    align: "center"
                }, {
                    field: 'INITPWD',
                    title: 'INITPWD',
                    align: "center"
                }, {
                    field: 'CURPWD',
                    title: 'CURPWD',
                    align: "center"
                }, {
                    field: 'CREATETIME',
                    title: 'CREATETIME',
                    align: "center"
                }, {
                    field: 'UPDATETIME',
                    title: 'UPDATETIME',
                    align: "center"
                }, {
                    field: 'STS',
                    title: 'STS',
                    align: "center"
                }, {
                    field: 'ACTIVE',
                    title: 'ACTIVE',
                    align: "center"
                }, {
                    title: 'Action',
                    align: "center",
                    formatter: function(value, row, index) {

                        var actionHtml = "";
                        if (row.ACTIVE != "Y") {
                            actionHtml = '<a class="green-color green-haze btn-outline" href="#"  onclick="User.activeUser(\'';
                            actionHtml += row.USERID;
                            actionHtml += '\')">ACTIVE</a> &nbsp;&nbsp;&nbsp;';
                        }
                        if (isOwner) {
                            actionHtml += '<a class="green-color green-haze btn-outline" href="#"  onclick="User.editUserModal(\'';
                            actionHtml += row.USERID;
                            actionHtml += '\')">EDIT</a> &nbsp;&nbsp;&nbsp;';
                        }
                        actionHtml += '<a class="green-color green-haze btn-outline" href="#"  onclick="User.editUserStatusModal(\'';
                        actionHtml += row.USERID;
                        actionHtml += '\')">STATUS</a> ';
                        return actionHtml;
                    }
                }

            ],
            onExpandRow: function(index, row, $detail) {
                var cur_table = $detail.html('<table></table>').find('table');
                var html = "";
                html += "<table class='' >";
                html += "<thead >";
                html += "<tr style='height: 30px; ' >";
                html += "<th style='text-align:center;'>사용자명</th>";
                html += "<th style='text-align:center;'>출생년월일</th>";
                html += "<th style='text-align:center;'>원 핸드폰번호</th>";
                html += "<th style='text-align:center;'>현 핸드폰번호</th>";
                html += "<th style='text-align:center;'>메일주소</th>";
                html += "<th style='text-align:center;'>추천코드</th>";
                html += "</tr>";
                html += "</thead>";
                html += "<tbody>";
                html += "<tr  align='center'>" +
                    "<td>" + row.CUSTINFO.NAME + "</td>" +
                    "<td>" + row.CUSTINFO.BIRTHDAY + "</td>" +
                    "<td>" + row.CUSTINFO.ORGCELLPHONE + "</td>" +
                    "<td>" + row.CUSTINFO.CURCELLPHONE + "</td>" +
                    "<td>" + row.CUSTINFO.EMAIL + "</td>" +
                    "<td>" + row.CUSTINFO.PROMOTIONCODE + "</td>" +
                    "</tr>";
                html += "</tbody>";
                html += "</table>";
                $detail.html(html);
            },
            responseHandler: function(res) {

                return res.Data;
            },
            onLoadSuccess: function() { // 加载成功时执行
                console.log("加载成功");
            },
            onLoadError: function() { // 加载失败时执行
                console.log("加载数据失败");
            }
        });
    };

    var activeUser = function(USERID) {

        var settings = {
            "async": false,
            "crossDomain": true,
            "url": Comm.getApiUrl() + "/api/Admin/ActiveUser?userId=" + USERID,
            "method": "GET",
            "headers": Comm.getHeader(),
        }

        $.ajax(settings).done(function(response) {
            console.log(response);
            if (response.Result == 0) {
                Comm.alert('계정활성화 성공하였습니다.', 'success');
            } else {
                Comm.alert(response.ErrorMsg, 'error');
            }
        });

    }

    var refreshTable = function() {
        $("#table_user").bootstrapTable('refresh');
    }

    var cleanModal = function() {
        Comm.cleanDomData($("#modal_user"));
    }

    var showModal = function() {
        $("#modal_user").modal("show");
    }
    var cleanUserStatusModal = function() {
        Comm.cleanDomData($("#modal_user_status"));
    }
    var showUserStatusModal = function() {
        $("#modal_user_status").modal("show");
    }

    var getSelectData = function() {
        var settings = {
            "async": false,
            "crossDomain": true,
            "url": Comm.getApiUrl() + "/api/Code/GetCodeInfoByGroups?groudIds=0033",
            "method": "GET",
            "headers": Comm.getHeader()
        }

        $.ajax(settings).done(function(response) {
            if (response.Result == 0) {
                var datas = response.Data;
                $.each(datas, function(index, data) {
                    if (data.GroupId == '0033') {
                        initSelect("sts", data.Codeinfos);
                        initSelect("searchSts", data.Codeinfos);
                    }
                });
            }
        });
    }

    var modifyUserStatus = function(USERID, STS) {
        if (!isOwner) {
            Comm.alert('권한이 부족합니다.', 'warn');
            return false;
        }


        var settings = {
            "async": false,
            "crossDomain": true,
            "url": Comm.getApiUrl() + "/api/Admin/UpUserState?userId=" + USERID + "&sts=" + STS,
            "method": "GET",
            "headers": Comm.getHeader(),
        }

        $.ajax(settings).done(function(response) {
            console.log(response);
            if (response.Result == 0) {
                Comm.alert('사용자 상태 변경 완료 되었습니다..', 'success');
            } else {
                Comm.alert(response.ErrorMsg, 'error');
            }
        });

    }

    var initSelect = function(elementNm, codeList) {
        var optionsHtml = "";
        $.each(codeList, function(index, item) {
            optionsHtml += '<option value="' + item.CODEID + '">' + item.CODEKR + '</option>';
        });
        var element = $(("#" + elementNm));
        element.empty();
        element.append(optionsHtml);
    }

    return {
        init: function() {
            getSelectData();

            make_table_users();
        },
        activeUser: function(USERID) {
            activeUser(USERID);
            refreshTable();
        },
        getSelectedUsers: function() {
            var a = $("#table_user").bootstrapTable('getSelections');

        },
        search: function() {
            refreshTable();
        },
        editUserModal: function(USERID) {
            cleanModal();
            var rows = $('#table_user').bootstrapTable('getRowByUniqueId', USERID); //行的数据
            console.log(rows);
            var userInfo = rows.CUSTINFO;
            userInfo.USERTYPE = rows.USERTYPE;
            userInfo.CURPWD = rows.CURPWD;
            Comm.setDomData($("#modal_user"), userInfo);
            showModal();
        },
        editUserStatusModal: function(USERID) {
            cleanUserStatusModal();
            var rows = $('#table_user').bootstrapTable('getRowByUniqueId', USERID); //行的数据
            // console.log(rows);

            // Comm.setDomData($("#modal_user"), userInfo);
            $('#sts').val(rows.STS);
            $('#modalUserStatusUserId').val(USERID);
            showUserStatusModal();
        },
        modifyUserStatus: function(USERID, STS) {
            modifyUserStatus(USERID, STS);
            refreshTable();
        }


    }
}();