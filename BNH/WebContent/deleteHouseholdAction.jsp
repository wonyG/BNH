<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="household.Household" %>
<%@ page import="household.HouseholdDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>Board And Household</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID= (String)session.getAttribute("userID");
		}		
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('You Do not Logged-in. Please Log-in')");
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
			script.println("location.href = 'household.jsp'");			
			script.println("</script>");	
		}
		Household household = new HouseholdDAO().getHousehold(householdID);
		if(!userID.equals(household.getUserID())){
			if(householdID == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('You Do not have permission')");
				script.println("location.href = 'household.jsp'");			
				script.println("</script>");	
			}			
		}
		else {
			HouseholdDAO householdDAO = new HouseholdDAO();
			int result = householdDAO.delete(householdID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Failure to delete')");
				script.println("history.back()");			
				script.println("</script>");			
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'household.jsp'");
				script.println("</script>");
			}			
		}
	%>
</body>
</html>