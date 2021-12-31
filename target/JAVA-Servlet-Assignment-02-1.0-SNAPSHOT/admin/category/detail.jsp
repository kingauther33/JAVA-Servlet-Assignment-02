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
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
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
            <p type="text" class="col"><%=category.getId()%>
            </p>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Name:</p>
            <div class="col">
                <p type="text"><%=category.getName()%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Edit Date:</p>
            <div class="col">
                <p type="text"><%=formatter.format(category.getEditDate())%>
                </p>
            </div>
        </div>

        <div class="row mb-3">
            <p class="col-sm-2 font-weight-bold">Status:</p>
            <div class="col">
                <p>
                    <%=category.getStatus() == 1 ? "Đang hoạt động" : category.getStatus() == 0 ? "Dừng bán" : "Không hoạt động"%>
                </p>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
