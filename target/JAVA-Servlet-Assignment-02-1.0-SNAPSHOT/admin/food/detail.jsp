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
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.javaservletassignment02.entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    Food food = (Food) request.getAttribute("food");
    ArrayList<Category> listCategory = (ArrayList<Category>) request.getAttribute("listCategory");
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
%>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/admin/include/header.jsp">
        <jsp:param name="title" value="Detail Food"/>
        <jsp:param name="description" value="Detail area"/>
        <jsp:param name="keywords" value="admin, detail...."/>
    </jsp:include>
</head>
<body>

<div class="wrapper d-flex align-items-stretch">
    <jsp:include page="/admin/include/left-menu.jsp"/>

    <!-- Page Content  -->
    <div id="content" class="p-4 p-md-5">

        <jsp:include page="/admin/include/navbar.jsp"/>

        <div class="row mb-3 align-items-center">
            <p class="col-sm-2 font-weight-bold">Id:</p>
            <p type="text" class="col"><%=food.getId()%>
            </p>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Name:</p>
            <div class="col">
                <p type="text"><%=food.getName()%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Category:</p>
            <div class="col">
                <%
                    for (Category category :
                            listCategory) {
                        if (category.getId() == food.getCategoryId()) {

                %>
                <p type="text"><%=category.getName()%>
                </p>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Description:</p>
            <div class="col">
                <p type="text"><%=food.getDescription()%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Thumbnail:</p>
            <div class="col">
                <img src="<%=food.getThumbnail()%>" width="150" class="img-fluid"/>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Price:</p>
            <div class="col">
                <p type="text"><%=food.getPrice()%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Sell Date:</p>
            <div class="col">
                <p type="text"><%=formatter.format(food.getSellDate())%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Edit Date:</p>
            <div class="col">
                <p><%=formatter.format(food.getEditDate())%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Status:</p>
            <div class="col">
                <p><%=food.getStatus()%>
                </p>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
