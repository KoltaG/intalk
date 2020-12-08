<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : newpost
    Created on : 2020.12.07., 17:26:51
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<% if (session.getAttribute("validuser")!=null) { %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Új poszt létrehozása</title>
         <link rel="stylesheet" href="css/bootstrap.min.css" />
    </head>
    <body style="background-color:burlywood">
        <div class="container mt-5">
        <h1>Üdvözlöm, <%= session.getAttribute("validuser") %>!</h1>
        <form action="check.jsp" method="POST">
             <input class=" btn btn-primary" type="submit" name="back" value="Vissza a főoldalra"> 
             <input class=" btn btn-danger float-right" type="submit" name="logout" value="Logout">
        </form>
        <hr width="100%">
        <form action="check.jsp" method="POST">
            
              
            <textarea class="form-control" name="post" cols="50" rows="20" ></textarea>
                 
                        <input class=" btn btn-success mt-5" type="submit" name="create_post" value="Poszt létrehozása">
                 
           
        </form>
 <hr width="100%">
        <c:if test="${!empty param.errorMsg}">
            
            <p class="text-danger">${param.errorMsg}</p>
        </c:if>
            </div>
    </body>
</html>
<% } else { %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük, jelentkezzen be!"/>
</jsp:forward>
<% } %>
