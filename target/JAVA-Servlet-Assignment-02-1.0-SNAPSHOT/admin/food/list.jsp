<%--
  Created by IntelliJ IDEA.
  User: kinga
  Date: 12/24/2021
  Time: 8:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.javaservletassignment02.entity.Food" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.javaservletassignment02.entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
    ArrayList<Food> listFood = (ArrayList<Food>) request.getAttribute("listFood");
    ArrayList<Category> listCategory = (ArrayList<Category>) request.getAttribute("listCategory");
    SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
    if (listFood == null) {
        listFood = new ArrayList<Food>();
    }
    if (listCategory == null) {
        listCategory = new ArrayList<Category>();
    }
    int currentPage = (Integer) request.getAttribute("page");
    int pageSize = (Integer) request.getAttribute("pageSize");
    int totalRecords = (Integer) request.getAttribute("totalRecords");
    int totalPages = (int) (Math.ceil((double) totalRecords / pageSize));
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
            if (listFood.size() > 0) {
        %>

        <table class="table">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Name</th>
                <th scope="col">Category</th>
                <th scope="col">Description</th>
                <th scope="col">Thumbnail</th>
                <th scope="col">Price</th>
                <th scope="col">Sell Date</th>
                <th scope="col">Edit Date</th>
                <th scope="col">Status</th>
                <th scrope="col">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = 0; i < listFood.size(); i++) {
                    int foodCategoryId = listFood.get(i).getCategoryId();
            %>
            <tr>
                <th scope="row"><%=listFood.get(i).getId()%>
                </th>
                <td><%=listFood.get(i).getName()%>
                </td>
                <td><%=listCategory.stream().filter(category -> category.getId() == foodCategoryId).findAny().get().getName()%>
                </td>
                <td><%=listFood.get(i).getDescription()%>
                </td>
                <td><img src="<%=listFood.get(i).getThumbnail()%>" alt="<%=listFood.get(i).getName()%>" width="100"/>
                </td>
                <td><%=listFood.get(i).getPrice()%>
                </td>
                <td><%=formatter.format(listFood.get(i).getSellDate())%>
                </td>
                <td><%=formatter.format(listFood.get(i).getEditDate())%>
                </td>
                <td><%=listFood.get(i).getStatus() == 1 ? "??ang b??n" : listFood.get(i).getStatus() == 0 ? "D???ng b??n" : "Kh??ng ho???t ?????ng"%>
                </td>
                <td>
                    <a href="/admin/food/detail?id=<%=listFood.get(i).getId()%>">Detail</a>&nbsp;
                    <a href="/admin/food/edit?id=<%=listFood.get(i).getId()%>">Edit</a>&nbsp;
                    <a class="btn-delete" onclick="deleteProduct(<%=listFood.get(i).getId()%>)"
                       href="javascript:void(0)">Delete</a>&nbsp;
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <nav aria-label="...">
            <div>
                <form action="/admin/food/list" class="d-flex justify-content-end align-items-center gap-4 mb-3"
                      method="post">
                    <h5 class="text-secondary mb-0 me-2">Total pages: <%=totalPages%>
                    </h5>
                    <div class="form-group d-flex justify-content-center align-items-center gap-2 m-0">
                        <label class="control-label" style="margin: 0" for="page">Page:</label>
                        <div>
                            <input type="number" min="1" max="<%=totalPages%>" step="1" class="form-control" id="page"
                                   name="page" value="<%=currentPage%>">
                        </div>
                    </div>
                    <div class="form-group d-flex justify-content-center align-items-center gap-2 m-0">
                        <label class="control-label" style="margin: 0" for="pageSize">Page size:</label>
                        <div>
                            <input type="number" min="1" max="99" step="1" class="form-control" id="pageSize"
                                   name="pageSize" value="<%=pageSize%>">
                        </div>
                    </div>
                    <div class="form-group m-0">
                        <button class="btn btn-primary">
                            Go
                        </button>
                    </div>
                </form>
            </div>

            <ul class="pagination justify-content-center">
                <li class="page-item <%=currentPage == 1 ? "disabled" : ""%>">
                    <c:choose>
                        <c:when test="${requestScope.get('page') == 1 || requestScope.get('totalPages') == 1}">
                            <span class="page-link">Previous</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link"
                               href="/admin/food/list?page=<%=currentPage - 1%>&pageSize=<%=pageSize%>">Previous</a>
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
                            <a class="page-link"
                               href="/admin/food/list?page=<%=currentPage + 1%>&pageSize=<%=pageSize%>">Next</a>
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
            xhr.open('DELETE', '/admin/food/delete?id=' + id);
            xhr.send()
        }
    }
</script>

<jsp:include page="/admin/include/scripts.jsp"/>

</body>
</html>
