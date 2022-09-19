<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>회원 처리결과</title>
</head>
<body>
	
	<!-- Upper Navbar -->
	<div class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 mb-3 bg-dark border-bottom shadow-sm sticky-top">
		<h3 class="my-0 mr-md-auto font-weight-bold text-light">Apartments</h3>
		<h6 class="my-0 mr-md-auto text-light font-italic"> Find your best apartment!</h6>
		<nav class="my-2 my-md-0 mr-md-3">
			<a class="p-2 text-light" href="apt.jsp">아파트 찾기</a>
			<a class="p-2 text-light mr-3" href="board.jsp">질문 게시판</a>
			<c:choose>
				<c:when test="${empty sessionId}">
					<!-- 로그인 아닐때 보여지는 메뉴 -->
	 				<a class="btn btn-primary mr-2" href="memberLogin.jsp">Log in</a>
	 				<a class="btn btn-danger" href="memberSignup.jsp">Sign up</a>
				</c:when>
				<c:otherwise>
					<!-- 로그인 시 보여지는 메뉴 : if sessionId != null 로 처리하자 -->
					<a class="p-2 text-light" href="#">[<%= sessionId %>]님 접속중!</a>
					<a class="p-2 text-light mr-2" href="memberUpdate.jsp">회원정보</a>
					<a class="btn btn-warning" href="memberLogout.jsp">Log out</a>
				</c:otherwise>
			</c:choose>
		</nav>
	</div>

	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 처리결과</h1>
		</div>
	</div>

	<div class="container" align="center">
		<%
			String msg = request.getParameter("msg");

			if (msg != null) {
				if (msg.equals("0"))
					out.println(" <h2 class='alert alert-warning'>회원정보가 수정되었습니다.</h2>");
				else if (msg.equals("1"))
					out.println(" <h2 class='alert alert-success'>회원가입을 축하드립니다. 로그인하세요.</h2>");
				else if (msg.equals("2")) {
					String loginId = (String) session.getAttribute("sessionId");
					out.println(" <h2 class='alert alert-primary'>" + loginId + "님 환영합니다</h2>");
				}				
			} else {
				out.println("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
			}
		%>
	</div>	
</body>
</html>