<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_list.css">
	
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
		
		//loading문구 지우기
		function loading_del(){

		    var loadingText = document.getElementById("loadingText");
		    loadingText.removeChild( loadingText.children[0] );
		    
		}
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
					
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
					
					document.getElementById("movie_movieCd_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieCd;//영화 코드(영진위)
			    	document.getElementById("movie_list_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//영화 제목
			    	/* document.getElementById("movie_list_poster_"+i+"_img").src=moviePoster;//포스터 */
			    	document.getElementById("movie_list_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";//순위
			    	document.getElementById("movie_list_salesShare_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//예매율
			    	document.getElementById("movie_list_audiAcc_"+i).innerHTML="누적관객수 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";//누적관객수
			    	document.getElementById("movie_list_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"개봉";//개봉일
			    	
				}
				
				loading_del();
				
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
				<div id="chart_title">무비 차트(일간)(주간)</div>
				<div id="select_movie_list">
					<ul id="movie_list">
						
						<li id="loadingText"><h3>Loading...</h3></li>
					
						<c:forEach var="n" begin="0" end="9" step="1">
							<li id="movie_list_${n}" style="margin:10px">
									<input type="hidden" id="movie_movieCd_${n}">
									<div id="movie_list_movieNm_${n}"></div>
									<div id="movie_list_rank_${n}"></div>
									<div id="movie_list_salesShare_${n}"></div>
									<div id="movie_list_audiAcc_${n}"></div>
									<div id="movie_list_openDt_${n}"></div>
							</li>
						</c:forEach>
					</ul>
				</div>
			
			</div>
		</div>
	</div>
	
</body>
</html>