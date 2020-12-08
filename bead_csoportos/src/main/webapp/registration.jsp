<%-- Document : registration Created on : 2020. dec. 6., 19:49:36 Author : 19kab
--%> <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@taglib
prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Regisztráció</title>
     <link rel="stylesheet" href="css/bootstrap.min.css" />
  </head>
 <body style="height: 100vh" class="d-flex">
    <div class="container mt-5 w-50 m-auto card p-4">
      <h1 class="text-center">Regisztráció</h1>
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
                value="Regisztráció"
                name="register"
              />
            </div>
          </div>
        </form>

        <hr width="50%"  />
        <a href="login.jsp">Vissza a bejelentkezéshez</a>
        <c:if test="${!empty param.errorMsg}">
           <p class="text-danger">${param.errorMsg}</p>
        </c:if>
      </div>
    </div>
  </body>
</html>
