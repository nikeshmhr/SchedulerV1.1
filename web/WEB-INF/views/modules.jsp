<%-- 
    Document   : addModules
    Created on : Sep 27, 2015, 8:27:31 PM
    Author     : Nikesh
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/resources/includes/headerInclude.jsp" %>
        <title>Add Modules</title>
        <script type="text/javascript">
            $(document).ready(function () {
                /** HIGHLIGHTS THE CURRENTLY ACTIVE NAVIGATION **/
                $("#addResource").addClass("active");

                $("#classType2").hide();
                $("#classType3").hide();
                $("#classType4").hide();
            });

            /** Check to see if everything is fine **/
            function validateAddModule() {
                var checkedList = getCheckedClasses();

                for (var i = 0; i < checkedList.length; i++) {
                    var checkedValue = checkedList[i];
                    var checkedHourseValue = document.getElementById("classType" + checkedValue).value;
                    if (checkedHourseValue <= 0) {
                        document.getElementById("classType" + checkedValue).focus();
                        return false;
                    }
                }
                return true;
            }

            /** Returns value of all the checked items (currently) **/
            function getCheckedClasses(obj) {
                /*var checked = Array();
                 var i = document.getElementsByName("typesOfClasses");
                 var k = 0;
                 for (var j = 0; j < i.length; j++) {
                 if (i[j].checked === true) {
                 checked[k++] = i[j].value;
                 }
                 }*/

                //var classes = {"classType1", "classType2", "classType3", "classType4"};
                var item = obj.value;
                switch (item) {
                    case "2":
                        if (obj.checked) {
                            $("#classType2").show();
                        } else {
                            $("#classType2").hide();
                        }
                        break;

                    case "3":
                        if (obj.checked) {
                            $("#classType3").show();
                        } else {
                            $("#classType3").hide();
                        }
                        break;

                    case "4":
                        if (obj.checked) {
                            $("#classType4").show();
                        } else {
                            $("#classType4").hide();
                        }
                        break;
                }

                //return checked;
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
                <!-- TABLE TO SHOW THE LIST OF ALREADY EXISTING MODULES -->
                <div class="col-md-6">
                    <table class="table table-striped table-hover table-bordered table-responsive">
                        <h2 class="text-primary">List of Modules</h2>
                        <thead>
                            <tr>
                                <th>Year</th>
                                <th>Sem</th>
                                <th>Module Code</th>
                                <th>Module Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="isDataAvailable" value="false" />

                            <c:forEach var="module" items="${moduleList}">
                                <c:set var="isDataAvailable" value="true" />
                                <tr>
                                    <td><c:out value="${module.year}" /></td>
                                    <td><c:out value="${module.sem}" /></td>
                                    <td><c:out value="${module.moduleCode}" /></td>
                                    <td>
                                        <c:out value="${module.moduleName}" />
                                        <span class="text-primary" style="font-style: italic;font-size:90%">
                                            <c:forEach var="classType" items="${module.typeOfClasses}">
                                                ${classType.typeName} (${classType.hours}) 
                                            </c:forEach>
                                        </span>
                                    </td>
                                    <td>
                                        <s:url value="/resources/modules/delete/{moduleCode}" var="deleteURL">
                                            <s:param name="moduleCode" value="${module.moduleCode}" />
                                        </s:url>
                                        <a href="${deleteURL}"><span class="glyphicon glyphicon-remove" title="Delete" /></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${isDataAvailable eq false}">
                                <tr>
                                    <td colspan="5" align="center">There are no modules.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- END OF MODULES LIST -->

                <!-- START OF FORM TO ADD MODULES -->
                <div class="col-md-4 col-md-offset-1">
                    <h2 class="text-primary">Add new module</h2>
                    <form action="<c:url value="/resources/modules/add" />" name="addModulesForm" method="post" role="form" onsubmit="return validateAddModule();">
                        <div class="form-group">
                            <label for="year">Year</label>
                            <input type="number" id="year" class="form-control" min="1" max="3" value="3" disabled="disabled" required />
                            <input type="hidden" name="year" value="3" />
                        </div>

                        <div class="form-group">
                            <label for="semester">Semester</label>
                            <input type="number" name="sem" id="semester" class="form-control" min="1" max="2" required />
                        </div>

                        <div class="form-group">
                            <label for="moduleCode">Module Code</label>
                            <input type="text" name="moduleCode" id="moduleCode" class="form-control" maxlength="10" required />
                        </div>

                        <div class="form-group">
                            <label for="moduleName">Module Name</label>
                            <input type="text" name="moduleName" id="moduleName" class="form-control" maxlength="50" required />
                        </div>
                        <div class="form-group">
                            <label for="classTypes">Types of classes</label>
                            <div class="checkbox">
                                <label><input class="checkbox-inline" type="checkbox" name="typesOfClasses.typeId" value="1" required checked onclick="getCheckedClasses(this);"> Lecture</label>
                                <label><input class="checkbox-inline" type="checkbox" name="typesOfClasses.typeId" value="2" onclick="getCheckedClasses(this);"> Tutorial</label>
                                <label><input class="checkbox-inline" type="checkbox" name="typesOfClasses.typeId" value="3" onclick="getCheckedClasses(this);"> Lab</label>
                                <label><input class="checkbox-inline" type="checkbox" name="typesOfClasses.typeId" value="4" onclick="getCheckedClasses(this);"> Workshop</label>
                            </div>
                        </div>

                        <div class="form-group form-inline">
                            <label for="hoursOfClasses">Hours of classes</label>
                            <blockquote>
                                <label id="classType1">Lecture:</label>
                                <input type="number" style="margin-bottom: 5px;" class="form-control input-group col-md-4" step="0.1" min="1" name="hours1" placeholder="0" required  />

                                <div id="classType2">
                                    <label>Tutorial:</label>
                                    <input type="number" style="margin-bottom: 5px" class="form-control input-group col-md-4" step="0.1" min="1" name="hours2" placeholder="0"  />

                                </div>
                                <div id="classType3">
                                    <label>Lab:</label>
                                    <input type="number" style="margin-bottom: 5px" class="form-control input-group col-md-4" step="0.1" min="1" name="hours3" placeholder="0"   />

                                </div>
                                <div id="classType4">
                                    <label>Workshop:</label>
                                    <input type="number" style="margin-bottom: 5px" class="form-control input-group col-md-4" step="0.1" min="1" name="hours4" placeholder="0" />

                                </div>
                            </blockquote>
                        </div>
                        <div>
                            <input type="submit" name="addModule" value="Add" class="btn btn-success" />
                        </div>
                    </form>
                </div>
                <!-- END OF ADD MODULES FORM -->
            </div>
            <!-- END OF ROW -->
        </div>
        <!-- CONTAINER ENDS HERE -->

        <!-- A FOOTER -->
        <%@include file="/resources/includes/footer.html" %>
    </body>
</html>
