<%-- 
    Document   : editModules
    Created on : Sep 27, 2015, 9:31:11 PM
    Author     : Nikesh
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Edit Modules</title>
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
                <h2 class="text-primary" style="text-align: center">Edit Modules</h2>
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Sem</th>
                        <th>Module Code</th>
                        <th>Module Name</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <c:set var="isDataAvailable" value="false" />
                    <c:forEach var="module" items="${moduleList}">
                        <c:set var="isDataAvailable" value="true" />
                        <c:set var="moduleCode" value="${module.moduleCode}" />
                        <c:set var="year" value="${module.year}" />
                        <c:set var="sem" value="${module.sem}" />
                        <c:set var="moduleName" value="${module.moduleName}" />
                        <tr>
                            <td><c:out value="${year}" /></td>
                            <td><c:out value="${sem}" /></td>
                            <td><c:out value="${moduleCode}" /></td>
                            <td><c:out value="${moduleName}" /> 
                                <span class="text-primary" style="font-style: italic;font-size:90%">
                                    <c:forEach var="classType" items="${module.typeOfClasses}">
                                        ${classType.typeName} (${classType.hours}) 
                                    </c:forEach>
                                </span>
                            </td>

                            <td>
                                <a href="#<c:out value='${moduleCode}' />" data-toggle="modal"><span class="glyphicon glyphicon-edit" title="Edit"></span></a>
                            </td>
                        </tr>

                    <div class="modal fade" tabindex="-1" role="dialog" id="<c:out value='${moduleCode}' />">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="<c:url value='/resources/modules/edit' />" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">Edit Module</h4>
                                    </div>

                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="moduleCode">Module Code</label>
                                            <input type="text" id="moduleCode" class="form-control" maxlength="10" value="<c:out value='${moduleCode}' />" disabled="true" required />
                                            <input type="hidden" name="moduleCode" value="<c:out value='${moduleCode}' />" />
                                        </div>

                                        <div class="form-group">
                                            <label for="year">Year</label>
                                            <input type="number" id="year" min="1" max="3" value="<c:out value='${year}' />" disabled="disabled" required />
                                            <input type="hidden" name="year" value="<c:out value='${year}' />" />
                                        </div>

                                        <div class="form-group">
                                            <label for="sem">Semester</label>
                                            <input type="number" id="semester" name="sem" min="1" max="2" value="<c:out value='${sem}' />" required />
                                        </div>

                                        <div class="form-group">
                                            <label for="moduleName">Module Name</label>
                                            <input type="text" name="moduleName" id="moduleName" class="form-control" maxlength="50" value="<c:out value='${moduleName}' />" required />
                                        </div>
                                        <div class="form-group form-inline">
                                            <label for="hoursOfClasses">Hours of classes</label>
                                            <blockquote>
                                                <c:forEach var="typeOfClass" items="${module.typeOfClasses}">
                                                    <c:set var="forName" value="${typeOfClass.typeName}" />
                                                    <c:set var="classHour" value="${typeOfClass.hours}" />
                                                    <label><c:out value="${typeOfClass.typeName}" />:</label>
                                                    <input type="number" style="margin-bottom: 5px;" 
                                                           class="form-control input-group col-md-4" step="0.1" min="1" 
                                                           name="<c:out value='${forName}Hours' />" 
                                                           placeholder="<c:out value='${classHour}' />" value="<c:out value='${classHour}' />" /><br/>
                                                </c:forEach>
                                            </blockquote>
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
                        <td colspan="3" style="text-align: center">There are no modules.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

        </div>
        <!-- END OF CONTAINER -->

        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
