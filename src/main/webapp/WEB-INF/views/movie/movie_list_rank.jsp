<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비 - 무비차트</title>

	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
	
		window.onload=function(){
			load_list();
		};

		
		/* function load_list_toPoster(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts=20200519&releaseDte=20200618&listCount=10';
			sendRequest( url, param, resultFn, "GET" );
		} */
		
		//목록을 가져오는 함수
		function load_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
			var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt=20200521';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");
				
				var movie_list =document.getElementById("movie_list");
				for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){
					var li = document.createElement("li");//영화 제목
			    	li.innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;
			    	movie_list.appendChild(li);
			    	
			    	var rank = document.createElement("div");//영화 순위
			    	rank.innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";
			    	movie_list.appendChild(rank);
			    	
			    	var salesShare = document.createElement("div"); //영화 예매율
			    	salesShare.innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare;
			    	movie_list.appendChild(salesShare);
			    	
			    	var audiAcc = document.createElement("div");//영화 누적관객수
			    	audiAcc.innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";
			    	movie_list.appendChild(audiAcc);

			    	
				}
				
				/* document.getElementById("disp").innerHTML = json[0].Data[0].Result[0].title;
			 	location.href="add_jsonTypeMovieInfo.do?data=${data}"; */
			}
			
		}
	</script>
</head>
<body>
	<div>
		<a href="/movie/movieReleaseList.do">상영 예정작</a>
		<a href="/movie/movieRankList.do">무비 차트(일간)(주간)</a>
		<a href="/movie/movieQuery.do">영화 검색</a>
	</div>
	
	<div id="container">
		<div id="contents">
			<div id="movie_chart">
				<div id="chart_title"></div>
				<div id="select_movie_list">
					<ul id="movie_list">
					</ul>
				</div>
			
			</div>
		</div>
	</div>
	
</body>
</html>