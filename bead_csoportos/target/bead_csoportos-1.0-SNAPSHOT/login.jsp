<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%> <%-- Document : login
Created on : 2020. dec. 6., 19:47:07 Author : 19kab --%>
<sql:setDataSource
  var="felhasznalok"
  driver="org.apache.derby.jdbc.ClientDriver"
  url="jdbc:derby://localhost:1527/users"
  user="teszt"
  password="teszt"
  scope="session"
/>
<!--sql:setDataSource var="szerda"
                   driver="net.ucanaccess.jdbc.UcanaccessDriver"
                   url="jdbc:ucanaccess://C:/Users/User/Documents/users.accdb"
                   user=""
                   password=""
                   scope="application"/-->

<%@page contentType="text/html" pageEncoding="UTF-8"%> <%
request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Bejelentkezés</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" />
  </head>
  <body style="height: 100vh" class="d-flex">
    <div class="container mt-5 w-50 m-auto card p-4">
      <h1 class="text-center">Üdvözöljük! <br />Kérjük jelentkezzen be!</h1>
      <div class="d-flex flex-column align-items-center">
        <form class="pl-3" action="check.jsp" method="POST">
          <div class="row">
            <div classs="col-6">
              <label
                >Felhasználó név:
                <input class="form-control" type="text" name="username"
              /></label>
            </div>
          </div>
          <div class="row">
            <div classs="col-6">
              <label
                >Jelszó:
                <input class="form-control" type="password" name="password"
              /></label>
            </div>
          </div>
          <div class="row">
            <div class="col-12 p-0 mt-2">
              <input
                class="btn btn-primary text-center w-100"
                type="submit"
                value="Bejelentkezés"
                name="login"
              />
            </div>
          </div>
        </form>
        <hr width="50%" />
        <a href="registration.jsp">Regisztráció</a>
        <c:if test="${empty felhasznalok}">
          <p class="text-danger">Kérjük ellenőrizze az AB kapcsolatot!</p>
        </c:if>
        <c:if test="${!empty param.errorMsg}">
          <p class="text-danger">${param.errorMsg}</p>
        </c:if>
        <c:if test="${!empty param.succMsg}">
          <p class="text-success">${param.succMsg}</p>
        </c:if>
      </div>
    </div>
  </body>
</html>
