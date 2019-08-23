<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="household.HouseholdDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="household" class ="household.Household" scope="page" />
<jsp:setProperty name="household" property="householdInOut" />
<jsp:setProperty name="household" property="householdContent" />
<jsp:setProperty name="household" property="householdPrice" />

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
		else {
			if (household.getHouseholdInOut() == 0 || household.getHouseholdContent() == null || household.getHouseholdPrice() == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Please input all items')");
				script.println("history.back()");			
				script.println("</script>");			
			} 
			else {
				HouseholdDAO householdDAO = new HouseholdDAO();
				int result = householdDAO.write(household.getHouseholdInOut(), userID, household.getHouseholdContent(), household.getHouseholdPrice());
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Failure to write')");
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
		}


	%>
</body>
</html>