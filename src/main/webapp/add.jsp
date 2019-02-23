<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
 <html >
 <head>
   <meta charset="UTF-8">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
   <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/js/colResizable-1.3.min.js"></script>
   <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
</head>

<body>
  <div id="forms" class="mt10">
        <div class="box">
          <div class="box_border">
            <div class="box_top"><b class="pl15">添加房源</b></div>
            <div class="box_center">
              <form action="/house/inserthouse" class="jqtransform" method="post">
               <table class="form_table pt15 pb15" width="100%" border="0" cellpadding="0" cellspacing="0">
                 <tr>
                  <td class="td_right">房屋标题：</td>
                  <td class=""> 
                    <input type="text" name="title" class="input-text lh30" size="40">
                  </td>
				  </tr>
				  <tr>
                  <td class="td_right">房屋价格：</td><td><input type="text" name="price" class="input-text lh30" size="40"></td>
                </tr>
                <tr >
                  <td class="td_right">房屋类型：</td>
                  <td class="">
 
                    <span class="fl">
                      <div class="select_border"> 
                        <div class="select_containers "> 
                        <select class="select" name="typeid"> 
	                        <c:forEach items="${types }" var="t">	
	                        	<option value="${t.id }">${t.name }</option>
	                        </c:forEach>			 
                        </select> 
                        </div> 
                      </div> 
                    </span>
                  </td>
                 </tr>
                
                   <tr>
                      <td class="td_right">房屋面积：</td>
                      <td class=""> 
                        <input type="text" name="area" class="input-text lh30" size="40">
                      </td>
                  </tr>
					   <tr>
						  <td class="td_right">房屋地址：</td>
						  <td class=""> 
							<input type="text" name="address" class="input-text lh30" size="40">
						  </td>
					  </tr>
               <tr>
                  <td class="td_right">房屋状态：</td>
                  <td class="">
                    <input type="radio" name="state" checked value="1"> 启用
                    <input type="radio" name="state" value="0"> 冻结
                  </td>
				  </tr>
                 <tr>
                   <td class="td_right">&nbsp;</td>
                   <td class="">
                     <input type="submit" name="button" class="btn btn82 btn_save2" value="保存"> 
                    <input type="button" name="button" class="btn btn82 btn_res" onclick="location.href='javascript:history.go(-1)'" value="返回"> 
                   </td>
                 </tr>
               </table>
               </form>
            </div>
          </div>
        </div>
     </div>
   </div> 
</body>

</html>