<%-- 
    Document   : addGroups
    Created on : Sep 30, 2015, 6:36:42 PM
    Author     : Nikesh
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Add Groups</title>
        <script type="text/javascript">
            $(document).ready(function () {
                /** HIGHLIGHTS THE CURRENTLY ACTIVE NAVIGATION **/
                $("#addResource").addClass("active");
            });

            function validateAddGroups() {

            }
        </script>
    </head>
    <body>

        <%@include file="/resources/includes/functions.jsp" %>
        <%
            clearBrowsersDefaultCache(response);
        %>

        <!-- CONTAINER STARTS HERE -->
        <div class="container">
            <%@include file="/resources/includes/navigation.html" %>

            <span class="label label-danger"><c:out value="${errorMessage}" /></span>
            <span class="label label-success"><c:out value="${message}" /></span>


            <div class="row">
                <!-- TABLE TO SHOW THE LIST OF ALREADY EXISTING GROUPS -->
                <div class="col-md-5">
                    <table class="table table-striped table-hover table-bordered table-responsive">
                        <h2 class="text-primary">List of Groups</h2>
                        <thead>
                            <tr>
                                <th>Group Code</th>
                                <th>No. of Students</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set value="false" var="isDataAvailable" />
                            <c:forEach var="group" items="${groupList}">
                                <c:set value="true" var="isDataAvailable" />
                                <tr>
                                    <td><c:out value="${group.groupCode}" /></td>
                                    <td><c:out value="${group.noOfStudents}" /></td>
                                    <td>
                                        <s:url var="deleteURL" value="/resources/groups/delete/{groupCode}">
                                            <s:param name="groupCode" value="${group.groupCode}" />
                                        </s:url>
                                        <a href="${deleteURL}"><span class="glyphicon glyphicon-remove" /></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="isDataAvailabe eq false">
                                <tr>
                                    <td colspan="3">There are no groups.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- END OF GROUPS LIST -->
                <!-- START OF FORM TO ADD GROUPS -->
                <div class="col-md-4 col-md-offset-1">
                    <h2 class="text-primary">Add new group</h2>
                    <form action="<c:url value='/resources/groups/add' />" method="post" role="form" onsubmit="return validateAddGroups()">
                        <div class="form-group">
                            <label for="groupCode">Group Code</label>
                            <input type="text" name="groupCode" id="groupCode" class="form-control" maxlength="10" required />
                        </div>

                        <div class="form-group">
                            <label for="noOfStudents">No. of Students</label>
                            <input type="number" name="noOfStudents" id="noOfStudents" class="form-control" min="10" max="50" required />
                        </div>
                        <div>
                            <input type="submit" name="addGroup" value="Add" class="btn btn-success" />
                        </div>
                    </form>
                </div>
                <!-- END OF ADD GROUPS FORM -->
            </div>
            <!-- END OF ROW -->
        </div>
        <!-- CONTAINER ENDS HERE -->

        <!-- A FOOTER -->
        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
