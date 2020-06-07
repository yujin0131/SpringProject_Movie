<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//seat를 배열로 받기
	request.setCharacterEncoding("UTF-8");
	String[] arr= request.getParameterValues("seat");
	String seat="&seats=";
	for(int i = 0 ; i < arr.length ;i++){
		seat+=arr[i];
		if(i != (arr.length -1 )){
			seat+="&seats=";
		}
				
	}
	request.setAttribute("seat", seat);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"  src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript">
 	function pay() {
 		
 		var url="saveTicket.do";
		var param="m_name=${param.m_name}&id=${sessionScope.user.id}&city=${param.city}<%=seat%>&district=${param.district}&date_s=${param.date_s}&time=${param.time}&pay_money=${param.total_m}&seat_count=${param.seat_count}";
		sendRequest(url , param , resultFn , "GET");
	}
	function resultFn() {
		if(xhr.readyState==4 && xhr.status==200){
			alert("결재 성공");
			alert(${sessionScope.user.l_idx});
			location.href="mypage.do?l_idx="+${sessionScope.user.l_idx};
		}
	} 
	
</script>
<style type="text/css">
*{margin: 0 ;padding: 0}
body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat;
           
       }
/* footer */

#footer{ width:100%; height:300px; position:absolute; margin-top:900px;}
#footer .f_logo{ width:150px; height:150px; position:absolute; margin-top:-3px; }
#footer .f_logo > img{ width:150px; height:150px; }

#footer .f_txt{ width:50%; height:150px; position:relative; margin:25px auto; }
#footer address{ width:100%; height:30px; position:absolute; margin:30px auto; text-align:center; color:white; }
#footer .team1{ width:100%; height:30px; position:absolute; margin:60px auto; text-align:center; color:white; }
#footer .team2{ width:100%; height:30px; position:absolute; margin:90px auto; text-align:center; color:white; }
</style>
</head>
<body>
 <jsp:include page="header.jsp"/>
 
 <div  style="width:100% ;height:600px  ;margin:300px auto ;overflow: hidden;position: absolute;" align="center">
	 <input  type="button" value="찐결재" onclick="pay();">
 </div>
	
	<!-- footer -->
		<div id="footer">
			
			<div class="f_txt">
				<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
				<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
				<p class="team1">2조 Spring Project Movie</p>
				<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
			</div>
		</div>
		<!-- footer 끝 -->
</body>
</html>
<!-- --예매 DB

--시퀀스
create sequence seq_ticket_idx;

--테이블
create table ticket(
	t_idx number primary key,--예매번호
	m_name varchar2(100) not null,--영화이름
	id varchar2(100),--예매회원ID(forignkey)
	city varchar2(100),--상영지역
	district varchar2(100),--각 지역별 위치
	date_s date,--상영날짜
	time varchar2(100),--상영시간
	seat varchar2(10),--좌석 번호
	pay_money varchar2(100)--결재금액	
); -->
