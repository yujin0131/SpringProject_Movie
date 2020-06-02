<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>

<script type="text/javascript">
		
		function send(f) {
			
			var id = f.id.value.trim();
			var pwd = f.pwd.value.trim();
			
			// 유효성 체크
			if(id == '' ){
				alert("아이디를 입력하세요.");
				return;
			}
			
			if(pwd == ''){
				alert("패스워드를 입력하세요.");
				return;
			}
			
			var url = "login.do";
			var param = "id="+encodeURIComponent(id) + "&pwd="+encodeURIComponent(pwd);
			sendRequest(url, param, resultFn, "POST");
			
		}
		
		function resultFn() {
			
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = xhr.responseText;
				
				if(data == 'no_id'){
					alert("아이디가 일치하지 않습니다.");
					return;
				}else if(data == 'no_pwd'){
					alert("패스워드가 일치하지 않습니다.");
					return;
				}else if(data == 'clear'){
					return history.back(); //이거 사람들 알려주기
				}
				
			}
						
		}
		
	
	</script>

</head>
<body>

	<form>
		<table align="center" border="1" style="text-align: center">
			<caption style="font-size: 7px">아이디 비밀번호를 입력하신 후, 로그인 버튼을 클릭해 주세요.</caption>

			<tr>
				<td width="120" height="25">아이디 :</td>
				<td><input name="id"></td>
			</tr>

			<tr>
				<td width="120" height="25">비밀번호 :</td>
				<td><input type="password" name="pwd"></td>
			</tr>

			<tr>
				<td align="center" colspan="2">
				<input type="button" value="로 그 인" onClick="send(this.form);">
				</td>
			</tr>

			<tr align="center">
				<td><a href="find_id.do">아이디 찾기 ></a></td>
				<td><a href="find_pwd.do">비밀번호 찾기 ></a></td>
			</tr>


		</table>

		<div align="center">
			<a href="register_form.do"><i>회원이 아니신가요? 회원 가입하시고, 다양한 혜택을 누리세요!</i></a>
		</div>
	</form>


</body>
</html>