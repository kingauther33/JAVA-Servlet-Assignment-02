<%--
  Created by IntelliJ IDEA.
  User: kinga
  Date: 12/24/2021
  Time: 8:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.javaservletassignment02.entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Category category = (Category) request.getAttribute("category");
    HashMap<String, String> errors = (HashMap<String, String>) request.getAttribute("errors");
    if (category == null) {
        category = new Category();
    }
    if (errors == null) {
        errors = new HashMap<>();
    }
%>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/admin/include/header.jsp">
        <jsp:param name="title" value="Category | Edit ${food.getName()}"/>
        <jsp:param name="description" value="Admin area"/>
        <jsp:param name="keywords" value="admin, edit...."/>
    </jsp:include>
</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="/admin/include/left-menu.jsp"/>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">

        <jsp:include page="/admin/include/navbar.jsp"/>

        <h5 class="pl-3">Editing <%=category.getName()%></h5>

        <form class="form-horizontal" action="/admin/category/edit" method="post">
            <input type="hidden" name="id" value="<%=category.getId()%>" />
            <div class="form-group">
                <label class="control-label col-sm-2" for="name">Name:</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="name" placeholder="Enter name" name="name" value="<%=category.getName()%>">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="status">Status:</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="status" placeholder="Enter Status" name="status" value="<%=category.getStatus()%>">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>

    </div>
</div>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
