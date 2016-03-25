<%-- 
    Document   : addClassrooms
    Created on : Sep 30, 2015, 6:36:42 PM
    Author     : Nikesh
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Add Classrooms</title>
        <script type="text/javascript">
            $(document).ready(function () {
                /** HIGHLIGHTS THE CURRENTLY ACTIVE NAVIGATION **/
                $("#addResource").addClass("active");
            });

            function validateAddClassroom() {

            }
        </script>
    </head>
    <body>
        <%@include file="/resources/includes/functions.jsp" %>

        <!-- CONTAINER STARTS HERE -->
        <div class="container">
            <%@include file="/resources/includes/navigation.html" %>

            <%
                clearBrowsersDefaultCache(response);
            %>

            <span class="label label-danger"><c:out value="${errorMessage}" /></span>
            <span class="label label-success"><c:out value="${message}" /></span>

            <div class="row">
                <!-- TABLE TO SHOW THE LIST OF ALREADY EXISTING CLASSROOMS -->
                <div class="col-md-5">
                    <table class="table table-striped table-hover table-bordered table-responsive">
                        <h2 class="text-primary">List of Classrooms</h2>
                        <thead>
                            <tr>
                                <th>Room Code</th>
                                <th>Name</th>
                                <th>Room Type</th>
                                <th>Capacity</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="isDataAvailable" value="false" />
                            <c:forEach var="classroom" items="${classroomList}">
                                <c:set var="isDataAvailable" value="true" />
                                <tr>
                                    <td><c:out value="${classroom.roomCode}"/></td>
                                    <td><c:out value="${classroom.roomName}"/></td>
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
                                    <td><c:out value="${classroom.capacity}"/></td>
                                    <td>
                                        <s:url var="deleteURL" value="/resources/classrooms/delete/{roomCode}">
                                            <s:param name="roomCode" value="${classroom.roomCode}" />
                                        </s:url>
                                        <a href="${deleteURL}"><span class="glyphicon glyphicon-remove" /></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${isDataAvailable eq false}">
                                <tr>
                                    <td colspan="5">There are no classrooms.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- END OF CLASSROOM LIST -->
                <!-- START OF FORM TO ADD CLASSROOMS -->
                <div class="col-md-4 col-md-offset-1">
                    <h2 class="text-primary">Add new classroom</h2>
                    <form action="<s:url value='/resources/classrooms/add' />" method="post" role="form" onsubmit="return validateAddClassroom()">
                        <div class="form-group">
                            <label for="classroomCode">Code</label>
                            <input type="text" name="roomCode" id="classroomCode" class="form-control" maxlength="10" required />
                        </div>

                        <div class="form-group">
                            <label for="classroomName">Name</label>
                            <input type="text" name="roomName" id="classroomName" class="form-control" maxlength="50" required />
                        </div>
                        <div class="form-group">
                            <label for="typeOfClassroom">Type of classroom</label>
                            <div class="radio">
                                <label><input class="radio-inline" type="radio" name="roomType" value="1" checked> Lecture</label>
                                <label><input class="radio-inline" type="radio" name="roomType" value="2"> Tutorial</label>
                                <label><input class="radio-inline" type="radio" name="roomType" value="3"> Lab</label>
                                <label><input class="radio-inline" type="radio" name="roomType" value="4"> Workshop</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="classroomCapacity">Capacity</label>
                            <input class="form-control" type="number" value="10" name="capacity" min="10" required />
                        </div>
                        <div>
                            <input type="submit" name="addClassroom" value="Add" class="btn btn-success" />
                        </div>
                    </form>
                </div>
                <!-- END OF ADD CLASSROOMS FORM -->
            </div>
            <!-- END OF ROW -->
        </div>
        <!-- CONTAINER ENDS HERE -->

        <!-- A FOOTER -->
        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
