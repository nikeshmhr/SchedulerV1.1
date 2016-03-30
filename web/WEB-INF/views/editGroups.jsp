<%-- 
    Document   : editGroups
    Created on : Sep 30, 2015, 7:30:18 PM
    Author     : Nikesh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Edit Groups</title>
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
                <h2 class="text-primary" style="text-align: center">Edit Groups</h2>
                <thead>
                    <tr>
                        <th>Group Code</th>
                        <th>Number Of Students</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="isDataAvailable" value="false" />
                    <c:forEach var="group" items="${groupList}">
                        <c:set var="isDataAvailable" value="true" />
                        <c:set var="groupCode" value="${group.groupCode}" />
                        <tr>
                            <td><c:out value="${groupCode}" /></td>
                            <td><c:out value="${group.noOfStudents}" /></td>
                            <td>
                                <a href="#<c:out value='${groupCode}' />" data-toggle="modal"><span class="glyphicon glyphicon-edit" title="Edit"></span></a> 
                            </td>
                        </tr>
                    <div class="modal fade" tabindex="-1" role="dialog" id="<c:out value='${groupCode}' />">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="<c:url value='/resources/groups/edit' />" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Edit Group</h4>
                                    </div>

                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="groupCode">Group Code</label>
                                            <input type="text" id="groupCode" disabled="true" class="form-control" maxlength="10" value="<c:out value='${groupCode}' />" />
                                            <input type="hidden" name="groupCode" value="<c:out value='${groupCode}' />" />
                                        </div>
                                        <div class="form-group">
                                            <label for="noOfStudents">No. of Students</label>
                                            <input type="number" name="noOfStudents" id="noOfStudents" class="form-control" min="10" max="50" value="<c:out value='${group.noOfStudents}' />" required />
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                        <input type="submit" value="Save changes" class="btn btn-success" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${isDataAvailable eq false}">
                        <tr>
                            <td colspan="3" style="text-align: center;">There are no groups.</td>
                        </tr>
                    </c:if>
                    </tbody>
            </table>
        </div>
        <!-- END OF CONTAINER -->

        <%@include file="/resources/includes/footer.html" %>

    </body>
</html>
