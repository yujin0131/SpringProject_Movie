<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_detail.css">
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
	
		window.onload=function(){
			var outposters;
			load_list();
		};
	
		//여러개 포스터 잘라쓰기
		function spPoster(inPosters) {
			
	    	outposters = inPosters.split('|');
			
			if (inPosters === "") {
				outposters[0] = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
			}
			
			//한개 포스터 출력
			var onePoster = document.createElement("img");
		    onePoster.src = outposters[0];
		    document.getElementById("movie_detail_poster_contain").appendChild(onePoster);
			
		    //여러개의 포스터 출력(임시 : 포스터 더보기 누르면 뜨게)
			/* for(var i = 0 ; i<outposters.length; i++){
			    var onePoster = document.createElement("img");
		    	onePoster.src = outposters[i];
		    	document.getElementById("movie_detail_poster_contain").appendChild(onePoster); 
	    	} */

		}
		
		//필요한 OPEN API 불러오기(Ajax)
		function load_list(){

			var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
			var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&movieId=${movieId}&movieSeq=${movieSeq}';
			sendRequest( url, param, resultFn, "GET" );
			
		}
		function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var data = xhr.responseText;
				var json = eval("["+data+"]");		

		    	spPoster(json[0].Data[0].Result[0].posters);//포스터
		    	
		    	document.getElementById("movie_detail_title").innerHTML=json[0].Data[0].Result[0].title;//영화 제목
		    	document.getElementById("movie_detail_titleEng").innerHTML=json[0].Data[0].Result[0].titleEng;//영화 영문 제목
		    	document.getElementById("movie_detail_directors").innerHTML="<b>감독  </b>" +json[0].Data[0].Result[0].directors.director[0].directorNm;//감독
		    	
		    	//배우 출력하기 위한 코드
		    	var actor = "<b>배우  </b>";
		    	var maxNumActor = json[0].Data[0].Result[0].actors.actor.length;
		    	var etc = 0;
		    	//배우가 많으면 5명만 출력
		    	if( maxNumActor >= 6 ){
		    		maxNumActor = 6;
		    		etc = 1;
		    	}
		    	
		    	for(var i=0 ; i<maxNumActor; i++){
			    	if( i === maxNumActor-1 ){
			    		actor += json[0].Data[0].Result[0].actors.actor[i].actorNm;
			    		if( etc === 1 ) {
			    			actor += " 등..";
			    		}
			    	} else {
				    	actor += json[0].Data[0].Result[0].actors.actor[i].actorNm + " ,  ";//배우 한명 한명			    		
			    	}
		    	}
			    document.getElementById("movie_detail_actors").innerHTML=actor;//배우들
		    	etc = 0;
			    
			    document.getElementById("movie_detail_genre").innerHTML="<b>장르  </b>"+json[0].Data[0].Result[0].genre;//장르
			    document.getElementById("movie_detail_rating").innerHTML=json[0].Data[0].Result[0].rating;//관람등급
			    document.getElementById("movie_detail_nation").innerHTML="<b>국가  </b>"+json[0].Data[0].Result[0].nation;//국가
			    document.getElementById("movie_detail_company").innerHTML="<b>제작  </b>"+json[0].Data[0].Result[0].company;//회사
		    	
		    	document.getElementById("movie_detail_relDate").innerHTML=json[0].Data[0].Result[0].repRlsDate+" 개봉";//개봉일
		    	document.getElementById("movie_detail_runtime").innerHTML=json[0].Data[0].Result[0].runtime+"분";//상영시간
			    	
		    	document.getElementById("movie_detail_plot").innerHTML=json[0].Data[0].Result[0].plots.plot[0].plotText;//줄거리
				
		    	//여러개의 스틸이미지를 출력하기 위함
		    	var stills = json[0].Data[0].Result[0].stlls;
		    	var splitStills = stills.split('|');
				
		    	for(var i = 0 ; i<splitStills.length; i++){
			    	var oneStill = document.createElement("img");
			    	oneStill.src = splitStills[i];
			    	document.getElementById("movie_detail_still").appendChild(oneStill);
		    	}
		    	
			}
			
		}
		
	</script>
		

</head>
<body>
	${movieSeq}
	${movieId}
	<div>

	</div> 
	<div id="container">
		<div id="contents">
			<div id="movie_chart">
				<div id="chart_title"><h4>영화 상세 정보</h4></div>
				
				<div id="show_movie_details_con">
				
					<div id="movie_detail_poster">
						<div id="movie_detail_poster_contain"></div>
						<!-- <input type="button" value="포스터 더 보기" onclick="moreView();"> -->
					</div>
					
					<div id="movie_detail_infomation">
						<div id="movie_titles">
							<div id="movie_detail_title"></div>
							<div id="movie_detail_titleEng"></div>					
						</div>
							
						<div id="movie_baseInfo">
							<div id="movie_detail_genre"></div>
							<div id="movie_detail_relDate"></div>
							<div id="movie_detail_runtime"></div>
	
							<div id="movie_detail_directors"></div>
							<div id="movie_detail_actors"></div>					
						</div>	
						
						<div id="movie_baseInfo_2">
							<div id="movie_detail_nation"></div>					
							<div id="movie_detail_rating"></div>
							<div id="movie_detail_company"></div>
						</div>
						
					</div>
					
					<div id="movie_detail_plots">
						<div id="movie_detail_plot_title">Plot</div>
						<div id="movie_detail_plot"></div>					
					</div>
					
					
					<div id="movie_detail_still"></div>

				</div>
			
			</div>
		</div>
	</div>
</body>
</html>