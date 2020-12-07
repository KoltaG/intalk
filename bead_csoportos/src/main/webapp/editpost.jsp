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
        <title>Poszt módosítása</title>
    </head>
    <body>
        <h1>Üdvözlöm, <%= session.getAttribute("validuser") %>!</h1>
        <form action="check.jsp" method="POST">
            <input type="submit" name="logout" value="Logout">
            <input type="submit" name="back" value="Vissza a főoldalra"> 
        </form>
        <hr width="50%" align="left">
        
        <sql:query var="posztok" dataSource="${felhasznalok}">
            SELECT * FROM post WHERE post_id=${param.postid}
        </sql:query>
            <c:forEach var="poszt" items="${posztok.rows}">

            <form action="check.jsp" method="POST">
            <table>
                <tr><td>
            <textarea name="post" cols="50" rows="30" >${poszt.post}</textarea>
                    </td></tr><tr><td>
            <input type="hidden" name="postid" value="${param.postid}">
            <input type="submit" name="edit_post" value="Poszt módosítása">
                    </td></tr>
            </table>
        </form>
            </c:forEach>
       
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
