<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
			function signup( f ) {
				
				var user_id = f.user_id.value;
				var user_pw = f.user_pw.value;
				var user_pw2 = f.user_pw2.value;
				var user_name = f.user_name.value;
				
				var user_birth = f.user_birth.value;
				var user_email = f.user_email.value;
				var user_phone = f.user_phone.value;
				
				
				//유효성 정규식
				var pattern_n = /^[가-힣a-zA-Z]+
				
				
				//아이디 유효성 검사체크
				if( !/^[a-z0-9]{4,20}$/.test($("#user_id").val())) {
					alert("id는 영 소문자, 숫자 4~20자리로 입력 !! ");
					return;
				}
				
				//비밀번호 정규식
				if( !/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#user_id").val()) {
					alert("최소 8 자, 최소 하나의 문자, 하나의 숫자 및 하나의 특수 문자");
					return;
					
				}else if( user_pw != user_pw2 ) {
						alert("위 아래 패스워드는 일치하게 입력해주세요");
						return;
				}
				
				// 이메일 정규식 패턴 검사
				if( !/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test($("#user_id").val()) {
					alert("id는 영 소문자, 숫자 4~20자리로 입력 !! ");
					return;
				}
				
				
				// 휴대폰번호 패턴 검사
				if( !/^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/.test($("#user_phone").val()) {
					alert("휴대폰번호를 똑바로 입력하세요 ");
					return;
				}
				
				
				f.action = 'signup_success.do';
				f.submit();
				
				
				
				
			}
		</script>
</head>

<body>
	<form method="POST">

		<div class="form-group1">

			<label for="user_id">아이디</label> <input type="text" id="user_id"
				name="user_id"> <label for="user_pw">비밀번호</label> <input
				type="password" id="user_pw" name="user_pw"> <label
				for="user_pw2">비밀번호 확인</label> <input type="password" id="user_pw2"
				name="user_pw2">
		</div>


		<div class="form-group2">

			<label for="user_name">이름</label> <input type="text" id="user_name"
				name="user_name"> <label for="user_birth">생년월일</label> <input
				type="text" id="user_birth" name="user_birth"
				placeholder="ex) 19990415" required> <label for="user_email">이메일</label>
			<input type="text" name="user_email" id="user_email"
				placeholder="E-mail" required> <label for="user_phone">휴대전화
				('-' 없이 번호만 입력해주세요)</label> <input type="text" id="user_phone"
				name="user_phone" placeholder="Phone Number" required>

		</div>


		<div class="reg_button">
			<input type="button" value="취소하기" onclick="#"> <input
				type="button" value="가입하기" onclick="singup(this.form);">