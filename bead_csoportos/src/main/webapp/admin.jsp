<%-- 
    Document   : admin
    Created on : 2020. dec. 7., 22:04:51
    Author     : Dávid
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<% if (session.getAttribute("validuser")!=null) {
String user = session.getAttribute("validuser").toString(); 
%>
<c:set var="user" value="<%= user %>"/>
<sql:query var="felh" dataSource="${felhasznalok}">
    SELECT * FROM users WHERE username='<%= user %>'
</sql:query>
    <c:forEach var="felha" items="${felh.rows}">
        <c:if test="${felha.rank<2}">
            <jsp:forward page="main.jsp">
                <jsp:param name="errorMsg" value="Ennek a lapnak a megtekintéséhez nincs jogosultsága!"/>
            </jsp:forward>
        </c:if>
    </c:forEach>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css" />
    </head>
    <body style="background-color:burlywood">
        <div class="container mt-5">
        <h1>Üdvözlöm, Admin <%= session.getAttribute("validuser") %>!</h1>
        <hr>
        <form action="check.jsp" method="POST">
           
            <input class=" btn btn-primary" type="submit" name="back" value="Vissza a főoldalra"> 
             <input class=" btn btn-danger float-right" type="submit" name="logout" value="Logout">
            <c:if test="${!empty param.errorMsg}">
            <p class="text-danger">${param.errorMsg}</p>
            </c:if>
            <c:if test="${!empty param.succMsg}">
            <p class="text-success">${param.succMsg}</p>
            </c:if>
            <hr>
        </form>

        <sql:query dataSource="${felhasznalok}" var="users1">
            SELECT * FROM USERS ORDER BY rank DESC, username ASC
        </sql:query>
        <table>
            <tr> 
                <td><b>Felhasználó név</b></td>
                <td><b>Jelszó</b></td>
                <td><b>Rank</b></td>
            </tr>
            <c:forEach var="row" items="${users1.rows}">
                <form action="check.jsp" method="POST"> 
                    <tr>
                        <td> <c:out value = "${row.username}"/></td>
                        <td> <c:out value = "${row.password}"/></td>
                        <td> <c:choose>
                                <c:when test="${row.rank == 0}">
                                    <c:out value = "felhasználó"/>
                                </c:when>
                                <c:when test="${row.rank == 1}">
                                    <c:out value = "moderátor"/>
                                </c:when>
                                <c:when test="${row.rank == 2}">
                                    <c:out value = "adminisztrátor"/>
                                </c:when>
                            </c:choose>
                        </td>
                        <input type="hidden" name="user_id_del" value="${row.id}">
                        <td class="pl-2"> <input class=" btn btn-danger" type="submit" name="delete_user" value="Felhasználó törlése"> </td>
                </form>
                        <form action="admin.jsp" method="POST">
                            <input type="hidden" name="user_id_del" value="${row.id}">
                            <input type="hidden" name="user_name_del" value="${row.username}">
                            <input type="hidden" name="user_password_del" value="${row.password}">
                            <input type="hidden" name="user_rank_del" value="${row.rank}">
                            <td> <input class=" btn btn-primary" type="submit" name="edit_user" value="Felhasználó módosítása"> </td>
                        </form>
                    </tr>
            </c:forEach>
        </table>

        <h2>Felhasználó felvétele</h2>
        <form action="check.jsp" method="POST">
            <table class="">
                <tr>
                    <td>Felhasználónév: </td>
                    <td><input class="form-control" type="text" name="username"></td>
                </tr>
                <tr>
                    <td>Jelszó:</td>
                    <td><input class="form-control"  type="password" name="password"></td>
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
                       <input class=" btn btn-success" type="submit" name="register_user" value="Regisztrálás">
                    </td>
                </tr>
            </table>    
        </form>
        
        <c:if test="${!empty param.edit_user}">
            <hr align="left" width="50%">
            <h2>Felhasználó módosítása</h2>
            <table>
            <form action="check.jsp" method="POST">
                <tr><td>
                        Felhasználónév: <input class="form-control" name="username" value="${param.user_name_del}"></td></tr>
                <tr><td>
                Jelszó: <input class="form-control" type="text" name="password" value="${param.user_password_del}"></td></tr>
                <c:choose>
                    <c:when test="${param.user_rank_del == 0}">
                        <tr><td>
                        Jogosultság: <input type="radio" name="rang" id="felh2" value="0" checked="true"> <label for="felh2">Felhasználó </label>
                        <input type="radio" name="rang" id="mod2" value="1"> <label for="mod2">Moderátor </label>
                        <input type="radio" name="rang" id="adm2" value="2"> <label for="adm2">Admin </label>
                        </td></tr>
                    </c:when>
                    <c:when test="${param.user_rank_del == 1}">
                        <tr><td>
                        Jogosultság: <input type="radio" name="rang" id="felh2" value="0"> <label for="felh2">Felhasználó </label>
                        <input type="radio" name="rang" id="mod2" value="1"  checked="true"> <label for="mod2">Moderátor </label>
                        <input type="radio" name="rang" id="adm2" value="2"> <label for="adm2">Admin </label>
                        </td></tr>
                    </c:when>
                    <c:when test="${param.user_rank_del == 2}">
                        <tr><td>
                        Jogosultság: <input type="radio" name="rang" id="felh2" value="0"> <label for="felh2">Felhasználó </label>
                        <input type="radio" name="rang" id="mod2" value="1"> <label for="mod2">Moderátor </label>
                        <input type="radio" name="rang" id="adm2" value="2"  checked="true"> <label for="adm2">Admin </label>
                        </td></tr>
                    </c:when>
                </c:choose>
                        <input type="hidden" name="userid" value="${param.user_id_del}">
                        <tr><td><input class=" btn btn-success" type="submit" name="edit_user" value="Adatok módosítása">
            </form>
            </table>
        </c:if>
            </div>
    </body>
</html>
<% } else { %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük, jelentkezzen be!"/>
</jsp:forward>
<% } %>