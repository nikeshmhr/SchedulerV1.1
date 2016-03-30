<%-- 
    Document   : editTeachers
    Created on : Sep 30, 2015, 7:14:24 PM
    Author     : Nikesh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Edit Teachers</title>
        <script>
            $(document).ready(function () {
                $("#editResource").addClass("active");
            });
        </script>
    </head>
    <body>
        <%@include file="/resources/includes/functions.jsp" %>
        <%
            clearBrowsersDefaultCache(response);
        %>
        <div class="container">
            <%@include file="/resources/includes/navigation.html" %>

            <span class="label label-success"><c:out value="${message}" /></span>
            <span class="label label-danger"><c:out value="${errorMessage}" /></span>

            <table class="table table-striped">
                <h2 class="text-primary" style="text-align: center">Edit Teachers</h2>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="isDataAvailable" value="false" />
                    <c:forEach items="${teacherList}" var="teacher">
                        <c:set var="teacherId" value="${teacher.teacherId}" />
                        <c:set var="isDataAvailable" value="true" />
                        <tr>
                            <td><c:out value="${teacherId}" /></td>
                            <td><c:out value="${teacher.teacherName}" /></td>
                            <td>
                                <a href="#<c:out value='${teacherId}' />" data-toggle="modal"><span class="glyphicon glyphicon-edit" title="Edit"></span></a>
                            </td>
                        </tr>
                    <div class="modal fade" tabindex="-1" role="dialog" id="<c:out value='${teacherId}' />">
                        <div class="modal-dialog">
                            <c:url var="formSubmit" value="/resources/teachers/edit" />

                            <div class="modal-content">

                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">Edit Teacher</h4>
                                </div>
                                <form action="${formSubmit}" method="post">
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="teacherId">ID</label>
                                            <input type="text" disabled="true" id="teacherId" class="form-control" maxlength="10" value="<c:out value='${teacherId}' />" required />
                                            <input type="hidden" name="teacherId" value="<c:out value='${teacherId}' />" />
                                        </div>

                                        <div class="form-group">
                                            <label for="teacherName">Name</label>
                                            <input type="text" name="teacherName" id="teacherName" class="form-control" maxlength="50" value="<c:out value='${teacher.teacherName}' />" required />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                        <input type="submit" value="Save changes" class="btn btn-success" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${isDataAvailable eq false}">
                    <tr>
                        <td colspan="3" style="text-align: center;">There are no teachers.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <!-- END OF CONTAINER -->

        <!-- A FOOTER -->
        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
