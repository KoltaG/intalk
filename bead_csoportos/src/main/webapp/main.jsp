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
         <link rel="stylesheet" href="css/bootstrap.min.css" />
    </head>
    <body style="background-color:burlywood">
        <div class="container">
        <h1>Üdvözlöm, <%= session.getAttribute("validuser") %>!</h1>
        <h3><b>Rangod az oldalon: </b>${rang}</h3>
        <hr>
    
        <form action="check.jsp" method="POST">
            
            <input class=" btn btn-success" type="submit" name="newpost" value="Új poszt">
            <c:if test="${rang == 'adminisztrátor'}">
                <input class=" btn btn-primary" type="submit" value="Admin oldal" name="admin">        
            </c:if>
                <input class=" btn btn-danger float-right" type="submit" name="logout" value="Logout">
            <c:if test="${!empty param.errorMsg}">
            <p class="text-danger mt-2">${param.errorMsg}</p>
            </c:if>
            <c:if test="${!empty param.succMsg}">
             <p class="text-success mt-2">${param.succMsg}</p>
            </c:if>
            <hr>
        </form>
        <sql:query var="posztok" dataSource="${felhasznalok}">
            SELECT * FROM post ORDER BY created_time DESC
        </sql:query>
        <c:forEach var="poszt" items="${posztok.rows}">
           <div style="border-bottom: 2px solid black" class="py-3">
                
                <div class="row">
                    <div class="col-12">${poszt.post}</div>
                </div>
                        <div class="row mt-3">
                    <!-- <div class="col-6">${poszt.post_id}</div> -->
                            <div class="col-6"><p>Created by: ${poszt.author}<br>at ${poszt.created_time}</p></div>
                </div>
                        <c:if test="${rang != 'felhasználó' || user == poszt.author}">
                    <div class="row"><div class="col-6">
                    <form action="check.jsp" method="POST">
                        <input type="hidden" value="${poszt.post_id}" name="postid">
                        <input class=" btn btn-primary" type="submit" value="Szerkesztés" name="edit">
                        <input class=" btn btn-danger" type="submit" value="Törlés" name="delete">
                    </form>    
                    </div>
                </div>
                    </c:if>
            </div>
           
        </c:forEach>
                </div>
    </body>
</html>
<% } else { %>
<jsp:forward page="login.jsp">
    <jsp:param name="errorMsg" value="Kérjük, jelentkezzen be!"/>
</jsp:forward>
<% } %>
