<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_list.css">
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
	
		window.onload=function(){
			load_list();
		};
	
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
		
		function load_list(){

			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&movieId=${movieId}&movieSeq=${movieSeq}';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");		

		    	var moviePoster = cutPoster(json[0].Data[0].Result[0].posters);
		    	
		    	document.getElementById("movie_list_title_0").innerHTML=json[0].Data[0].Result[0].title;//영화 제목
		    	document.getElementById("movie_list_titleEng_0").innerHTML=json[0].Data[0].Result[0].titleEng;//영화 영문 제목titleEng
		    	document.getElementById("movie_list_poster_0_img").src=moviePoster;//포스터
		    	
		    	document.getElementById("movie_list_directors_0").innerHTML=json[0].Data[0].Result[0].directors.director[0].directorNm;//감독
		    	
		    	var actor = "";
		    	var maxNum = json[0].Data[0].Result[0].actors.actor.length;
		    	
		    	for(var i=0 ; i<maxNum; i++){
			    	actor += json[0].Data[0].Result[0].actors.actor[i].actorNm;//배우
		    	}
			    document.getElementById("movie_list_actors_0").innerHTML=actor;//배우들
			    
			    document.getElementById("movie_list_genre_0").innerHTML=json[0].Data[0].Result[0].genre;//장르
			    document.getElementById("movie_list_rating_0").innerHTML=json[0].Data[0].Result[0].rating;//관람등급
			    document.getElementById("movie_list_nation_0").innerHTML=json[0].Data[0].Result[0].nation;//국가
			    document.getElementById("movie_list_company_0").innerHTML=json[0].Data[0].Result[0].company;//회사
		    	
		    	document.getElementById("movie_list_relDate_0").innerHTML=json[0].Data[0].Result[0].repRlsDate+" 개봉";//개봉일
		    	document.getElementById("movie_list_runtime_0").innerHTML=json[0].Data[0].Result[0].runtime+"분";//상영시간
			    	
		    	document.getElementById("movie_list_plots_0").innerHTML=json[0].Data[0].Result[0].plots.plot[0].plotText;//줄거리
				
			}
			
		}
	</script>
		

</head>
<body>
	${movieSeq}
	${movieId}
	<div>
		<a href="/movie/movieReleaseList.do">상영 예정작</a>
		<a href="/movie/movieRankList.do">무비 차트(일간)(주간)</a>
		<a href="/movie/movieQuery.do">영화 검색</a>
	</div> 
	<div id="container">
		<div id="contents">
			<div id="movie_chart">
				<div id="chart_title"><h4>상영 예정작</h4></div>
				
				<div id="select_movie_lists">
					<ul id="movie_lists">
							<li id="movie_list_0" style="margin:10px">
								<div id="movie_list_title_0"></div>
								<div id="movie_list_titleEng_0"></div>
								<div id="movie_list_poster_0">
									<img id="movie_list_poster_0_img">
								</div>
								
								<div id="movie_list_directors_0"></div>
								<div id="movie_list_actors_0"></div>
								
								<div id="movie_list_genre_0"></div>
								
								<div id="movie_list_rating_0"></div>
								<div id="movie_list_nation_0"></div>
								
								<div id="movie_list_company_0"></div>
								
								<div id="movie_list_relDate_0"></div>
								<div id="movie_list_runtime_0"></div>
								
								<div id="movie_list_plots_0"></div>
							</li>
					</ul>
				</div>
			
			</div>
		</div>
	</div>
</body>
</html>