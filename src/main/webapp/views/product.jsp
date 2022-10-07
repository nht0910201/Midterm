<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Auction Web Application</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
          integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
          integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>

<body>
<jsp:useBean id="authUser" scope="session" type="com.midterm.Midterm.beans.User"/>
<jsp:useBean id="productList" scope="request" type="java.util.List<com.midterm.Midterm.beans.Product>" />

<div class="container">
    <div class="d-flex justify-content-between align-items-center">
        <h3 class="text-primary mt-3">Product Management</h3>
        <div class="d-flex  mt-5">
            <h5>Xin chào ${authUser.name}</h5> &#160;
            <a href="javascript: $('#frmLogout').submit()">Logout</a>
        </div>
    </div>
    <form id="frmLogout" method="post" action="${pageContext.request.contextPath}/auth/logout"></form>
    <div class="row">
        <div class="col-md-3" style="border: 1px solid lightgray">
            <form class="form-horizontal w-100" method="post">
                <h4 class="text-success mt-3">Thêm sản phẩm mới</h4>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="product_name">Tên:</label>
                    <input name="product_name" type="text" class="form-control" id="product_name"
                           placeholder="Nhập tên sản phẩm">
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="price">Giá:</label>
                    <input type="number" name="price" class="form-control" id="price" placeholder="Nhập giá bán">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-success" formaction="${pageContext.request.contextPath}/product/add">Thêm sản phẩm</button>
                </div>

                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Error: </strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${hasNotify}">
                    <div class="alert alert-success alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Error: </strong> ${successMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
            </form>
        </div>
        <div class="col-md-9" style="border: 1px solid lightgray">
            <c:choose>
                <c:when test="${products.size()==0}">
                    <h4 class="text-success mt-3">Không có sản phẩm</h4>
                </c:when>
                <c:otherwise>
                    <h4 class="text-success mt-3">Danh sách sản phẩm</h4>
                    <table class="table table-hover mt-4">
                        <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${products}" var="product" varStatus="loop">
                            <tr>
                                <td>${loop.index+1}</td>
                                <td>${product.name}</td>
                                <td>${product.price}</td>
                                <td>
                                    <form method="post">
                                        <input name="pro_id" value="${product.id}" hidden>
                                        <button type="submit" class="btn btn-sm btn-danger" formaction="${pageContext.request.contextPath}/product/delete">
                                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                                            Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <br><br>
</div>
<div class="modal fade" id="confirm-removal-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Xóa sinh viên</h4>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa sinh viên <strong id="producer-name">My Tam</strong>?</p>
            </div>
            <div class="modal-footer">
                <button type="button" id="delete-button" class="btn btn-danger" data-dismiss="modal">Xóa
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Không</button>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
        integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
        crossorigin="anonymous"></script>
</body>
</html>

