<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>

	<script type="text/javascript">
		function reply() {
			location.href = "reply_form.do?idx=${vo.idx}&page=${param.page}";
		}
		
		function del() {
			if( confirm("게시글을 삭제 하시겠습니까?") ){
				
				var pwd = document.getElementById("c_pwd").value.trim();
				var url = "del.do?idx=${vo.idx}&pwd="+pwd;
				sendRequest(url, null, resultFn, "post");
			}
		}
		
		function resultFn() {
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				if( data == 'yes' ){
					alert("삭제 성공");
					location.href="list.do?page=${param.page}";
				}else{
					alert("비밀번호 불일치");
					return;
				}
				
			}
			
		}
		
	</script>

</head>
<body>
	<form name="f" method="post">
		
		<table border="1" width="690">
			<caption>상세보기</caption>
			
			<tr>
				<td width="120" height="25">제목</td>
				<td>${ vo.subject }</td>
			</tr>
			
			<tr>
				<td width="120" height="25">작성자</td>
				<td>${ vo.name }</td>
			</tr>
			
			<tr>
				<td width="120" height="25">작성일</td>
				<td>${ vo.regdate }</td>
			</tr>
			
			<tr>
				<td width="120" height="25">ip</td>
				<td>${ vo.ip }</td>
			</tr>
			
			<tr>
				<td width="120" height="25">내용</td>
				
				<!-- 화면의 내용을 엔터값까지 그대로 출력 -->
				<td><pre>${ vo.content }</pre></td>
			</tr>
			
			<tr>
				<td width="120" height="25">비밀번호</td>
				<td>
					<input type="password" id="c_pwd">
				</td>
			</tr>
			
		</table>
		
		<table width="690">
			
			<tr>
				<td height="5"></td>
			</tr>
			
			<tr>
				<td>
					<!-- 목록보기 -->
					<img src="${ pageContext.request.contextPath }/resources/img/btn_list.gif" 
						 onclick="location.href='list.do?page=${param.page}'">
						 
				<c:if test="${ vo.depth lt 1 }">		 
					<!-- 댓글달기 -->
					<img src="${ pageContext.request.contextPath }/resources/img/btn_reply.gif"
					     onclick="reply();">
				</c:if>	 
						 
					<!-- 수정 -->
					<img src="${ pageContext.request.contextPath }/resources/img/btn_modify.gif"
					     onclick="modify();">
					     
					<!-- 삭제 -->
					<img src="${ pageContext.request.contextPath }/resources/img/btn_delete.gif"
					     onclick="del();">     	 
				</td>
			</tr>
		</table>
		
	</form>
</body>
</html>












