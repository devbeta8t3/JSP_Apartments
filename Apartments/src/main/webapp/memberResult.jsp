<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<style type="text/css">
		.jumbotron{
			font-family: BMJUA;
		}
		.container {
			font-family: BMJUA;
		}
	</style>
	
	<title>회원 처리결과</title>
</head>
<body>
	
	<!-- Upper Navbar -->
	<jsp:include page="upperBar.jsp"></jsp:include>

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