<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style type="text/css">
	   body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat;
           
       }
	</style>
	<script type="text/javascript">
		function dotcheck(id){
	         var id_u = document.getElementById("id").value.trim();
	         var user = document.getElementById("user_"+id);
	         var user2 = document.getElementById("user2_"+id);
	         var di = document.getElementById("di_" + id);
	         
	         if(id == id_u){
	            user.style.display = 'block';
	            return;
	         }
	         user2.style.display = 'block';
	    }
		
		//x누르면 닫게
	      function cancle(id){
	         var user = document.getElementById("user_"+id);
	         var user2 = document.getElementById("user2_"+id);
	         
	         user.style.display="none";
	         user2.style.display="none";
	      }
		
	    //수정
	      function modify(){
	         var id = document.getElementById("id").value.trim();
	         if( "${type}" == "1" ){
	            var totalVar1 = "${movieId}";
	            var totalVar2 = "${movieSeq}";
	         } else {
	            //( "${type}" == "2" )
	            var totalVar1 = "${title}";
	            var totalVar2 = "${releaseDts}";
	         }
	         window.open("modify_form.do?id="+id+"&m_name="+totalTitle+"&type=${type}&totalVar1="+totalVar1+"&totalVar2="+totalVar2, "수정하기", "width=665px, height=660px, left=370px, top=50px");
	      }
	      
	      //리뷰 지우고 돌아오기
	      function del(){
	         var id = document.getElementById("id").value.trim();
	         
	         if(!confirm("정말 삭제 하시겠습니까?")){
	            return;
	         }
	         
	         var url = "delete.do";
	         var param = "id=" + id + "&m_name=" + totalTitle;
	         
	         sendRequest(url, param, resultFnReview2, "POST");   
	      }
	</script>
</head>
<body>
	<input type="hidden" action="checkLogin.do" method="GET" name="id"id="id" value="${sessionScope.user.id }">

	<table style="background:red">
		
		<tr class="table_head">

			<th width="76" align="center">아이디</th>
	
			<th width="260" align="center" >영화</th>

			<th width="40" class="td_b" align="center">평점</th>

			<th width="600" class="td_b" align="center">관람평</th><!-- <pre>관람평</pre> -->

			<th width="76" class="td_b" align="center"></th>

		</tr>
		
		<c:forEach var="list" items="${list}">
					<tr>
								<td colspan="11" align="right">
									<div class="user" id="user_${list.id}" align="right"
										style="position: absolute; left:830px;  background:url(${pageContext.request.contextPath}/resources/img/text.png); background-size:200px 100px;
                        				background-position:center; background-repeat: no-repeat; display:none;">
										<input width="15" height="15" type="image" name="button"
											class="close" src="${pageContext.request.contextPath}/resources/img/close.png"
											onclick="cancle('${list.id}');">
										&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>&nbsp&nbsp&nbsp&nbsp&nbsp
										<input type="button" value="수정" onclick="modify();">
										<input type="button" value="삭제" onclick="del();">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>
										<br>
									</div>

									<div name="no" class="user2" id="user2_${list.id}"
										style="background:url(${pageContext.request.contextPath}/resources/img/text.png); background-size:320px 110px;
                        				background-position:center; background-repeat: no-repeat; font-size:12px; position: absolute; left:760px; text-align:center; display:none;">
										<br> &nbsp&nbsp&nbsp스포일러 및 욕설/비방하는
										<input width="15" height="15" type="image" name="button" class="close"
											src="${pageContext.request.contextPath}/resources/img/close.png"
											onclick="cancle('${list.id}');">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>
											&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp내용이 있습니까? &nbsp
										<a href="#">신고</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>
										<br>
									</div>
								</td>
							</tr>
			
			<tr class="table_box">
			
					
					<td width="76" align="center">${list.id }</td>
								
					<td width="260" align="center">${list.m_name }</td>
	
					<td width="40" class="td_b" align="center">${list.scope }</td>

					<td width="600" overflow:hidden; class="td_b" align="center">${list.content }</td>
					<td width="76" class="td_b" align="center">
					<input width="15"
						height="15" type="image" name="button"
						src="${pageContext.request.contextPath}/resources/img/dot.png"
						onclick="dotcheck('${list.id}');"><br>
					</td>
			</tr>
		</c:forEach>
	</table>
		
</body>
</html>