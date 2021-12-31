<%--
  Created by IntelliJ IDEA.
  User: kinga
  Date: 12/24/2021
  Time: 8:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.javaservletassignment02.entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
    ArrayList<Category> list = (ArrayList<Category>) request.getAttribute("list");
    int currentPage = (Integer) request.getAttribute("page");
    int pageSize = (Integer) request.getAttribute("pageSize");
    int totalRecords = (Integer) request.getAttribute("totalRecords");
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    int totalPages = (int) (Math.ceil((double)totalRecords / pageSize));
    request.setAttribute("totalPages", totalPages);
%>
<!doctype html>
<html lang="en">
<head>
    <jsp:include page="/admin/include/header.jsp">
        <jsp:param name="title" value="My admin page"/>
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
            if (list.size() > 0) {
        %>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Status</th>
                <th scope="col">Edit Date</th>
                <th scrope="col">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = 0; i < list.size(); i++) {
            %>
            <tr>
                <th scope="row"><%=list.get(i).getId()%>
                </th>
                <td><%=list.get(i).getName()%>
                </td>
                <td><%=list.get(i).getStatus() == 1 ? "Đang hoạt động" : list.get(i).getStatus() == 0 ? "Dừng hoạt động" : "Không hoạt động"%>
                </td>
                <td><%=formatter.format(list.get(i).getEditDate())%>
                </td>
                <td>
                    <a href="/admin/category/detail?id=<%=list.get(i).getId()%>">Detail</a>&nbsp;
                    <a href="/admin/category/edit?id=<%=list.get(i).getId()%>">Edit</a>&nbsp;
                    <a class="btn-delete" onclick="deleteProduct(<%=list.get(i).getId()%>)" href="javascript:void(0)">Delete</a>&nbsp;
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <nav aria-label="...">
            <ul class="pagination justify-content-center">
                <li class="page-item <%=currentPage == 1 ? "disabled" : ""%>">
                    <c:choose>
                        <c:when test="${requestScope.get('page') == 1 || requestScope.get('totalPages') == 1}">
                            <span class="page-link">Previous</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/food/list?page=<%=currentPage - 1%>&pageSize=<%=pageSize%>">Previous</a>
                        </c:otherwise>
                    </c:choose>
                </li>

                <c:forEach var="i" begin="1" end="${totalPages + 0.5}">
                    <c:choose>
                        <c:when test="${i == requestScope.get('page')}">
                            <li class="page-item active">
                            <span class="page-link">
                                <c:out value="${i}"/>
                            <span class="sr-only">(current)</span>
                            </span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link"
                                   href="/admin/food/list?page=<c:out value="${i}" />&pageSize=<%=pageSize%>">
                                    <c:out value="${i}"/>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <li class="page-item <%=currentPage == totalPages ? "disabled" : ""%>">
                    <c:choose>
                        <c:when test="${requestScope.get('page') == requestScope.get('totalPages') || requestScope.get('totalPages') == 1}">
                            <span class="page-link">Next</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="/admin/food/list?page=<%=currentPage + 1%>&pageSize=<%=pageSize%>">Next</a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </nav>

        <%
        } else {
        %>

        <p class="text-center font-weight-bold">No Records found</p>

        <%
            }
        %>
    </div>
</div>

<script>
    const deleteProduct = (id) => {
        if (confirm("Do you really want to delete food?")) {
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert('Delete sucessfully!')
                    window.location.reload()
                }
            }
            xhr.open('DELETE', '/admin/category/delete?id=' + id);
            xhr.send()
        }
    }
</script>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
