<%-- 
    Document   : addTeachers
    Created on : Sep 28, 2015, 9:54:26 PM
    Author     : Nikesh
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Add Teachers</title>
        <script type="text/javascript">
            $(document).ready(function () {
                /** HIGHLIGHTS THE CURRENTLY ACTIVE NAVIGATION **/
                $("#addResource").addClass("active");
            });
            function validateAddTeachers() {
                var values = document.getElementById("teacherName").value;
                if (values.length < 3) {
                    document.getElementById("errorMessage").innerHTML = "Name should be at least 3 characters long";
                    return false;
                }
                var regEx = /[^abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ]/g;
                var result = values.match(regEx);

                if (result.length <= 0) { // VALID
                    return true;
                }
                document.getElementById("errorMessage").innerHTML = "Invalid input. Only use alphabets and spaces.";
                return false;
            }
        </script>
    </head>
    <body>
        <%@include file="/resources/includes/functions.jsp" %>
        <%
            clearBrowsersDefaultCache(response);
        %>

        <%@include file="/resources/includes/navigation.html" %>

        <div class="container">
            <span class="label label-success"><c:out value="${message}" /></span>
            <span class="label label-danger"><c:out value="${errorMessage}" /></span>
            
            <div class="row">
                <!-- TABLE FOR LIST OF TEACHERS -->
                <div class="col-md-5">
                    <table class="table table-striped table-hover table-bordered table-responsive">
                        <h2 class="text-primary">List of Teachers</h2>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="isDataAvailable" value="false" />
                            <c:forEach var="teacher" items="${teacherList}">
                                <c:set var="isDataAvailable" value="true" />
                                <c:set var="teacherId" value="${teacher.teacherId}" />
                                <c:set var="teacherName" value="${teacher.teacherName}" />
                                <tr>
                                    <td><c:out value="${teacherId}" /></td>
                                    <td><c:out value="${teacherName}" /></td>
                                    <s:url value="/resources/teachers/delete/{teacherId}" var="deleteURL" htmlEscape="true">
                                        <s:param name="teacherId" value="${teacherId}" />
                                    </s:url>
                                    <td><a href="${deleteURL}"><span class="glyphicon glyphicon-remove" title="Delete" /></a></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${isDataAvailable eq false}">
                                <tr>
                                    <td colspan="3" align="center">There are no teachers.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- END OF TABLE -->

                
                
                <!-- FORM TO ADD TEACHERS -->
                <div class="col-md-4 col-md-offset-1">
                    <h2 class="text-primary">Add teachers</h2>
                    <form action="<c:url value='/resources/teachers/add' />" method="post" role="form" onsubmit="return validateAddTeachers();">
                        <div class="form-group">
                            <label for="teacherName">Name(s)</label>
                            <input type="text" name="teacherName" id="teacherName" class="form-control" size="3"  required />
                            <span id="errorMessage" class="text-danger"></span>
                        </div>
                        <input type="hidden" name="teacherId" value="TH0" />

                        <div class="">
                            <input type="submit" name="addTeacher" value="Add" class="btn btn-success" />
                        </div>
                    </form>
                </div>
                <!-- END OF FORM -->
            </div>
            <!-- END OF ROW -->
        </div>
        <!-- END OF CONTAINER -->

        <!-- A FOOTER -->
        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
