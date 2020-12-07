<%-- 
    Document   : check
    Created on : 2020. dec. 6., 20:25:44
    Author     : 19kab
--%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <c:choose>
        <c:when test="${!empty param.login}">
            <% session.setAttribute("validuser", null);%>
            <c:choose>
                <c:when test="${(empty param.username) || (empty param.password)}">
                    <jsp:forward page="login.jsp">
                        <jsp:param name="errorMsg" value=" Az e-mail és jelszó megadása kötelező!"/>       
                    </jsp:forward>
                </c:when>
                <c:otherwise>
                    <sql:query var="eredmeny" dataSource="${felhasznalok}">
                        SELECT * FROM users WHERE username='${param.username}' and password ='${param.password}'
                    </sql:query>
                        <c:choose>
                            <c:when test="${eredmeny.rowCount ==1}">
                                <%session.setAttribute("validuser", request.getParameter("username"));%>
                                <jsp:forward page="main.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <jsp:forward page="login.jsp">
                                    <jsp:param name="errorMsg" value="Rossz jelszó vagy felhasználónév!"/>       
                                </jsp:forward> 
                            </c:otherwise>
                        </c:choose>

                </c:otherwise>
            </c:choose>

        </c:when>
        <c:when test="${!empty param.register}">
            <c:choose>
                <c:when test="${empty param.username || empty param.password}">
                    <jsp:forward page="registration.jsp">
                        <jsp:param name="errorMsg" value="Felhasználó név és jelszó megadása kötelező!"/>
                    </jsp:forward>
                </c:when>
                <c:otherwise>
                    <sql:update var="eredmeny" dataSource="${felhasznalok}">
                        INSERT INTO users (username, password)
                        VALUES ('${param.username}', '${param.password}')
                    </sql:update>
                        <jsp:forward page="login.jsp">
                            <jsp:param name="succMsg" value="Sikeresen regisztráltál!" />
                        </jsp:forward>
                </c:otherwise>
            </c:choose>
               
        </c:when>
        <c:when test="${!empty param.admin}">
            <jsp:forward page="admin.jsp"/>
        </c:when>
        <c:when test="${!empty param.delete_user}">
            <%String user_id_del = request.getParameter("user_id_del");%>
            <sql:update var="eredmeny" dataSource="${felhasznalok}">
                DELETE FROM users
                WHERE id = <%= user_id_del %>
            </sql:update>
            <jsp:forward page="admin.jsp">
                <jsp:param name="succMsg" value="Felhasználó sikeresen törölve!"/>
            </jsp:forward>
            
        </c:when>
        <c:when test="${!empty param.register_user}">
            <c:choose>
                <c:when test="${empty param.username || empty param.password}">
                    <jsp:forward page="admin.jsp">
                        <jsp:param name="errorMsg" value="Felhasználó név és jelszó megadása kötelező!"/>
                    </jsp:forward>
                </c:when>
                <c:otherwise>
                    <sql:update var="hozzaad" dataSource="${felhasznalok}">
                        INSERT INTO users (username, password, rank)
                        VALUES ('${param.username}', '${param.password}', ${param.rang})
                    </sql:update>
                        <jsp:forward page="admin.jsp">
                            <jsp:param name="succMsg" value="Felhasználó sikeresen hozzáadva!"/>
                        </jsp:forward>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:when test="${!empty param.logout}">
        <% session.invalidate(); %>
        <jsp:forward page="login.jsp">
            <jsp:param name="succMsg" value="Sikeresen kijelentkeztél."/>
        </jsp:forward>
        </c:when>
        <c:when test="${!empty param.back}">
        <jsp:forward page="main.jsp"/>
        </c:when>   
        <c:when test="${!empty param.delete}">
           <%int id = Integer.parseInt(request.getParameter("postid"));%>
            <sql:update var="eredmeny" dataSource="${felhasznalok}">
                DELETE FROM post
                WHERE post_id = <%= id %>
            </sql:update>
            <jsp:forward page="main.jsp">
                <jsp:param name="succMsg" value="Poszt sikeresen törölve!"/>
            </jsp:forward>
        </c:when>
        <c:when test="${!empty param.edit}">
            <%int id2 = Integer.parseInt(request.getParameter("postid"));%>
            <jsp:forward page="editpost.jsp">
               <jsp:param name="postid" value="<%= id2 %>"/>
            </jsp:forward>
        </c:when>
        <c:when test="${!empty param.edit_post}">
            <%int id3 = Integer.parseInt(request.getParameter("postid"));%>
            <sql:update var="eredmeny" dataSource="${felhasznalok}">
                UPDATE post
                SET post = '${param.post}'
                WHERE post_id = <%= id3 %>
            </sql:update>
            
            <jsp:forward page="main.jsp">
                <jsp:param name="succMsg" value="Sikeresen módosítottad a posztod."/>
            </jsp:forward>
        </c:when>
        <c:when test="${!empty param.create_post}">
            <c:choose>
                <c:when test="${!empty param.post}">
                    <sql:update var="eredmeny" dataSource="${felhasznalok}">
                        INSERT INTO post (author, post)
                        VALUES ('<%= session.getAttribute("validuser") %>', '${param.post}')
                    </sql:update>
                    <jsp:forward page="main.jsp">
                        <jsp:param name="succMsg" value="Poszt sikeresen elküldve!"/>
                    </jsp:forward>
                </c:when>
                <c:otherwise>
                    <jsp:forward page="newpost.jsp">
                        <jsp:param name="errorMsg" value="Nem adott meg szöveget a poszthoz!"/>
                    </jsp:forward>
                </c:otherwise>
            </c:choose>

        </c:when>
                        
        <c:when test="${!empty param.newpost}">
        <jsp:forward page="newpost.jsp"/>
        </c:when>             
        <c:otherwise>
            <jsp:forward page="login.jsp"/>
        </c:otherwise>
    </c:choose>

</html>
