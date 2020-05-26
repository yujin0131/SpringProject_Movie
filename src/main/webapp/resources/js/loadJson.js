document.write("<script src='httpRequest.js'></script>");

onmessage = function(event){
//-------------------------------------------------------------------------
var openDt = event.data[0];
var movieNm = event.data[1];
function load_poster0(openDt, movieNm){
	var releaseDts = openDt.substring(0, 4)+openDt.substring(5, 7)+openDt.substring(8, 10);
	var url2 ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
	var param2 = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseDts+'&title='+movieNm;
	console.log(releaseDts, movieNm);
	console.log("here");
	sendRequest( url2, param2, resultFn0, "GET" );
	
}

function resultFn0(){				
	if( xhr.readyState == 4 && xhr.status == 200 ){

		var data = xhr.responseText;
		var json = eval("["+data+"]");
		
		moviePoster = cutPoster(json[0].Data[0].Result[0].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
		postMessage(moviePoster);
	}
}
load_poster0(openDt, movieNm);
}
