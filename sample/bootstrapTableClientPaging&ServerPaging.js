/**
 * by 施彭译shiPengYi, qq:1441499497, 微信wechat:ShiPengYi123
 * 
 * 传参例子send param example(receive by DataStructure):
 * map：
 *     serverOptions.queryParams = function(params){//serverOptions是自定义的属性名serverOptions is custom defined
			var rowPerPage;
			var pageNo;
			var firstRowIndex;
			var lastRowIndex;
			var pageParam = {};
			var dataSet = {};//DataStructure 属性
			var fields = {};//DataStructure 属性
			fields = {
					rowPerPage: params.limit,  //limit写死的must like this
					pageNo: (params.offset/params.limit)+1,
					firstRowIndex: params.offset+1,  //offset写死的must like this
					lastRowIndex: (params.offset/params.limit+1)*params.limit,
					id: searchData.id,
					empNo: searchData.empNo,
					empNm: searchData.empNm
			};
			dataSet["fields"] = fields;
			pageParam["dataSet"] = dataSet;
			return pageParam;
		}
  *		
	list<map>:
		var tableId = "serverTable";
		var serviceId = tableId;//DataStructure 属性
		var param = {};
		var dataSet = {};//DataStructure 属性
		var recordSets = {};//DataStructure 属性
		recordSets[serviceId] = {
				list: $("#"+tableId).bootstrapTable("getSelections"), function(row){
					return row;
				}//获取选中checkbox的那行数据
		};
		dataSet["recordSets"] = recordSets;
		param["dataSet"] = dataSet;
		param["serviceId"] = serviceId;
		stringifiedParam = JSON.stringify(param);//这么套是为了让DataStructure接收
 * **/

var bootstrapTableCus = function(){
	
	var table = new Object();
	
	table.makeBootstrapTable = function($table,sidePagination,url,options,lang){
		
		$table.bootstrapTable("destroy");
		var showPerPageNote;
		
		if(lang == null){
			lang = $COM_UTIL.getUserLanguage();
		}
		
		switch(lang){
		case '中文':
			showPerPageNote = '每页显示 ';
			break;
		case '한국어':
			showPerPageNote = '한 페이지에 ';
			break;
		case 'english':
			showPerPageNote = 'show per page';
			break;
		}
		
		$.fn.bootstrapTable.locales['zh-CN'] = {
			/*formatLoadingMessage: function () {
				return '正在努力地加载数据中，请稍候……';
			},*/
			formatRecordsPerPage: function (pageNumber) {
			    return showPerPageNote + pageNumber;
			},
			formatShowingRows: function (pageFrom, pageTo, totalRows) {
			    return '';
			}/*,
			formatSearch: function () {
			    return '搜索';
			},
			formatNoMatches: function () {
			    return '没有找到匹配的记录';
			},
			formatPaginationSwitch: function () {
			    return '隐藏/显示分页';
			},
			formatRefresh: function () {
			    return '刷新';
			},
			formatToggle: function () {
			    return '切换';
			},
			formatColumns: function () {
			    return '列';
			}*/
		};
		
	    $.extend($.fn.bootstrapTable.defaults, $.fn.bootstrapTable.locales['zh-CN']);
		
		options = $.extend(true, {
			classes: 'table table-hover',
	        locale: undefined,
	        height: undefined,
	        undefinedText: '-',
	        sortName: undefined,
	        sortOrder: "",
	        striped: true,
	        columns: [[]],
	        data: [],
	        dataField: 'rows',
	        method: 'post',
	        url: url,
	        ajax: undefined,
	        cache: false,
	        contentType: 'application/json',
	        dataType: 'json',
	        ajaxOptions: {},
	        queryParams: function (params) {
	            return params;
	        },
	        queryParamsType: 'limit', // undefined
	        responseHandler: function (res) {
	            return res;
	        },
	        pagination: true,
	        onlyInfoPagination: false,
	        sidePagination: sidePagination, // client or server
	        totalRows: 0, // server side need to set
	        pageNumber: 1,
	        pageSize: 10,
	        pageList: [10, 25, 50, 100],
	        paginationHAlign: 'right', //right, left
	        paginationVAlign: 'bottom', //bottom, top, both
	        paginationDetailHAlign: 'left', //right, left
	        paginationFirstText: '&laquo;',
	        paginationPreText: '&lsaquo;',
	        paginationNextText: '&rsaquo;',
	        paginationLastText: '&raquo;',
	        search: false,
	        strictSearch: false,
	        searchAlign: 'right',
	        selectItemName: 'btSelectItem',
	        showHeader: true,
	        showFooter: false,
	        showColumns: false,
	        showPaginationSwitch: false,
	        showRefresh: false,
	        showToggle: false,
	        buttonsAlign: 'right',
	        smartDisplay: true,
	        minimumCountColumns: 1,
	        idField: undefined,
	        uniqueId: undefined,
	        cardView: false,
	        detailView: false,
	        detailFormatter: function (index, row) {
	            return '';
	        },
	        trimOnSearch: true,
	        clickToSelect: false,
	        singleSelect: false,
	        toolbar: undefined,
	        toolbarAlign: 'left',
	        checkboxHeader: true,
	        sortable: undefined,
	        silentSort: true,
	        maintainSelected: true,
	        searchTimeOut: 500,
	        searchText: '',
	        iconSize: undefined,
	        iconsPrefix: 'glyphicon', // glyphicon of fa (font awesome)
	        icons: {
	            paginationSwitchDown: 'glyphicon-collapse-down icon-chevron-down',
	            paginationSwitchUp: 'glyphicon-collapse-up icon-chevron-up',
	            refresh: 'glyphicon-refresh icon-refresh',
	            toggle: 'glyphicon-list-alt icon-list-alt',
	            columns: 'glyphicon-th icon-th',
	            detailOpen: 'glyphicon-plus icon-plus',
	            detailClose: 'glyphicon-minus icon-minus'
	        },

	        rowStyle: function (row, index) {
	            return {};
	        },

	        rowAttributes: function (row, index) {
	            return {};
	        },

	        onAll: function (name, args) {
	            return false;
	        },
	        onClickCell: function (field, value, row, $element) {
	            return false;
	        },
	        onDblClickCell: function (field, value, row, $element) {
	            return false;
	        },
	        onClickRow: function (item, $element) {
	            return false;
	        },
	        onDblClickRow: function (item, $element) {
	            return false;
	        },
	        onSort: function (name, order) {
	            return false;
	        },
	        onCheck: function (row) {
	            return false;
	        },
	        onUncheck: function (row) {
	            return false;
	        },
	        onCheckAll: function (rows) {
	            return false;
	        },
	        onUncheckAll: function (rows) {
	            return false;
	        },
	        onCheckSome: function (rows) {
	            return false;
	        },
	        onUncheckSome: function (rows) {
	            return false;
	        },
	        onLoadSuccess: function (data) {
	            return false;
	        },
	        onLoadError: function (status) {
	            return false;
	        },
	        onColumnSwitch: function (field, checked) {
	            return false;
	        },
	        onPageChange: function (number, size) {
	            return false;
	        },
	        onSearch: function (text) {
	            return false;
	        },
	        onToggle: function (cardView) {
	            return false;
	        },
	        onPreBody: function (data) {
	            return false;
	        },
	        onPostBody: function () {
	            return false;
	        },
	        onPostHeader: function () {
	            return false;
	        },
	        onExpandRow: function (index, row, $detail) {
	            return false;
	        },
	        onCollapseRow: function (index, row) {
	            return false;
	        },
	        onRefreshOptions: function (options) {
	            return false;
	        },
	        onResetView: function () {
	            return false;
	        }
        }, options);
		
		$table.bootstrapTable({
			classes: options.classes,
			locale: options.locale,
			height: options.height,
			undefinedText: options.undefinedText,
			sortName: options.sortName,
			sortOrder: options.sortOrder,
			striped: options.striped,//隔行换色
			columns: options.columns,
			data: options.data,
			method: options.method,
			dataField: options.dataField,
			url: options.url,
			ajax: options.ajax,
			cache: options.cache,
			contentType: options.contentType,
			dataType: options.dataType,
			ajaxOptions: options.ajaxOptions,
			queryParams: options.queryParams,
			queryParamsType: options.queryParamsType,
			responseHandler: options.responseHandler,
			pagination: options.pagination,//是否显示分页
			onlyInfoPagination: options.onlyInfoPagination,
			sidePagination: options.sidePagination,
			totalRows: options.totalRows,
			pageNumber: options.pageNumber,
			pageSize: options.pageSize,
			pageList: options.pageList,
			paginationHAlign: options.paginationHAlign,
			paginationVAlign: options.paginationVAlign,
			paginationDetailHAlign: options.paginationDetailHAlign,
			paginationFirstText: options.paginationFirstText,
			paginationPreText: options.paginationPreText,
			paginationNextText: options.paginationNextText,
			paginationLastText: options.paginationLastText,
			search: options.search,
			strictSearch: options.strictSearch,
			searchAlign: options.searchAlign,
			selectItemName: options.selectItemName,
			showHeader: options.showHeader,
			showFooter: options.showFooter,
			showColumns: options.showColumns,//要显示的列按钮
			showPaginationSwitch: options.showPaginationSwitch,
			showRefresh: options.showRefresh,//刷新按钮
			showToggle: options.showToggle,//换个显示方式按钮
			buttonsAlign: options.buttonsAlign,
			smartDisplay: options.smartDisplay,
			minimumCountColumns: options.minimumCountColumns,
			idField: options.idField,
			uniqueId: options.uniqueId,
			cardView: options.cardView,
			detailView: options.detailView,
			detailFormatter: options.detailFormatter,
			trimOnSearch: options.trimOnSearch,
			clickToSelect: options.clickToSelect,
			singleSelect: options.singleSelect,
			toolbar: options.toolbar,
			toolbarAlign: options.toolbarAlign,
			checkboxHeader: options.checkboxHeader,
			sortable: options.sortable,
			maintainSelected: options.maintainSelected,
			searchTimeOut: options.searchTimeOut, 
			searchText: options.searchText,
			iconSize: options.iconSize,
			iconsPrefix: options.iconsPrefix,
			icons: options.icons,
			rowStyle: options.rowStyle,
			cardView: options.cardView,
			rowAttributes: options.rowAttributes,
			onAll: options.onAll,
			onClickCell: options.onClickCell,
			onDblClickCell: options.onDblClickCell,
			onClickRow: options.onClickRow,
			onDblClickRow: options.onDblClickRow,
			onSort: options.onSort,
			onCheck: options.onCheck,
			onUncheck: options.onUncheck,
			onCheckAll: options.onCheck,
			onUncheckAll: options.onUncheckAll,
			onCheckSome: options.onCheckSome,
			onUncheckSome: options.onUncheckSome,
			onLoadSuccess: options.onLoadSuccess,
			onLoadError: options.onLoadError,
			onColumnSwitch: options.onColumnSwitch,
			onPageChange: options.onPageChange,
			onSearch: options.onSearch,
			onToggle: options.onToggle,
			onPreBody: options.onPreBody,
			onPostBody: options.onPostBody,
			onPostHeader: options.onPostHeader,
			onExpandRow: options.onExpandRow,
			onCollapseRow: options.onCollapseRow,
			onRefreshOptions: options.onRefreshOptions,
			onResetView: options.onResetView,
		});
	};
	
	
	/*table.makeServerPagingTable = function($table,url,options){
		$table.bootstrapTable("destroy");
		
		options = $.extend(true, {
			classes: 'table table-hover',
	        locale: undefined,
	        height: undefined,
	        undefinedText: '-',
	        sortName: undefined,
	        sortOrder: "",
	        striped: true,
	        columns: [[]],
	        data: [],
	        dataField: 'rows',
	        method: 'post',
	        url: url,
	        ajax: undefined,
	        cache: false,
	        contentType: 'application/json',
	        dataType: 'json',
	        ajaxOptions: {},
	        queryParams: function(params){},
	        queryParamsType: 'limit', // undefined
	        responseHandler: function (res) {
	            return res;
	        },
	        pagination: true,
	        onlyInfoPagination: false,
	        sidePagination: 'server', // client or server
	        totalRows: 0, // server side need to set
	        pageNumber: 1,
	        pageSize: 10,
	        pageList: [10, 25, 50, 100],
	        paginationHAlign: 'right', //right, left
	        paginationVAlign: 'bottom', //bottom, top, both
	        paginationDetailHAlign: 'left', //right, left
	        paginationFirstText: '&laquo;',
	        paginationPreText: '&lsaquo;',
	        paginationNextText: '&rsaquo;',
	        paginationLastText: '&raquo;',
	        search: false,
	        strictSearch: false,
	        searchAlign: 'right',
	        selectItemName: 'btSelectItem',
	        showHeader: true,
	        showFooter: false,
	        showColumns: false,
	        showPaginationSwitch: false,
	        showRefresh: false,
	        showToggle: false,
	        buttonsAlign: 'right',
	        smartDisplay: true,
	        minimumCountColumns: 1,
	        idField: undefined,
	        uniqueId: undefined,
	        cardView: false,
	        detailView: false,
	        detailFormatter: function (index, row) {
	            return '';
	        },
	        trimOnSearch: true,
	        clickToSelect: false,
	        singleSelect: false,
	        toolbar: undefined,
	        toolbarAlign: 'left',
	        checkboxHeader: true,
	        sortable: undefined,
	        silentSort: true,
	        maintainSelected: true,
	        searchTimeOut: 500,
	        searchText: '',
	        iconSize: undefined,
	        iconsPrefix: 'glyphicon', // glyphicon of fa (font awesome)
	        icons: {
	            paginationSwitchDown: 'glyphicon-collapse-down icon-chevron-down',
	            paginationSwitchUp: 'glyphicon-collapse-up icon-chevron-up',
	            refresh: 'glyphicon-refresh icon-refresh',
	            toggle: 'glyphicon-list-alt icon-list-alt',
	            columns: 'glyphicon-th icon-th',
	            detailOpen: 'glyphicon-plus icon-plus',
	            detailClose: 'glyphicon-minus icon-minus'
	        },

	        rowStyle: function (row, index) {
	            return {};
	        },

	        rowAttributes: function (row, index) {
	            return {};
	        },

	        onAll: function (name, args) {
	            return false;
	        },
	        onClickCell: function (field, value, row, $element) {
	            return false;
	        },
	        onDblClickCell: function (field, value, row, $element) {
	            return false;
	        },
	        onClickRow: function (item, $element) {
	            return false;
	        },
	        onDblClickRow: function (item, $element) {
	            return false;
	        },
	        onSort: function (name, order) {
	            return false;
	        },
	        onCheck: function (row) {
	            return false;
	        },
	        onUncheck: function (row) {
	            return false;
	        },
	        onCheckAll: function (rows) {
	            return false;
	        },
	        onUncheckAll: function (rows) {
	            return false;
	        },
	        onCheckSome: function (rows) {
	            return false;
	        },
	        onUncheckSome: function (rows) {
	            return false;
	        },
	        onLoadSuccess: function (data) {
	            return false;
	        },
	        onLoadError: function (status) {
	            return false;
	        },
	        onColumnSwitch: function (field, checked) {
	            return false;
	        },
	        onPageChange: function (number, size) {
	            return false;
	        },
	        onSearch: function (text) {
	            return false;
	        },
	        onToggle: function (cardView) {
	            return false;
	        },
	        onPreBody: function (data) {
	            return false;
	        },
	        onPostBody: function () {
	            return false;
	        },
	        onPostHeader: function () {
	            return false;
	        },
	        onExpandRow: function (index, row, $detail) {
	            return false;
	        },
	        onCollapseRow: function (index, row) {
	            return false;
	        },
	        onRefreshOptions: function (options) {
	            return false;
	        },
	        onResetView: function () {
	            return false;
	        }
        }, options);
		
		$table.bootstrapTable({
			classes: options.classes,
			locale: options.locale,
			height: options.height,
			undefinedText: options.undefinedText,
			sortName: options.sortName,
			sortOrder: options.sortOrder,
			striped: options.striped,//隔行换色
			columns: options.columns,
			data: options.data,
			method: options.method,
			dataField: options.dataField,
			url: options.url,
			ajax: options.ajax,
			cache: options.cache,
			contentType: options.contentType,
			dataType: options.dataType,
			ajaxOptions: options.ajaxOptions,
			queryParams: options.queryParams,
			queryParamsType: options.queryParamsType,
			responseHandler: options.responseHandler,
			pagination: options.pagination,//是否显示分页
			onlyInfoPagination: options.onlyInfoPagination,
			sidePagination: options.sidePagination,
			totalRows: options.totalRows,
			pageNumber: options.pageNumber,
			pageSize: options.pageSize,
			pageList: options.pageList,
			paginationHAlign: options.paginationHAlign,
			paginationVAlign: options.paginationVAlign,
			paginationDetailHAlign: options.paginationDetailHAlign,
			paginationFirstText: options.paginationFirstText,
			paginationPreText: options.paginationPreText,
			paginationNextText: options.paginationNextText,
			paginationLastText: options.paginationLastText,
			search: options.search,
			strictSearch: options.strictSearch,
			searchAlign: options.searchAlign,
			selectItemName: options.selectItemName,
			showHeader: options.showHeader,
			showFooter: options.showFooter,
			showColumns: options.showColumns,//要显示的列按钮
			showPaginationSwitch: options.showPaginationSwitch,
			showRefresh: options.showRefresh,//刷新按钮
			showToggle: options.showToggle,//换个显示方式按钮
			buttonsAlign: options.buttonsAlign,
			smartDisplay: options.smartDisplay,
			minimumCountColumns: options.minimumCountColumns,
			idField: options.idField,
			uniqueId: options.uniqueId,
			cardView: options.cardView,
			detailView: options.detailView,
			detailFormatter: options.detailFormatter,
			trimOnSearch: options.trimOnSearch,
			clickToSelect: options.clickToSelect,
			singleSelect: options.singleSelect,
			toolbar: options.toolbar,
			toolbarAlign: options.toolbarAlign,
			checkboxHeader: options.checkboxHeader,
			sortable: options.sortable,
			maintainSelected: options.maintainSelected,
			searchTimeOut: options.searchTimeOut, 
			searchText: options.searchText,
			iconSize: options.iconSize,
			iconsPrefix: options.iconsPrefix,
			icons: options.icons,
			rowStyle: options.rowStyle,
			cardView: options.cardView,
			rowAttributes: options.rowAttributes,
			onAll: options.onAll,
			onClickCell: options.onClickCell,
			onDblClickCell: options.onDblClickCell,
			onClickRow: options.onClickRow,
			onDblClickRow: options.onDblClickRow,
			onSort: options.onSort,
			onCheck: options.onCheck,
			onUncheck: options.onUncheck,
			onCheckAll: options.onCheck,
			onUncheckAll: options.onUncheckAll,
			onCheckSome: options.onCheckSome,
			onUncheckSome: options.onUncheckSome,
			onLoadSuccess: options.onLoadSuccess,
			onLoadError: options.onLoadError,
			onColumnSwitch: options.onColumnSwitch,
			onPageChange: options.onPageChange,
			onSearch: options.onSearch,
			onToggle: options.onToggle,
			onPreBody: options.onPreBody,
			onPostBody: options.onPostBody,
			onPostHeader: options.onPostHeader,
			onExpandRow: options.onExpandRow,
			onCollapseRow: options.onCollapseRow,
			onRefreshOptions: options.onRefreshOptions,
			onResetView: options.onResetView,
		});
	};*/
	return table;
}