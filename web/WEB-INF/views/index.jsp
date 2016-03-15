<%-- 
    Document   : index
    Created on : Sep 27, 2015, 6:44:19 PM
    Author     : Nikesh
--%>
<%@page import="com.scheduler.config.SessionConfig"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>


        <title>Scheduler</title>
    </head>
    <body>
        User id is: <c:out value="${sessionConfig.userId}" />
        <div class="container">          
            <%
                response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
                response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
                response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
                response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
            %>


            <%                
                String message = "";
                message = (String) request.getAttribute("message");
                if (message == null) {
                    message = "";
                }
            %>

            <%
                if (request.getParameter("v") != null) {
                    session.invalidate();
                }
            %>

            <a href="?v=true">Destroy</a>
            <!-- LOGIN FROM STARTS FROM HERE -->
            <div class="col-md-5 well col-md-offset-3 col-sm-5 col-sm-offset-3" style="margin-top: 2%">
                <form action="" method="post" role="form" style="padding: 20px;">

                    <h1 class="caption" style="text-align: center">Login</h1>
                    <div class="row">
                        <div class="col-md-12 form-group input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                            <input type="text" name="username" placeholder="Username" required class="form-control input-lg" />
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-12 form-group input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="password" name="password" placeholder="Password" required class="form-control input-lg" />
                        </div>
                    </div>
                    <div class="row">
                        <label id="message" class="text-danger col-md-12">${incorrect}</label>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <input type="submit" name="login" value="Login" class="btn btn-success form-control" />
                        </div>
                    </div>

                </form>
            </div>
            <!-- LOGIN FORM ENDS HERE -->
        </div>
    </body>
</html>
