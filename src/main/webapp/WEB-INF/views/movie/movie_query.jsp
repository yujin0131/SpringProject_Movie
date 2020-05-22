<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>무비 - 영화 검색</title>

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
					var li = document.createElement("li");//영화 제목
			    	li.innerHTML=json[0].Data[0].Result[i].title;
			    	li.value=json[0].Data[0].Result[i].title;
			    	var liID=json[0].Data[0].Result[i].movieSeq;
			    	
			    	li.id = liID;
			    	movie_list.appendChild(li);
					
			    	var moviePoster = document.createElement("img");//영화 포스터
			    	moviePoster.src=cutPoster(json[0].Data[0].Result[i].posters);
			    	movie_list.appendChild(moviePoster);
			    	
			    	var relDate = document.createElement("div");//영화 개봉일
			    	relDate.innerHTML=json[0].Data[0].Result[i].repRlsDate+" 개봉";
			    	movie_list.appendChild(relDate);
			    	
			    	var runtime = document.createElement("div");//영화 개봉일
			    	runtime.innerHTML=json[0].Data[0].Result[i].runtime+"분";
			    	movie_list.appendChild(runtime);

			    	
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
		<form>
			검색해주세요 : <input name="query" value="검색">
			<input type="button" value="검색"
						onclick="movieQuery(this.form);">
		</form>
		
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