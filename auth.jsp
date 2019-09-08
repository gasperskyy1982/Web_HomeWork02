<%@ include file = "includes/header.jsp" %>
<%@ page import = "ua.itea.homework4.AuthController" %>
<%@ page import = "java.util.Date" %>

<%! int tryCounter=0; %>
<%! long failTime=0; %>

<%
String login = request.getParameter("Login");
String password = request.getParameter("Password");
boolean showForm = true;
String message = "<div style = 'color:red;'> Acess denided </div>";   
if(login!=null && password != null) {
 if (new AuthController().getLogin(login, password)) {
	message = "<div style = 'color:green;'> Acess granted </div>"; 
	tryCounter=0;
	showForm = false;
 } else {
	    tryCounter++; 
		if (tryCounter>=3) {
			showForm = false;
			if (failTime==0) {
				failTime=new Date().getTime();
			} else {
				long curTime = ((failTime + 60000) - new Date().getTime())/1000;
					if (curTime<0) {
						tryCounter=0;
						failTime=0;
						showForm=true;
					} else {
						out.write("<br/> Time Left: 00:" + curTime);
					}
			}
		} else {
		out.write("<br/> Try: " + tryCounter);
		}
  }	
  out.write(message);
}

	
//-----------------------------------------------
if (showForm) {
%>

<form action = "auth.jsp">
	<table align = "center">

	<tr>
	<td> 
	</td>
	</tr>

	<tr> 
		<td> LOGIN </td>
		<td> <input type = "text" name = "Login"/> </td>
	</tr>
	<tr> 
		<td> PASSWORD </td>
		<td> <input type = "text" name = "Password"/> </td>
	</tr>
	<tr>
		<td align = "right">
		<input type = "submit" value = "OK"/>
		</td>
	</tr>
	</table>
</form>

<% }%> 
	