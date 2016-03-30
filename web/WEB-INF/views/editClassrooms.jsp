<%-- 
    Document   : editClassrooms
    Created on : Sep 30, 2015, 7:20:39 PM
    Author     : Nikesh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Edit Classrooms</title>
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
                <h2 class="text-primary" style="text-align: center">Edit Classrooms</h2>
                <thead>
                    <tr>
                        <th>Room Code</th>
                        <th>Name</th>
                        <th>Room Type</th>
                        <th>Capacity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="isDataAvailable" value="false" />
                    <c:forEach var="classroom" items="${classroomList}">
                        <c:set var="isDataAvailable" value="true" />
                        <c:set var="roomCode" value="${classroom.roomCode}" />
                        <tr>
                            <td><c:out value="${roomCode}" /></td>
                            <td><c:out value="${classroom.roomName}" /></td>
                            <c:choose>
                                <c:when test="${classroom.roomType eq 1}">
                                    <c:set var="roomTypeName" value="Lecture" />
                                </c:when>
                                <c:when test="${classroom.roomType eq 2}">
                                    <c:set var="roomTypeName" value="Tutorial" />
                                </c:when>
                                <c:when test="${classroom.roomType eq 3}">
                                    <c:set var="roomTypeName" value="Lab" />
                                </c:when>
                                <c:when test="${classroom.roomType eq 4}">
                                    <c:set var="roomTypeName" value="Workshop" />
                                </c:when>
                            </c:choose>
                            <td><c:out value="${roomTypeName}"/></td>
                            <td><c:out value="${classroom.capacity}" /></td>
                            <td>
                                <a href="#<c:out value='${roomCode}' />" data-toggle="modal"><span class="glyphicon glyphicon-edit" title="Edit"></span></a> 
                            </td>
                        </tr>
                    <div class="modal fade" tabindex="-1" role="dialog" id="<c:out value='${roomCode}' />">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="<c:url value='/resources/classrooms/edit' />" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Edit Classroom</h4>
                                    </div>

                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="roomCode">Room Code</label>
                                            <input type="text" id="classroomCode" disabled="true" class="form-control" maxlength="10" value="<c:out value='${roomCode}' />" />
                                            <input type="hidden" name="roomCode" value="<c:out value='${roomCode}' />" />
                                        </div>

                                        <div class="form-group">
                                            <label for="classroomName">Module Name</label>
                                            <input type="text" name="roomName" id="classroomName" class="form-control" maxlength="50" value="<c:out value='${classroom.roomName}' />" required />
                                        </div>
                                        <div class="form-group">
                                            <label for="typeOfClassroom">Type of classroom</label>
                                            <div class="radio">
                                                <label><input class="radio-inline" type="radio" name="roomType" value="1" 
                                                              <c:if test="${classroom.roomType eq 1}">
                                                                  <c:out value="checked" />
                                                              </c:if>> Lecture</label>
                                                <label><input class="radio-inline" type="radio" name="roomType" value="2" 
                                                              <c:if test="${classroom.roomType eq 2}">
                                                                  <c:out value="checked" />
                                                              </c:if>> Tutorial</label>
                                                <label><input class="radio-inline" type="radio" name="roomType" value="3" 
                                                              <c:if test="${classroom.roomType eq 3}">
                                                                  <c:out value="checked" />
                                                              </c:if>> Lab</label>
                                                <label><input class="radio-inline" type="radio" name="roomType" value="4" 
                                                              <c:if test="${classroom.roomType eq 4}">
                                                                  <c:out value="checked" />
                                                              </c:if>> Workshop</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="classroomCapacity">Capacity</label>
                                            <input class="form-control" type="number" value="<c:out value='${classroom.capacity}' />" name="capacity" min="10" required />
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
                        <td colspan="5" style="text-align:center">There are no classrooms.</td>
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
