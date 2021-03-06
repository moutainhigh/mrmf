<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/moduleweb/resources/common.jsp"%>
<%
	request.setAttribute("organAdminRoleId", Constants.getProperty("system.organ.admin.roleId"));
%>
<html>
<head>
<title></title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content  animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<form id="searchForm" method="get" class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-2 control-label">账号名称</label>
								<div class="col-sm-3">
									<input id="regex:accountName" name="regex:accountName"
										type="text" class="form-control">
								</div>
								<div class="col-sm-2">
									<button id="search" class="btn btn-primary" type="submit">查询</button>
								</div>
								<div class="col-sm-2">
									<button id="newAccount" class="btn btn-outline btn-danger"
										type="button">新增</button>
								</div>
							</div>
						</form>
						<div class="jqGrid_wrapper">
							<table id="accountTable"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var manageType;
		$()
				.ready(
						function() {
							$("#newAccount").click(
									function() {
										document.location.href = _ctxPath
												+ "/account/toUpsert.do";
									});

							$("#searchForm").submit(function() {
								$("#accountTable").reloadGrid({
									postData : $("#searchForm").formobj()
								});
								return false;
							});
							$("#accountTable")
									.grid(
											{
                                                rownumbers: true,
												url : _ctxPath
														+ "/account/query.do",
												postData : $("#searchForm")
														.formobj(),
												colNames : [ "账号名称", "操作" ],
												colModel : [
														{
															name : "accountName",
															index : "accountName"
														},
														{
															name : "_id",
															index : "_id",
															align : "center",
															formatter : function(
																	cellvalue,
																	options,
																	rowObject) {
																var v;
																if (rowObject.weUnionId) {
																	v = "微信管理账号";
																} else if (rowObject.roleIds
																		.contains("${organAdminRoleId}")) {
																	v = "默认管理员";
																} else {
																	v = "<a href='${ctxPath}/account/toUpsert.do?accountId="
																			+ cellvalue
																			+ "'>详情</a>&nbsp;&nbsp;";
																}

																return v;
															}
														} ]
											});

						});
	</script>
</body>
</html>
