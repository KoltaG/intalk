<%-- 
    Document   : admin
    Created on : 2020. dec. 7., 22:04:51
    Author     : Dávid
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin page</title>
    </head>
    <body>
        
        <h1>Üdvözlöm, Admin <%= session.getAttribute("validuser") %>!</h1>
        <hr>
        <form action="check.jsp" method="POST">
            <input type="submit" name="logout" value="Logout">
            <input type="submit" name="back" value="Vissza a főoldalra"> 
            <c:if test="${!empty param.errorMsg}">
            <p><font color="red">${param.errorMsg}</font></p>
            </c:if>
            <c:if test="${!empty param.succMsg}">
            <p><font color="green">${param.succMsg}</font></p>
            </c:if>
            <hr>
        </form>

        <sql:query dataSource="${felhasznalok}" var="users1">
            SELECT * FROM USERS
        </sql:query>
        <table>
            <tr> 
                <td>Felhasználó név: </td>
                <td>Jelszó: </td>
                <td>Rank: </td>
            </tr>
            <c:forEach var="row" items="${users1.rows}">
                <form action="check.jsp" method="POST"> 
                    <tr>
                        <td> <c:out value = "${row.username}"/></td>
                        <td> <c:out value = "${row.password}"/></td>
                        <td> <c:out value = "${row.rank}"/></td>
                        <input type="hidden" name="user_id_del" value="${row.id}">
                        <td> <input type="submit" name="delete_user" value="Felhasználó törlése"> </td>
                    </tr>
                </form>
            </c:forEach>
        </table>

        <h2>Felhasználó felvétele</h2>
        <form action="check.jsp" method="POST">
            <table>
                <tr>
                    <td>Felhasználónév: </td>
                    <td><input type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Jelszó:</td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td>Jogosultság:  </td>
                    <td><input type="radio" name="rang" id="felh" value="0" checked="true"> <label for="felh">Felhasználó </label>
                        <input type="radio" name="rang" id="mod" value="1"> <label for="mod">Moderátor </label>
                        <input type="radio" name="rang" id="adm" value="2"> <label for="adm">Admin </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" name="register_user" value="Regisztrálás">
                    </td>
                </tr>
            </table>    
        </form>
    </body>
</html>
