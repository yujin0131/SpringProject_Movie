<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. 영화 검색</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_list.css">
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
		
		//여러개 포스터 잘라쓰기
		function cutPoster(posters) {
			  if (posters.indexOf("|") !== -1) {
			    posters = posters.substring(0, posters.indexOf("|"));
			  }

			  if (posters === "") {
			    posters = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
			  }
			  return posters;
		}
		
		//loading문구 지우기
		function text_del(){

		    var delText = document.getElementById("searchText");
		    delText.removeChild( delText.children[0] );
		    
		}
		
		//목록을 가져오는 함수
		function movieQuery( f ){
			var query = f.query.value.trim();
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&query='+query;
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");		
				
				for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
					
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
					
					var movieTitle = document.createElement("div");//영화 제목
					movieTitle.innerHTML=json[0].Data[0].Result[i].title;
					
			    	var moviePoster = document.createElement("img");//영화 포스터
			    	moviePoster.src=cutPoster(json[0].Data[0].Result[i].posters);
			    	
			    	var relDate = document.createElement("div");//영화 개봉일
			    	relDate.innerHTML=json[0].Data[0].Result[i].repRlsDate+" 개봉";
			    	
			    	var runtime = document.createElement("div");//상영시간
			    	runtime.innerHTML=json[0].Data[0].Result[i].runtime+"분";
			    	
			    	document.getElementById(movie_container).appendChild(movieTitle);
			    	document.getElementById(movie_container).appendChild(moviePoster);
			    	document.getElementById(movie_container).appendChild(relDate);
			    	document.getElementById(movie_container).appendChild(runtime);
			    	
				}
				
				text_del();
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
		<form>
			검색해주세요 : <input id="query">
			<input type="button" value="검색"
						onclick="movieQuery(this.form);">
		</form>
		
		<div id="contents">
			<div id="movie_chart">
				<div id="chart_title">검색결과 </div>
				<div id="select_movie_list">
					<ul id="movie_list">
					
						<li id="searchText"><h3>어떤 영화가 궁금한가요? </h3></li>
						
						<c:forEach var="n" begin="0" end="9" step="1">
							<li id="movie_list_${n}"></li>
						</c:forEach>
					</ul>
				</div>
			
			</div>
		</div>
	</div>
	
</body>
</html>