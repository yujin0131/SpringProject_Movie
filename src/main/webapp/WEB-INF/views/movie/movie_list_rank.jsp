<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_rank.css"> 
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">	
	
		var date = new Date();
		var today = addButton()-1;
		
		console.log(today);
		
		function addButton(){
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
	
		window.onload=function(){
			load_list();
		};
		
		//포스터 잘라쓰기
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
		function loading_del(){

		    var loadingText = document.getElementById("loadingText");
		    loadingText.removeChild( loadingText.children[0] );
		    
		}
		//목록을 가져오는 함수
		function load_list(){
			//192.168.1.101:9090/vs/list.do
			var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
			var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt='+today;
			sendRequest( url, param, resultFn, "GET" );
			
		}
		
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");
				
				var movie_list =document.getElementById("movie_list");
				for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){
					
					var movie_container = "movie_list_"+i;//영화 정보 담는 컨테이너
					document.getElementById("movie_openDt_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt;//영화 코드(영진위)
					document.getElementById("movie_movieNm_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//영화 제목에서 자르기(영진위)
					
			    	document.getElementById("movie_rank_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//영화 제목
			    	/* document.getElementById("movie_list_poster_"+i+"_img").src=moviePoster;//포스터 */
			    	document.getElementById("movie_rank_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";//순위
			    	document.getElementById("movie_rank_salesShare_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//예매율
			    	document.getElementById("movie_rank_audiAcc_"+i).innerHTML="누적관객수 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";//누적관객수
			    	document.getElementById("movie_rank_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"개봉";//개봉일
			    	
				}

				var openDt = document.getElementById("movie_openDt_"+0).value;
				var movieNm = document.getElementById("movie_movieNm_"+0).value;
				load_poster0(openDt, movieNm);
				
				loading_del();
				//여기는 멀티스레드를 이용해 출력해보려는 노력코드
				/* var worker = new Worker("${ pageContext.request.contextPath }/resources/js/loadJson.js");
				

				var infoArr = [openDt, movieNm]
				worker.postMessage(infoArr);
				worker.onmessage=function(event){
					var moviePosterName = event.data;
					console.log(moviePosterName);
					document.getElementById("movie_rank_poster_"+0+"_img").src=moviePosterName;//포스터
				} */
				
				
				//var openDt2 = document.getElementById("movie_openDt_"+1).value;
				//var movieNm2 = document.getElementById("movie_movieNm_"+1).value;
				//load_poster1(openDt2, movieNm2);

				
			}
			
		}
		
		//-------------------------------------------------------------------
		
		
		//여기는 하나씩 해보려했으나 포스터 한개만 출력되는 코드..
		function load_poster0(openDt, movieNm){
			var releaseDts = openDt.substring(0, 4)+openDt.substring(5, 7)+openDt.substring(8, 10);
			var url2 ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param2 = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseDts+'&title='+movieNm;
			sendRequest( url2, param2, resultFn0, "GET" );
		
		}
		function resultFn0(){				
			if( xhr.readyState == 4 && xhr.status == 200 ){
		    	console.log("here");
				var data = xhr.responseText;
				var json = eval("["+data+"]");

		    	var moviePoster = cutPoster(json[0].Data[0].Result[0].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
		    	document.getElementById("movie_rank_poster_"+0+"_img").src=moviePoster;//포스터
			}
		}
		
		/*function load_poster1(openDt2, movieNm2){
			
			var releaseDts2 = openDt2.substring(0, 4)+openDt2.substring(5, 7)+openDt2.substring(8, 10);
			var url3 ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param3 = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseDts2+'&title='+movieNm2;
			console.log(param3);
			sendRequest( url3, param3, resultFn1, "GET" );
			
		}
		function resultFn1(){				
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				var json = eval("["+data+"]");
				console.log(json[0].Data[0].Result[0].posters);
		    	var moviePoster2 = cutPoster(json[0].Data[0].Result[0].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
		    	document.getElementById("movie_rank_poster_"+1+"_img").src=moviePoster2;//포스터
			}
		} 
		*/
		//--------------------------------------------------------------------
		
		
	</script>
</head>
<body>
	<div>
		<a href="/movie/movieReleaseList.do">상영 예정작</a>
		<a href="/movie/movieRankList.do">무비 차트(일간)(주간)</a>
		<a href="/movie/movieQuery.do">영화 검색</a>
	</div>
	
	<div id="container_rank">
		<div id="contents">
			<div id="movie_chart">
				<div id="chart_title">무비 차트(일간)(주간)</div>
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
		</div>
	</div>
	
</body>
</html>