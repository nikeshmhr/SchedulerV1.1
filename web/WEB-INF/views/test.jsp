<%-- 
    Document   : test
    Created on : Mar 14, 2016, 1:25:17 PM
    Author     : Nikesh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        USER ID: <c:out value="${sessionConfig.userId}" /><br/> 
        USERNAME: ${login.username}
    </body>
</html>
