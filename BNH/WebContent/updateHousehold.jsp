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
		int householdID = 0;
		if(request.getParameter("householdID") != null){
			householdID = Integer.parseInt(request.getParameter("householdID"));
		}
		if(householdID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('This post is not valid')");
			script.println("location.href = 'board.jsp'");			
			script.println("</script>");	
		}
		Household household = new HouseholdDAO().getHousehold(householdID);
		if(!userID.equals(household.getUserID())){
			if(householdID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('You Do not have permission')");
				script.println("location.href = 'board.jsp'");			
				script.println("</script>");	
			}			
		}
		
		String buttonCheckIn = null;
		String buttonCheckOut = null;
		if(household.getHouseholdInOut() == 1){
			buttonCheckIn = "active";
		}
		else{
			buttonCheckOut = "active";
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
				<li><a href="board.jsp">Board</a></li>
				<li class="active"><a href="household.jsp">HouseHold</a></li>
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
		<form method="post" action="updateHouseholdAction.jsp?householdID=<%= householdID %>">
			<div class="btn-group" data-toggle="buttons">						
				<label class="btn btn-primary <%= buttonCheckIn %>">
					<input type="radio" placeholder="In" value=1 name="householdInOut" id = "householdInOut1">In
				</label>
				<label class="btn btn-primary <%= buttonCheckOut %>">
					<input type="radio" placeholder="Out" value=2 name="householdInOut" id = "householdInOut2">Out
				</label>
			</div>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead></thead>
				<tbody>	
					<tr>
						<td><input type="text" class="form-control" name="householdContent" value="<%= household.getHouseholdContent() %>"></td>
					</tr>
					<tr>
						<td><input type="number" class="form-control" name="householdPrice" value="<%= household.getHouseholdPrice() %>"></td>
					</tr>				
				</tbody>
			</table>
			<input type="submit" href="updateHousehold.jsp" class="btn btn-primary pull-right" value="Change">
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>