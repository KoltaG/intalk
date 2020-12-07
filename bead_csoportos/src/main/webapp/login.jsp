<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : login
    Created on : 2020. dec. 6., 19:47:07
    Author     : 19kab
--%>
<sql:setDataSource var="felhasznalok"
                   driver="org.apache.derby.jdbc.ClientDriver"
                   url="jdbc:derby://localhost:1527/users"
                   user="teszt"
                   password="teszt"
                   scope="session"/>
<!--sql:setDataSource var="szerda"
                   driver="net.ucanaccess.jdbc.UcanaccessDriver"
                   url="jdbc:ucanaccess://C:/Users/User/Documents/users.accdb"
                   user=""
                   password=""
                   scope="application"/-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bejelentkezés</title>
    </head>
    <body>
        <h1>Üdvözöljük! Kérjük jelentkezzen be!</h1>

        <form action="check.jsp" method="POST">
        <table>
            <tr><td>Felhasználó név: </td><td><input type="text" name="username"></td></tr>
            <tr><td>Jelszó: </td><td><input type="password" name="password"></td></tr>
        </table>
        <input type="submit" value="Bejelentkezés" name="login" /><p/>
        </form>
        <hr width="50%" align="left">
        <a href="registration.jsp">Regisztráció</a>
      <c:if test="${empty felhasznalok}">
          <p><font color="red">Kérjük ellenőrizze az AB kapcsolatot!</font></p>
      </c:if>
      <c:if test="${!empty param.errorMsg}">
            <p><font color="red">${param.errorMsg}</font></p>
      </c:if>
      <c:if test="${!empty param.succMsg}">
            <p><font color="green">${param.succMsg}</font></p>
      </c:if>
    </body>
</html>
