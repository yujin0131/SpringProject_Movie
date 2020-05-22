<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/style.css">

</head>

<body>
	
	<table width="700" align="center">
		<tr>
			<td>
				<!-- 타이틀 영역 -->
				<table width="690" height="50">
					<tr>
						<td><img src="${ pageContext.request.contextPath }/resources/img/title_04.gif"></td>
					</tr>
				</table>
				<!-- 타이틀 영역 -->
			</td>
		</tr>
		
		<!-- 게시판 리스트 시작 -->
		<tr>
			<td>
				<table width="690">
					
					<tr>
						<td width="50" class="td_a">번호</td>
						<td width="2" class="td_b">
							<img src="${ pageContext.request.contextPath }/resources/img/td_bg_01.gif">
						</td>
						
						<td width="300" class="td_b">제목</td>
						<td width="2" class="td_b">
							<img src="${ pageContext.request.contextPath }/resources/img/td_bg_01.gif">
						</td>
						
						<td width="90" class="td_b">작성자</td>
						<td width="2" class="td_b">
							<img src="${ pageContext.request.contextPath }/resources/img/td_bg_01.gif">
						</td>
						
						<td width="90" class="td_b">작성일</td>
						<td width="2" class="td_b">
							<img src="${ pageContext.request.contextPath }/resources/img/td_bg_01.gif">
						</td>
						
						<td width="60" class="td_c">조회수</td>
					</tr>
					
					<c:forEach var="vo" items="${ list }">
			<tr>
				<td align="center" class="td_a_1">${ vo.idx }</td>
				<td class="td_b_1"><img src="${ pageContext.request.contextPath }/resources/img/td_bg_02.gif"></td>
				<td class="td_b_1 left">
					<!-- 댓글 들여쓰기 -->
					<c:forEach begin="1" end="${vo.depth}">
						&nbsp;     
					</c:forEach>	
					
					<!-- 댓글기호 -->
					<c:if test="${vo.depth ne 0 }">
						ㄴ
					</c:if>		
					
					<!-- 일반게시글은 클릭 가능 -->
					<c:if test="${vo.del_info ne -1 }">
						<a href="view.do?idx=${vo.idx}&page=${ empty param.page ? 1 : param.page}" class="num">
							${ vo.subject }<!-- 제목 -->
						</a>
					</c:if>
					
					<!-- 삭제된 게시글은 클릭 불가 -->
					<c:if test="${vo.del_info eq -1}">
						<a href="" style="color:pink">
							${vo.subject}
						</a>
					</c:if>
					
				</td>
				
				<td class="td_b_1"><img src="${ pageContext.request.contextPath }/resources/img/td_bg_02.gif"></td>	
				
				<td class="td_b_1" align="center">${vo.name}</td>
				
				<td class="td_b_1"><img src="${ pageContext.request.contextPath }/resources/img/td_bg_02.gif"></td>
				
				<td class="td_b_1" align="center">${vo.regdate}</td>
				
				<td class="td_b_1"><img src="${ pageContext.request.contextPath }/resources/img/td_bg_02.gif"></td>
				
				<td class="td_c_1" align="center">${vo.readhit}</td>
			</tr>
		</c:forEach>
		<!-- 게시판 리스트 끝 -->
					
				<c:if test="${ empty list }">
					<tr>
						<td align="center" colspan="11" 
						    width="100%" height="50"
						 	style="border:2px solid #767676">
							현재 등록된 글이 없습니다
						</td>
					</tr>
				</c:if>
					
				</table>
			</td>
		</tr>
		
		<tr>
			<td height="8"></td>
		</tr>
		
		<tr>
			<td class="f11" align="center">
				${pageMenu}
			</td>
		</tr>
		
		<tr>
			<td height="5"></td>
		</tr>
		
		<tr>
			<td>
				<img src="${ pageContext.request.contextPath }/resources/img/btn_reg.gif" 
				onclick="location.href='insert_form.do'">
			</td>
		</tr>
		
	</table>
	
	
</body>

</html>










































