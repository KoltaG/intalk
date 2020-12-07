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
    </head>
    <body>
        <h1>Üdvözlöm, <%= session.getAttribute("validuser") %>!</h1>
        <form action="check.jsp" method="POST">
            <input type="submit" name="logout" value="Logout">
            <input type="submit" name="back" value="Vissza a főoldalra"> 
        </form>
        <hr width="50%" align="left">
        <form action="check.jsp" method="POST">
            <table>
                <tr><td>
            <textarea name="post" cols="50" rows="30"></textarea>
                    </td></tr><tr><td>
            <input type="submit" name="create_post" value="Poszt létrehozása">
                    </td></tr>
            </table>
        </form>
        <hr width="50%" align="left">
        <c:if test="${!empty param.errorMsg}">
            <p><font color="red">${param.errorMsg}</font></p>
        </c:if>
    </body>
</html>
<% } else { %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük, jelentkezzen be!"/>
</jsp:forward>
<% } %>
