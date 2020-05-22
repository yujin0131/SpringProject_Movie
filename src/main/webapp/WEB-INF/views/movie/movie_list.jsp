<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
	
		window.onload=function(){
			load_list();
		};
		
	
		
		//목록을 가져오는 함수
		function load_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts=20200519&listCount=3';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");
				alert(data);
				
				document.getElementById("disp").innerHTML = json[0].Data[0].Result[0].title;
				
			}
			
		}
	</script>
</head>
<body>
	<div id="disp">
		
	</div>
	
</body>
</html>