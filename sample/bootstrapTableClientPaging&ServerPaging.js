var bootstrapTableCus = function(){
	
	var table = new Object();
	
	table.makeClientPagingTable = function($table,url,options){
		
		options = $.extend(true, {
			url: url,
			method: 'post',
			striped: true,//隔行换色
			cache: false,
			clickToSelect: false,
			showRefresh: false,//刷新按钮
			showToggle: false,//换个显示方式按钮
			showColumns: false,//要显示的列按钮
			toolbar: undefined,
			toolbarAlign: 'left',
			pagination: true,//是否显示分页
			sidePagination: 'client',//分页方式
			pageNumber: 1,//从第几页显示
			pageSize: 10,//一页几行
			pageList: [1, 10, 50],
			queryParams: function(params){//参数
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
	        },
			columns: {}
        }, options);
		
		$table.bootstrapTable({
			url: options.url,
			method: options.method,
			striped: options.striped,//隔行换色
			showRefresh: options.showRefresh,//刷新按钮
			showToggle: options.showToggle,//换个显示方式按钮
			showColumns: options.showColumns,//要显示的列按钮
			cache: options.cache,
			clickToSelect: options.clickToSelect,
			pagination: options.pagination,//是否显示分页
			sidePagination: options.sidePagination,
			pageNumber: options.pageNumber,
			pageSize: options.pageSize,
			pageList: options.pageList,
			queryParams: options.queryParams,
			rowStyle: options.rowStyle,
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
			onExpandRow: options.onExpandRow,
			columns: options.columns
		});
	};
	
	
	table.makeServerPagingTable = function($table,url,options){
		$table.bootstrapTable("destroy");
		
		options = $.extend(true, {
			url: url,
			method: 'post',
			striped: true,//隔行换色
			showRefresh: false,//刷新按钮
			showToggle: false,//换个显示方式按钮
			showColumns: false,//要显示的列按钮
			toolbar: undefined,
			toolbarAlign: 'left',
			cache: false,
			clickToSelect: false,
			maintainSelected: true,
			sortable: undefined,
			sortOrder: "",
			pagination: true,//是否显示分页
			sidePagination: 'server',
			uniqueId: "",
			pageNumber: 1,
			pageSize: 2,
			pageList: [1, 10, 30],
			queryParams: function(params){
				var rowPerPage;
				var pageNo;
				var firstRowIndex;
				var lastRowIndex;
				var pageParam = {};
				var dataSet = {};
				var fields = {};
				
				fields = {
						rowPerPage: params.limit,
						pageNo: (params.offset/params.limit)+1,
						firstRowIndex: params.offset+1,
						lastRowIndex: (params.offset/params.limit+1)*params.limit
				};
				dataSet["fields"] = fields;
				pageParam["dataSet"] = dataSet;
				return pageParam;
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
	        },onUncheckAll: function (rows) {
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
	        },
			columns: {}
        }, options);
		
		console.log(options);
		$table.bootstrapTable({
			url: options.url,
			method: options.method,
			striped: options.striped,//隔行换色
			showRefresh: options.showRefresh,//刷新按钮
			showToggle: options.showToggle,//换个显示方式按钮
			showColumns: options.showColumns,//要显示的列按钮
			toolbar: options.toolbar,
			toolbarAlign: options.toolbarAlign,
			cache: options.cache,
			clickToSelect: options.clickToSelect,
			maintainSelected: options.maintainSelected,
			sortable: options.sortable,
			sortOrder: options.sortOrder,
			pagination: options.pagination,//是否显示分页
			sidePagination: options.sidePagination,
			uniqueId: options.uniqueId,
			pageNumber: options.pageNumber,
			pageSize: options.pageSize,
			pageList: options.pageList,
			queryParams: options.queryParams,		
			rowStyle: options.rowStyle,
			rowAttributes: options.rowAttributes,
			onAll: options.onAll,
			onClickCell: options.onClickCell,
			onDblClickCell: options.onDblClickCell,
			onClickRow: options.onClickRow,
			onDblClickRow: options.onDblClickRow,
			onSort: options.onSort,
			onCheck: options.onCheck,
			onExpandRow: options.onExpandRow,
			columns: options.columns
		});
	};
	return table;
}