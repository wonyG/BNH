<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
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
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('you must be log-in')");
			script.println("location.href = 'login.jsp'");			
			script.println("</script>");
		}
		int boardID = 0;
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This post is not valid')");
			script.println("location.href = 'board.jsp'");			
			script.println("</script>");	
		}
		Board board = new BoardDAO().getBoard(boardID);
		if(!userID.equals(board.getUserID())){
			if(boardID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('You Do not have permission')");
				script.println("location.href = 'board.jsp'");			
				script.println("</script>");	
			}			
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Board And Household</a>				
		</div>
		<div class="collapse navbar-collapse" id="bs-exapple-navber-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">Main</a></li>
				<li class="active"><a href="board.jsp">Board</a></li>
				<li><a href="household.jsp">HouseHold</a></li>
			</ul>
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
		</div>
	</nav>
	<div class="container">
		<div class="row">
		<form method="post" action="updateAction.jsp?boardID=<%= boardID %>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">Board Change Form</th>																		
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="Title" name="boardTitle" maxlength="50" value="<%= board.getBoardTitle()%>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="Content" name="boardContent" maxlength="10000" style="height: 350px"><%= board.getBoardContent()%></textarea></td>
					</tr>				
				</tbody>
			</table>
			<input type="submit" href="write.jsp" class="btn btn-primary pull-right" value="Change">
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>