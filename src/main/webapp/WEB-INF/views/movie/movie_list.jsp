<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title> 
	
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_rank.css">
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_query.css">
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/needDate.js"></script>
	<script type="text/javascript">
		
		window.onload=function(){
			load_release_list();
		};
		
		//날짜 비교 
		var date = new Date();
		
		var today = loadDate()-1;//1일에 문제될수있음
		var releaseStart = releaseDtStart();
		var releaseEnd = releaseDtEnd();
	
		console.log(today);
		console.log(releaseStart);
		console.log(releaseEnd);
	
		var moreCount = 1;//더보기 카운트
	
		function more_list(){
			moreCount++;
			document.getElementById("select_movie_lists_release_"+moreCount).style.display="block";
			if(moreCount == 4){
				var moreButton = document.getElementById("movie_release_list_moreSee");
				moreButton.removeChild( moreButton.children[0] );
			}
		}
		//박스오피스 버튼
		function boxOfficeView(){
			
			load_boxOff_list();
			document.getElementById("contents_release").style.display="none";
			document.getElementById("contents_query").style.display="none";
			document.getElementById("contents_rank").style.display="block";
		}
		//상영예정작 버튼
		function scheduledScreenView(){
			load_release_list();
			document.getElementById("contents_rank").style.display="none";
			document.getElementById("contents_query").style.display="none";
			document.getElementById("contents_release").style.display="block";
		}
		//검색버튼
		function queryMovie(){
			document.getElementById("contents_release").style.display="none";
			document.getElementById("contents_rank").style.display="none";
			document.getElementById("contents_query").style.display="block";
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
		function load_release_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseStart+'&releaseDte='+releaseEnd+'&listCount=32';
			sendRequest( url, param, resultFnRel, "GET" );
		}
		function resultFnRel(){	
			if( xhr.readyState == 4 && xhr.status == 200 ){		
				var data = xhr.responseText;
				var json = eval("["+data+"]");		
				
				for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
					
			    	var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴

			    	document.getElementById("movie_release_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//영화 코드1
			    	document.getElementById("movie_release_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//영화 코드2
			    	document.getElementById("movie_release_title_"+i).innerHTML=json[0].Data[0].Result[i].title;//영화 제목
			    	document.getElementById("movie_release_poster_"+i+"_img").src=moviePoster;//포스터
			    	
			    	//개봉날짜 체크
			    	var releaseY = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
			    	var releaseM = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
			    	var releaseD = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
			    	var releaseDate = releaseY+"."+releaseM+"."+releaseD+" 개봉";
			    	if(releaseD=="00"){
			    		releaseDate =  releaseY+"."+releaseM+". 개봉";
			    	}
			    	
			    	document.getElementById("movie_release_relDate_"+i).innerHTML=releaseDate;//개봉일
			    	document.getElementById("movie_release_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"분";//상영시간
		    		var movie_add_button=document.getElementById("movie_action_button_text_"+i); 
			    	if(movie_add_button.children[0] == undefined ){
				    	if(today >= json[0].Data[0].Result[i].repRlsDate-2){
			    	    	var aTag=document.createElement("a");
			    	    	aTag.href="#";
			    	    	aTag.innerHTML="예매";
			    	    	movie_add_button.appendChild(aTag);
				    		/* document.getElementById("movie_action_button_text_"+i).innerHTML="예매"; */
				    	} else{
			    	    	var pTag=document.createElement("p");
			    	    	pTag.innerHTML="개봉 예정";
			    	    	movie_add_button.appendChild(pTag);
				    		/* document.getElementById("movie_action_button_text_"+i).innerHTML="개봉 예정"; */
				    	}
			    	}
				}		
			}
		}
		
		//영화 코드 컨트롤러로 넘기기(영화 상세보기 위해서)
		function detail( movieId, movieSeq ){
			return location.href="movieInfoDetail.do?movieId="+movieId+"&movieSeq="+movieSeq;
		}
		
		//------------------rank----------------------------------------------------------
		function loading_del(){
		    var loadingText = document.getElementById("loadingText");
			if( loadingText.children[0] != undefined ){
				loadingText.removeChild( loadingText.children[0] );		    					
			}
		}
		//박스오피스를 가져오는 함수
		function load_boxOff_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
			var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt='+today;
			sendRequest( url, param, resultFnRank, "GET" );	
		}
		function resultFnRank(){
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				var json = eval("["+data+"]");	
				var movie_list =document.getElementById("movie_list");
				for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
					document.getElementById("movie_openDt_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt;//영화 코드(영진위)
					document.getElementById("movie_movieNm_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//영화 제목에서 자르기(영진위)
			    	document.getElementById("movie_rank_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//영화 제목
			    	document.getElementById("movie_rank_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";//순위
			    	document.getElementById("movie_rank_salesShare_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//예매율
			    	document.getElementById("movie_rank_audiAcc_"+i).innerHTML="누적관객수 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";//누적관객수
			    	document.getElementById("movie_rank_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"개봉";//개봉일
				}
				var openDt = document.getElementById("movie_openDt_"+0).value;
				var movieNm = document.getElementById("movie_movieNm_"+0).value;
				load_poster();
				loading_del();		
			}		
		}
		//박스오피스의 포스터 가져오기 (삭제하고 DB에서 포스터 가져올 예정)
		/* function load_poster(openDt, movieNm){
			var releaseDts = openDt.substring(0, 4)+openDt.substring(5, 7)+openDt.substring(8, 10);
			var url2 ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param2 = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseDts+'&title='+movieNm;
			sendRequest( url2, param2, resultFnPos, "GET" );
		} */
		function load_poster(){
			var url2 ="/moviePosterLoad.do";
			var param2 = "";
			console.log("here");
			sendRequest( url2, param2 , resultFnPos, "GET");
		}
		
		function resultFnPos(){				
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				var json = eval(data);
				console.log(data);
		    	
			}
		}
		//---------------------query-----------------------
		function text_del(){
		    var delText = document.getElementById("searchText");
		    delText.removeChild( delText.children[0] );
		}
		//검색 결과를 가지고 오는 Ajax매서드
		function load_Query( f ){
			console.log("here");
			var query = f.query.value.trim();
			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&listCount=6&query='+query;
			sendRequest( url, param, resultFnQu, "GET" );
		}
		
		function resultFnQu(){
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
				text_del();
			}
			
		}

		function load_Query2(f){
			if(event.keyCode == 13){
				load_Query( f );
			}
		}


	</script> 
</head>
<body>
	<div id="container">
	
		<div id="page_title">전체 영화</div>
		<input type="button" value="여기 눌러" onclick="load_poster();">
		
		<div id="movie_list_nav">
			<div class="movie_list_nav1"><input type="button" value="박스오피스" onclick="boxOfficeView();"></div><!-- /movie/movieRankList.do -->
			<div class="movie_list_nav2"><input type="button" value="상영 예정작" onclick="scheduledScreenView();"></div><!-- /movie/movieReleaseList.do -->
			<div class="movie_list_nav3"><input type="button" value="영화 검색" onclick="queryMovie();"></div><!-- /movie/movieQuery.do -->
		</div>
		<div id="contents_release">
			<div id="movie_chart_release">
				<div id="select_movie_lists_release">
					<c:forEach var="n" begin="0" end="7" step="1">
						<div id="movie_release_list_${n}">
							<input type="hidden" id="movie_release_movieId_${n}">
							<input type="hidden" id="movie_release_movieSeq_${n}">
							
							<div id="movie_release_title_${n}"></div>
							
							<div class="postor_hover">
								<div id="movie_release_poster_${n}">
									<img id="movie_release_poster_${n}_img" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value);">
								</div>
							</div>
							
							<div id="movie_release_relDate_${n}"></div>
							<div id="movie_release_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_2">
					<c:forEach var="n" begin="8" end="15" step="1">
						<div id="movie_release_list_${n}">
							<input type="hidden" id="movie_release_movieId_${n}">
							<input type="hidden" id="movie_release_movieSeq_${n}">
							
							<div id="movie_release_title_${n}"></div> 
							
							<div id="movie_release_poster_${n}">
								<img id="movie_release_poster_${n}_img" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_release_relDate_${n}"></div>
							<div id="movie_release_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_3">
					<c:forEach var="n" begin="16" end="23" step="1">
						<div id="movie_release_list_${n}">
							<input type="hidden" id="movie_release_movieId_${n}">
							<input type="hidden" id="movie_release_movieSeq_${n}">
							
							<div id="movie_release_title_${n}"></div>
							
							<div id="movie_release_poster_${n}">
								<img id="movie_release_poster_${n}_img" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_release_relDate_${n}"></div>
							<div id="movie_release_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="select_movie_lists_release_4">
					<c:forEach var="n" begin="24" end="31" step="1">
						<div id="movie_release_list_${n}">
							<input type="hidden" id="movie_release_movieId_${n}">
							<input type="hidden" id="movie_release_movieSeq_${n}">
							
							<div id="movie_release_title_${n}"></div>
							
							<div id="movie_release_poster_${n}">
								<img id="movie_release_poster_${n}_img" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value);">
							</div>
							
							<div id="movie_release_relDate_${n}"></div>
							<div id="movie_release_runtime_${n}"></div>
							
							<div id="movie_action_button_text_${n}"></div>
						</div>
					</c:forEach>
				</div>
				
				<div id="movie_release_list_moreSee"><input type="button" value="더보기" onclick="more_list();"></div>
			</div>
		</div>
		
		<div id="contents_rank">
			<div id="select_movie_list">
				<ul id="movie_list">
					<li id="loadingText"><h3>Loading...</h3></li>
					<c:forEach var="n" begin="0" end="9" step="1">
						<li id="movie_list_${n}" style="margin:10px">
							<input type="hidden" id="movie_openDt_${n}">
							<input type="hidden" id="movie_movieNm_${n}">
							<div id="movie_rank_movieNm_${n}"></div>
							<div id="movie_rank_postor_${n}">
								<img id="movie_rank_poster_${n}_img">
							</div>
							<div id="movie_rank_rank_${n}"></div>
							<div id="movie_rank_salesShare_${n}"></div>
							<div id="movie_rank_audiAcc_${n}"></div>
							<div id="movie_rank_openDt_${n}"></div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		
		<div id="contents_query">
			
			<form name="searchForm" onsubmit="return false;" method="post">
				<div >
				
					<input name="query" id="query" onkeypress="load_Query2(this.form);">
					
					<input type="button" value="검색" onclick="load_Query(this.form);">
				</div>
			</form>
			
			<div id="select_movie_list">
				<ul id="movie_list">
					<li id="searchText"><h3>어떤 영화가 궁금한가요? </h3></li>		
					<c:forEach var="n" begin="0" end="9" step="1">
						<li id="movie_list_${n}">
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
	
</body>
</html>