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
		body{
			margin: 0;
			padding: 0;
			background: url(bg_apt.jpg) no-repeat;
			height: 100vh;font-family: sans-serif;
			background-size: cover;
			background-repeat: no-repeat;
			background-position: center;
			overflow: hidden
		}
		@media screen and (max-width: 600px;){body{background-size: cover;: fixed}}
		#particles-js{
			height: 100%
		}
		.loginBox{
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%,-50%);
			width: 350px;
			min-height: 200px;
			/* background: #000000; */
			border-radius: 10px;
			padding: 40px;
			box-sizing: border-box
		}
		.user{
			margin: 0 auto;
			display: block;
			margin-bottom: 20px
		}
		h3{
			margin: 0;
			padding: 0 0 20px;
			color: #59238F;
			text-align: center
		}
		.loginBox input{
			width: 100%;
			margin-bottom: 20px
		}
		.loginBox input[type="text"], .loginBox input[type="password"]{
			border: none;
			border-bottom: 2px solid #262626;
			outline: none;
			height: 40px;
			color: #59238F;
			background: transparent;
			font-size: 16px;
			padding-left: 20px;
			box-sizing: border-box
		}
		.loginBox input[type="text"]:hover, .loginBox input[type="password"]:hover{
			color: #000000;		/* 글자색 */
			border: 1px solid #42F3FA;
			box-shadow: 0 0 5px rgba(0,255,0,.3), 0 0 10px rgba(0,255,0,.2), 0 0 15px rgba(0,255,0,.1), 0 2px 0 black
		}
		.loginBox input[type="text"]:focus, .loginBox input[type="password"]:focus{
			border-bottom: 2px solid #42F3FA
		}
		.inputBox{
			position: relative
		}
		.inputBox span{
			position: absolute;
			top: 10px;
			color: #262626
		}
		.loginBox input[type="submit"]{
			border: none;
			outline: none;
			height: 40px;
			font-size: 16px;
			background: #59238F;
			color: #fff;
			border-radius: 20px;
			cursor: pointer
		}
		.loginBox a{
			color: #262626;
			font-size: 14px;
			font-weight: bold;
			text-decoration: none;
			text-align: center;
			display: block
		}
		a:hover, .pupple:hover{
			color: #00ffff
		}
		.pupple{
			color: #fff;
			border-radius: 20px;
		}
	
	</style>
	
	<title>Log in</title>
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
	
<!-- 
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">로그인</h1>
		</div>
	</div>
-->

	<div class="container" align="center">
	
		<div class="loginBox bg-warning"> <img class="user" src="https://i.ibb.co/yVGxFPR/2.png" height="100px" width="100px">
        	<h3>Log in here</h3>
        	<%
				// 로그인 실패시 표시되는 내용
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디, 비밀번호를 확인하세요");
					out.println("</div>");
				}
			%>
        	<form action="memberLoginProcess.jsp" method="post">
            	<div class="inputBox"> 
            		<input id="uname" type="text" name="id" placeholder="ID"> 
            		<input id="pass" type="password" name="password" placeholder="Password"> 
            	</div> 
            		<input type="submit" name="" value="Login">
        	</form> 
	        <a href="#" onclick="alert('아직 기능이 구현되지 않았습니다.')">Forget Password<br> </a>
	        <p class="h6 btn btn-sm btn-danger pupple font-weight-bold" onclick="location.href='memberSignup.jsp'">Sign-Up</p>
    	</div>
	
	
<!-- 	
		<div class="col-md-4 col-md-offset-4">
			<h3 class="form-signin-heading">Please Log in</h3>
			<%--
				// 로그인 실패시 표시되는 내용
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger'>");
					out.println("아이디와 비밀번호를 확인해 주세요");
					out.println("</div>");
				}
			--%>
			<form class="form-signin" action="memberLoginProcess.jsp" method="post">

				<div class="form-group">
					<label for="inputUserName" class="sr-only">User Name</label> 
					<input type="text" class="form-control" placeholder="ID" name='id' required autofocus>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="sr-only">Password</label> <input
						type="password" class="form-control" placeholder="Password"
						name='password' required>
				</div>
				<button class="btn btn btn-lg btn-success btn-block" type="submit">로그인</button>

			</form>
		</div>
		
 -->		
		
		
	</div>
</body>
</html>