<%-- 
    Document   : registration
    Created on : 2020. dec. 6., 19:49:36
    Author     : 19kab
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Regisztráció</title>
    </head>
    <body>
            <h1>Regisztráció</h1>
            <table>
            <form action="check.jsp" method="POST">
                <tr><td>Felhasználó név: </td><td><input type="text" name="username"></td></tr>
                <tr><td>Jelszó: </td><td><input type="password" name="password"></td></tr>
            </table>
                <input type="submit" value="Regisztráció" name="register"/><p/>
            </form>
            <hr width="50%" align="left">    
            <a href="login.jsp">Vissza a bejelentkezéshez</a>
            <c:if test="${!empty param.errorMsg}">
            <p><font color="red">${param.errorMsg}</font></p>
            </c:if>
    </body>
</html>
