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
		
		//이미지 클릭시 상세보기 "reply_form.do?idx=${vo.idx}&page=${param.page}";
		function imgclick(){
			location.href = "movieInfoDetail.do";
		}
		
		//목록을 가져오는 함수
		function load_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts=20200519&releaseDte=20200618&listCount=10';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");		
				
				for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
					
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
			    	var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
			    	
			    	document.getElementById("movie_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//영화 코드1
			    	document.getElementById("movie_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//영화 코드2
			    	document.getElementById("movie_list_title_"+i).innerHTML=json[0].Data[0].Result[i].title;//영화 제목
			    	document.getElementById("movie_list_poster_"+i+"_img").src=moviePoster;//포스터
			    	document.getElementById("movie_list_relDate_"+i).innerHTML=json[0].Data[0].Result[i].repRlsDate+" 개봉";//개봉일
			    	document.getElementById("movie_list_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"분";//상영시간
			    	
				}
				
			}
			
		}
		//영화 코드 컨트롤러로 넘기기
		function detail( movieId, movieSeq ){
			return location.href="movieInfoDetail.do?movieId="+movieId+"&movieSeq="+movieSeq;
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
				<div id="chart_title"><h4>상영 예정작</h4></div>
				
				<div id="select_movie_lists">
					<ul id="movie_lists">
						<c:forEach var="n" begin="0" end="9" step="1">
							<li id="movie_list_${n}" style="margin:10px">
									<input type="hidden" id="movie_movieId_${n}">
									<input type="hidden" id="movie_movieSeq_${n}">
									<div id="movie_list_title_${n}"></div>
									<div id="movie_list_poster_${n}">
										<img id="movie_list_poster_${n}_img" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value);">
									</div>
									<div id="movie_list_relDate_${n}"></div>
									<div id="movie_list_runtime_${n}"></div>
							</li>
						</c:forEach>
					</ul>
				</div>
			
			</div>
		</div>
	</div>
	
</body>
</html>