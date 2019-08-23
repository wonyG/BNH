<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="household.Household" %>
<%@ page import="household.HouseholdDAO" %>
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
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int householdID = 0;
		if(request.getParameter("householdID") != null){
			householdID = Integer.parseInt(request.getParameter("householdID"));
		}
		if(householdID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This post is not valid')");
			script.println("location.href = 'household.jsp'");			
			script.println("</script>");	
		}
		Household household = new HouseholdDAO().getHousehold(householdID);
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
				<li><a href="board.jsp">Board</a></li>
				<li class="active"><a href="household.jsp">HouseHold</a></li>
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
	<div class="container">
		<div class="row">
			<form method="post" action="updateHouseholdAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead></thead>
					<tbody>	
					<tr>
						<td>Content</td>
						<td colspan="2"><%= household.getHouseholdContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>Date</td>
						<td colspan="2"><%= household.getHouseholdDate().substring(0,16) %></td>
					</tr>
					<tr>
						<td>In/Out</td>
						<td colspan="2"><% 
							if (household.getHouseholdInOut() == 1) { 
						%>
						Income
						<% 
							} else {
						%>
						Expenditure
						<%
							}
						%>
						</td>
					</tr>
					<tr>
						<td>Price</td>
						<td colspan="2"><%= household.getHouseholdPrice() %></td>			
					</tbody>
				</table>

			</form>
			<a href="household.jsp" class="btn btn-primary">List</a>
			<%
				if(userID != null && userID.equals(household.getUserID())){
			%>
				<a href="updateHousehold.jsp?householdID=<%= householdID %>" class="btn btn-primary">Update</a>
				<a onclick="return confirm('Are you sure you want to delete?')" href="deleteHouseholdAction.jsp?householdID=<%= householdID %>" class="btn btn-primary">Delete</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>