<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/colResizable-1.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>

</head>
<body>
	<form action="${pageContext.request.contextPath}/house/show/1/5" method="post" id="query">
		<div id="search_bar" class="mt10">
			<div class="box">
				<div class="box_border">
					<div class="box_top">
						<b class="pl15">搜索</b>
					</div>
					<div class="box_center pt10 pb10">
						<table class="form_table" border="0" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>标题</td>
								<td>
									<input type="text" name="title" class="input-text lh25" size="10"  value="${query.title }">
								</td>
								<td>发布时间</td>
								<td>
									<input type="text" name="startDate" class="input-text lh25" size="20" value="${query.startDate }">
								至 <input type="text" name="endDate" class="input-text lh25" size="20" value="${query.endDate }"></td>
								<td>
									<input type="submit" name="button"  class="btn btn82 btn_search" value="查询">
									<input type="button" name="button" class="btn btn82 btn_recycle"  value="清空">	
									<input type="button" name="button" class="btn btn82 btn_del" value="批量删除" onclick="delall()">							
								</td>
							</tr>
						</table>
					</div>

					<div class="box_bottom pb5 pt5 pr10"
						style="border-top: 1px solid #dadada;">
						<div class="search_bar_btn" style="text-align: center;">

							<a href="/house/add" class="ext_btn"><span class="add"></span>发布房源</a>
						</div>
					</div>
				</div>
			</div>
	</form>

	<div id="table" class="mt10">
		<div class="box span10 oh">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				class="list_table">
				<tr>
					<th>
						<input type="checkbox" id="checkAll">
					</th>
					<th>房屋标题</th>
					<th>房屋价格</th>
					<th>房屋面积</th>
					<th>房屋类型</th>
					<th>房屋地址</th>
					<th>发布时间</th>
					<th>房屋状态</th>
					<th>操作</th>
				</tr>
				<form action="${pageContext.request.contextPath}/house/deleteHouseByid" method="post">
					<c:forEach items="${pager.records}" var="h">
						<tr class="tr" align="center">
							<td class="td_center">
								<input type="checkbox" name="cid" value="${h.id}" onclick="check()">
								
							</td>
							<td><a href="look.html">${h.title}</a></td>
							<td>${h.price}</td>
							<td>${h.area}</td>
							<td>${h.housetype.name}</td>
							<td>${h.address}</td>
							<td>
							  <fmt:formatDate value="${h.createdate}" pattern="yyyy-MM-dd hh:mm:ss"/>
							</td>
							<td id="tb_${h.id }">${h.state==1?'启用':'禁用'}</td>
							<td><a id="a_${h.id }" href="javaScript:changeState(${h.id })">${h.state==0?'启用':'禁用'}</a> |&nbsp; <a href="edit.html">编辑</a>
								|&nbsp; <a href="javascript:void(0)" onclick="del()">删除</a>							
								</td>							
						</tr>
					</c:forEach>
				</form>
				<tr>
					<td colspan="2">
						<input type="button" name="button" class="btn btn82 btn_del" value="GO" onclick="tiaoPage()">
						<input type="text" name="number" class="input-text lh25" size="4" id="number">
					</td>
					<td colspan="7" align="right">
						<div class="page mt10">
							<div class="pagination">
								<ul>
									<li class="first-child"><a href="javaScript: goPage(1);">首页</a></li>
									
									<!-- 如果当前页大于1显示有上一页 -->
									<c:if test="${pager.pageIndex>1}">
										<li><a href="javaScript: goPage(${pager.pageIndex-1});">上一页</a></li>
									</c:if>
										<!-- 页码的遍历 -->
									<c:forEach items="${pager.numbers }" var="n"> 
										<!-- 如果是当前页添加class属性 -->
										<c:if test="${pager.pageIndex==n}">
											<li class="active"><a href="javaScript: goPage(${n});">${n }</a></li>
										</c:if>
										<c:if test="${pager.pageIndex!=n}">
											<li ><a href="javaScript: goPage(${n});">${n }</a></li>
										</c:if>
									</c:forEach>									
									<!-- 如果当前页小于总页数显示有下一页 -->
									<c:if test="${pager.pageIndex<pager.pageCount}">
										<li><a href="javaScript: goPage(${pager.pageIndex+1});">下一页</a></li>
									</c:if>
									
									<li><a href="javaScript: goPage(${pager.pageCount});">末页</a></li>
									<li><span>共${pager.totalCount}条数据</span></li>
									<li><span>共${pager.pageCount}页</span></li>
									<li>
										每页<select id="pageNumber" onchange="changePageSize(${pager.pageIndex})">
											<option value="5" ${pager.pageSize==5?'selected':'' }>5</option>
											<option value="8" ${pager.pageSize==8?'selected':'' }>8</option>
											<option value="10" ${pager.pageSize==10?'selected':'' }>10</option>										
											<option value="15" ${pager.pageSize==15?'selected':'' }>15</option>
										</select>
									</li>
								</ul>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
<script type="text/javascript">
	/* 分页跳转 */
	function goPage(pageIndex){
		var pageSize=$("#pageNumber").val();
		$("#query").attr("action","${pageContext.request.contextPath}/house/show/"+pageIndex+"/"+pageSize)
		$("#query").submit();
	};
	/* 跳转页面 */
	function tiaoPage(){
		var number = $("#number").val();
		goPage(number);
	};
	/* 改变页面大小 */
	function changePageSize(pageIndex){
		var pageSize=$("#pageNumber").val();
		$("#query").attr("action","${pageContext.request.contextPath}/house/show/"+pageIndex+"/"+pageSize)
		$("#query").submit();
	}
	/* 异步更改房屋状态 */
	function changeState(id){
		var text= $("#a_"+id).text();
		var state;
		if(text=="禁用"){
			state=0;
		}else{
			state=1;
		}
		if(confirm("确定要"+text+"吗")){
			$.ajax({
				url:"${pageContext.request.contextPath}/house/changeState",
				data:"id="+id+"&state="+state,
				type:"post",
				dataType:"json",
				success:function(result){
					if(result==true){
						$("#tb_"+id).text(text);
						$("#a_"+id).text(text=='禁用'?'启用':'禁用');
					}
				}
			});
		}
	};
	var cboxs = $("[name='cid']");
	/*全选全不选*/
	$("#checkAll").click(function () {
	    var val=this.checked;
	    $.each(cboxs,function (n,box) {
	        box.checked=val;
	    })
	});
	/*检测是否已全选*/
	function check() {
	    var count = 0;
	    $.each(cboxs,function (n,box) {
	        if(box.checked){
	            count++;
	        }
	    });
	    if(count==cboxs.length){
	        $("#checkAll")[0].checked=true;
	    }else {
	        $("#checkAll")[0].checked=false;
	    }
	};
	/* 批量删除 */
	function delall() {
        var cids = new Array();
        var boxs=$("[name='cid']");
        $.each(boxs,function (n,box) {
            if( box.checked){
                cids.push($(box).val());
            }
        });
        if(cids.length==0){
            alert("请选择删除项目");
            return false;
        }
        document.forms[1].action="/house/deleteHouseByid";
        document.forms[1].submit();
    };
</script>
</body>
</html>