<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title> 

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
		
		window.onload=function(){
			load_list();
		};
		
		//날짜 비교 
		var date = new Date();
		var today = loadDate()-1;//1일에 문제될수있음
		var releaseStart = releaseDtStart();
		var releaseEnd = releaseDtEnd();
		
		console.log(today);
		console.log(releaseStart);
		console.log(releaseEnd);
		function loadDate(){
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			var day=date.getDate();
			if((month+"").length < 2){
				month = "0" + month;
			}
			if((day+"").length < 2){
				day = "0" + day;
			}
			var getDate = year + month + day;
			return eval(getDate);
		}
		
		//3일 전 날짜 불러오기
		function releaseDtStart(){
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			var day=date.getDate();
			if(day < 4){
				day = day+25;
				if(month == 1){
					month = 12;
				} else{
					month = month-1;
				}
			} else{
				day = day - 3;
			}
			if((month+"").length < 2){
				month = "0" + month;
			}
			if((day+"").length < 2){
				day = "0" + day;
			}
			var getDate = year + month + day;
			return eval(getDate);
		}
		//한달 후 날짜 불러오기
		function releaseDtEnd(){
			var year=date.getFullYear();
			var month=date.getMonth()+1;
			var day=date.getDate();
			if(month == 12){
				month = 1
			} else {
				month = month + 1;
			}
			if((month+"").length < 2){
				month = "0" + month;
			}
			if((day+"").length < 2){
				day = "0" + day;
			}
			var getDate = year + month + day;
			return eval(getDate);
		}
	
		var moreCount = 1;
	
		function more_list(){
			moreCount++;
			var show = document.getElementById("select_movie_lists_release_"+moreCount).style.display="block";
			if(moreCount == 4){
				var moreButton = document.getElementById("movie_list_moreSee");
				moreButton.removeChild( moreButton.children[0] );
			}
		}
		
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
		function load_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseStart+'&releaseDte='+releaseEnd+'&listCount=32';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");		
				
				for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
					
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
			    	var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
			    	//20202020
			    	document.getElementById("movie_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//영화 코드1
			    	document.getElementById("movie_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//영화 코드2
			    	document.getElementById("movie_list_title_"+i).innerHTML=json[0].Data[0].Result[i].title;//영화 제목
			    	document.getElementById("movie_list_poster_"+i+"_img").src=moviePoster;//포스터
			    	
			    	//개봉날짜 체크
			    	var releaseY = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
			    	var releaseM = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
			    	var releaseD = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
			    	var releaseDate = releaseY+"."+releaseM+"."+releaseD+" 개봉";
			    	if(releaseD=="00"){
			    		releaseDate =  releaseY+"."+releaseM+". 개봉";
			    	}
			    	
			    	document.getElementById("movie_list_relDate_"+i).innerHTML=releaseDate;//개봉일
			    	document.getElementById("movie_list_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"분";//상영시간
			    	if(today >= json[0].Data[0].Result[i].repRlsDate){
			    		document.getElementById("movie_action_button_text_"+i).innerHTML="예매";
			    	} else{
			    		document.getElementById("movie_action_button_text_"+i).innerHTML="개봉 예정";
			    	}
			    	
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
	<div id="container_release">
		<div id="contents_release"> 
			<div id="movie_chart_release">
				<div id="chart_title_1">전체 영화</div>
				
				<div id="movie_list_nav">
					<div class="movie_list_nav1"><a href="/movie/movieRankList.do">무비 차트(일간)(주간)</a></div>
					<div class="movie_list_nav2"><a href="/movie/movieReleaseList.do">상영 예정작</a></div>
					<div class="movie_list_nav3"><a href="/movie/movieQuery.do">영화 검색</a></div>
				</div>
				
				
				<div id="select_movie_lists_release">
					<c:forEach var="n" begin="0" end="7" step="1">
						<div id="movie_list_${n}">
							<input type="hidden" id="movie_movieId_${n}">
							<input type="hidden" id="movie_movieSeq_${n}">
							
							<div id="movie_list_title_${n}"></div>
							
							<div id="movie_list_poster_${n}">
								<img id="movie_list_poster_${n}_img" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_list_relDate_${n}"></div>
							<div id="movie_list_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_2">
					<c:forEach var="n" begin="8" end="15" step="1">
						<div id="movie_list_${n}">
							<input type="hidden" id="movie_movieId_${n}">
							<input type="hidden" id="movie_movieSeq_${n}">
							
							<div id="movie_list_title_${n}"></div> 
							
							<div id="movie_list_poster_${n}">
								<img id="movie_list_poster_${n}_img" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_list_relDate_${n}"></div>
							<div id="movie_list_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_3">
					<c:forEach var="n" begin="16" end="23" step="1">
						<div id="movie_list_${n}">
							<input type="hidden" id="movie_movieId_${n}">
							<input type="hidden" id="movie_movieSeq_${n}">
							
							<div id="movie_list_title_${n}"></div>
							
							<div id="movie_list_poster_${n}">
								<img id="movie_list_poster_${n}_img" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_list_relDate_${n}"></div>
							<div id="movie_list_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_4">
					<c:forEach var="n" begin="24" end="31" step="1">
						<div id="movie_list_${n}">
							<input type="hidden" id="movie_movieId_${n}">
							<input type="hidden" id="movie_movieSeq_${n}">
							
							<div id="movie_list_title_${n}"></div>
							
							<div id="movie_list_poster_${n}">
								<img id="movie_list_poster_${n}_img" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_list_relDate_${n}"></div>
							<div id="movie_list_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="movie_list_moreSee"><input type="button" value="더보기" onclick="more_list();"></div>
			</div>
		</div>
	</div>
	
</body>
</html>