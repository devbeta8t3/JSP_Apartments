<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<!DOCTYPE html>

<html>
<head>
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<style type="text/css">
		/* 우아한 형제들 주아체 :: 약간 굵은 글자 */
		@font-face {
		    font-family: 'BMJUA';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/BMJUA.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		.d-flex {
			font-family: BMJUA;
		}
		
	</style>
</head>
<body>

	<!-- Upper Navbar -->
	<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-dark border-bottom shadow-sm sticky-top">
		<h3 class="my-0 mr-md-auto text-light">아파트의 민족</h3>
		<h6 class="my-0 mr-md-auto text-light font-italic"> " 살기좋은 아파트를 찾아라! "</h6>
		<nav class="my-2 my-md-0 mr-md-3">
			<a class="p-2 text-light" href="apt.jsp">아파트 찾기</a>
			<a class="p-2 text-light mr-3" href="board.jsp">질문 게시판</a>
			<c:choose>
				<c:when test="${empty sessionId}">
					<!-- 로그인 아닐때 보여지는 메뉴 -->
	 				<a class="btn btn-primary mr-2" href="memberLogin.jsp">로그인</a>
	 				<a class="btn btn-danger" href="memberSignup.jsp">회원가입</a>
				</c:when>
				<c:otherwise>
					<!-- 로그인 시 보여지는 메뉴 : if sessionId != null 로 처리하자 -->
					<a class="p-2 text-warning" href="#">[<%= sessionId %>]님</a>
					<a class="p-2 text-light mr-2" href="memberUpdate.jsp">회원정보</a>
					<a class="btn btn-warning" href="memberLogout.jsp">로그아웃</a>
				</c:otherwise>
			</c:choose>
		</nav>
	</div>
	

</body>
</html>