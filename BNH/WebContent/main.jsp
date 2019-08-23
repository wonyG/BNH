<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>Board And Household</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}	
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle"
				data-toggle="collapse" data-target="#collapsibleNavbar"
				aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Board And Household</a>				
		</div>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">Main</a></li>
				<li><a href="board.jsp">Board</a></li>
				<li><a href="household.jsp">HouseHold</a></li>
			</ul>
			<%
				if(userID == null){			
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Sign in<span class="carat"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">login</a></li>
						<li><a href="join.jsp">create account</a></li>
					</ul>
				<li/>
			</ul>			
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Sign out<span class="carat"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">logout</a></li>
					</ul>
				<li/>
			</ul>				
			<%
				}
			%>
		</div>
	</nav>
	<div class ="container">
		<div class ="jumbotron">
			<div class ="container">
				<h1>웹 사이트 소개</h1>
				<p>이 사이트는 JSP, Java, Mysql을 사용해서 만든 웹 사이트입니다. 디자인 템플릿은 bootstrap을 사용했습니다. 이 프로젝트는 개인 프로젝트입니다. </p>
				<p>개발 환경은 이클립스 Jee 2019-06, mysql 8.0.17을 사용했으며, 개발 목적은 일기또는 메모와 가계부를 한번에 사용할 수 있도록 하기위해 만든 웹사이트 입니다.</p>
				<p><a class="btn btn-primary btn-pull" href="mainjp.jsp" role="button">日本語で説明をみる</a></p>
				<p><a class="btn btn-primary btn-pull" href="https://github.com/wonyG/BNH" role="button">github에서 소스코드 보기</a></p>
			</div>
		</div>
	</div>
		
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>