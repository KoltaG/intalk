<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : main
    Created on : 2020.12.07., 15:38:20
    Author     : User
--%>

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
        <c:if test="${felha.rank==0}">
            <c:set var="rang" value="felhasználó"/>
        </c:if>
        <c:if test="${felha.rank==1}">
            <c:set var="rang" value="moderátor"/>
        </c:if>
        <c:if test="${felha.rank==2}">
            <c:set var="rang" value="adminisztrátor"/>
        </c:if>
    </c:forEach>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Főoldal</title>
    </head>
    <body>
        <h1>Üdvözlöm, <%= session.getAttribute("validuser") %>!</h1>
        <h3><b>Rangod az oldalon: </b>${rang}</h3>
        <hr>
        <form action="check.jsp" method="POST">
            <input type="submit" name="logout" value="Logout">
            <input type="submit" name="newpost" value="Új poszt">
            <c:if test="${rang == 'adminisztrátor'}">
                <input type="submit" value="Admin oldal" name="admin">        
            </c:if>
            <c:if test="${!empty param.errorMsg}">
            <p><font color="red">${param.errorMsg}</font></p>
            </c:if>
            <c:if test="${!empty param.succMsg}">
            <p><font color="green">${param.succMsg}</font></p>
            </c:if>
            <hr>
        </form>
        <sql:query var="posztok" dataSource="${felhasznalok}">
            SELECT * FROM post ORDER BY created_time DESC
        </sql:query>
        <c:forEach var="poszt" items="${posztok.rows}">
            <table>
                <tr>
                    <td>PostID: ${poszt.post_id}</td><td>Created by: ${poszt.author}</td><td>at ${poszt.created_time}</td>
                </tr>
                <tr>
                    <td colspan="3">${poszt.post}</td>
                </tr>
                        
                        <c:if test="${rang != 'felhasználó' || user == poszt.author}">
                    <tr><td>
                    <form action="check.jsp" method="POST">
                        <input type="hidden" value="${poszt.post_id}" name="postid">
                        <input type="submit" value="Szerkesztés" name="edit">
                        <input type="submit" value="Törlés" name="delete">
                    </form>    
                    </td></tr>
                    </c:if>
            </table>
            <hr align="left" width="50%">
        </c:forEach>
    </body>
</html>
<% } else { %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük, jelentkezzen be!"/>
</jsp:forward>
<% } %>
