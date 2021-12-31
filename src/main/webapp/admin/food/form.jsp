<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: kinga
  Date: 12/24/2021
  Time: 8:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.javaservletassignment02.entity.Food" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.example.javaservletassignment02.entity.Category" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("listCategory");
    Food food = (Food) request.getAttribute("food");
    HashMap<String, String> errors = (HashMap<String, String>) request.getAttribute("errors");
    if (food == null) {
        food = new Food();
    }
    if (errors == null) {
        errors = new HashMap<>();
    }


%>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/admin/include/header.jsp">
        <jsp:param name="title" value="Food form"/>
        <jsp:param name="description" value="Admin area"/>
        <jsp:param name="keywords" value="admin, page...."/>
    </jsp:include>
</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="/admin/include/left-menu.jsp"/>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">

        <jsp:include page="/admin/include/navbar.jsp"/>

        <%
            if (errors.size() > 0) {

        %>
        <div class="w3-panel w3-pale-red w3-border">
            <h4>Vui lòng sửa lỗi bên dưới</h4>
            <ul>
                <%
                    for (Map.Entry<String, String> entry : errors.entrySet()
                    ) {
                %>
                <li><%=entry.getValue()%>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
        <%
            }
        %>


        <%
            if (categories.size() > 0) {

        %>
        <form class="form-horizontal" action="/admin/food/create" method="post">
            <div class="form-group">
                <label class="control-label col-sm-2" for="name">Name:</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="name" placeholder="Enter name" name="name"
                           value="<%=food.getName()%>">
                    <%
                        if (errors.containsKey("name")) {
                    %>
                    <span class="badge bg-danger"><%= errors.get("name")%></span>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="description">Description:</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="description" placeholder="Enter description"
                           value="<%=food.getDescription()%>"
                           name="description">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="thumbnail">Thumbnail:</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="thumbnail" placeholder="Enter thumbnail"
                           value="<%=food.getThumbnail()%>"
                           name="thumbnail">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="price">Price:</label>
                <div class="col-sm-4">
                    <input type="number" class="form-control" id="price" placeholder="Enter price" name="price"
                           value="<%=food.getPrice()%>">
                    <%
                        if (errors.containsKey("price")) {
                    %>
                    <span class="badge bg-danger"><%= errors.get("price")%></span>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2">Category:</label>
                <div class="col-sm-4">
                    <select class="form-select" aria-label="Default select example" name="categoryId"
                            value="<%=food.getCategoryId()%>">
                        <%
                            for (Category category :
                                    categories) {
                        %>
                        <option <%=category.getId() == food.getCategoryId() ? "selected" : ""%>
                                value="<%=category.getId()%>"><%=category.getName()%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>
            <%--            <div class="form-group">--%>
            <%--                <label class="control-label col-sm-2" for="sellDate">Sell Date:</label>--%>
            <%--                <div class="col-sm-4">--%>
            <%--                    <input type="date" class="form-control" id="sellDate" placeholder="Enter Sell Date" name="sellDate">--%>
            <%--                </div>--%>
            <%--            </div>--%>
            <%--            <div class="form-group">--%>
            <%--                <label class="control-label col-sm-2" for="editDate">Edit Date:</label>--%>
            <%--                <div class="col-sm-4">--%>
            <%--                    <input type="date" class="form-control" id="editDate" placeholder="Enter Edit Date" name="editDate">--%>
            <%--                </div>--%>
            <%--            </div>--%>
            <div class="form-group">
                <label class="control-label col-sm-2" for="status">Status:</label>
                <div class="col-sm-4">
                    <input type="number" class="form-control" id="status" value="<%=food.getStatus()%>"
                           placeholder="Enter Status" name="status">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </div>
        </form>

        <%
        } else {

        %>
        <p class="text-center text-danger">PLEASE ADD NEW CATEGORY</p>

        <%
            }
        %>
    </div>
</div>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
