<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	function send_check() {
		var f = document.f;//f라는 이름의 form을 검색
		
		//유효성 체크
		
		f.submit();
		
	}//send_check()
</script>

</head>
<body>
	<table width="760" align="center" border="1">
		<tr>
			<td>
				<table>
					<tr>
						<td><img src="${ pageContext.request.contextPath }/resources/img/title_04.gif"></td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
				<form action="reply.do" method="post" name="f">
					<input type="hidden" name="idx" value="${param.idx}">
					<input type="hidden" name="page" value="${param.page}">
					
					<table width="750">
						
						<tr>
							<td width="120" height="25">제목</td>
							<td><input name="subject" 
							           style="width:550px"></td>
						</tr>
						
						<tr>
							<td width="120" height="25">작성자</td>
							<td><input name="name" 
							           style="width:550px"></td>
						</tr>
						
						<tr>
							<td>내용</td>
							<td colspan="3">
								<textarea name="content" rows="10" cols="76"></textarea>
							</td>
						</tr>
						
						<tr>
							<td width="120" height="25">비밀번호</td>
							<td><input name="pwd" 
							           style="width:550px"
							           type="password"></td>
						</tr>
						
					</table>
					
					<table width="750">
						<tr><td height="5"></td></tr>
						
						<tr>
							<td align="center">
								<img src="${ pageContext.request.contextPath }/resources/img/btn_reg.gif"
								     onclick="send_check();">
								     
								<img src="${ pageContext.request.contextPath }/resources/img/btn_back.gif"
								     onclick="location.href='list.do'">     
							</td>
						</tr>
						
					</table>
					
				</form>
			</td>
		</tr>		
		
	</table>
</body>
</html>











