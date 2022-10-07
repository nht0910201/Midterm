<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="authUser" scope="session" type="com.midterm.Midterm.beans.User"/>
<jsp:useBean id="productList" type="java.util.ArrayList<com.midterm.Midterm.beans.Product>"  scope="request"/>
<t:main>
    <jsp:body>
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
                    <form class="form-horizontal w-100" method="post" action="${pageContext.request.contextPath}/product/add">
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
                            <button type="submit" class="btn btn-success">Thêm sản phẩm</button>
                        </div>

                        <c:if test="${hasError}">
                            <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                                <strong>Error: </strong> ${errorMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
<%--                        <c:if test="${hasNotify}">--%>
<%--                            <div class="alert alert-success alert-dismissible fade show w-75 mx-auto" role="alert">--%>
<%--                                <strong>Error: </strong> ${successMessage}--%>
<%--                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">--%>
<%--                                    <span aria-hidden="true">&times;</span>--%>
<%--                                </button>--%>
<%--                            </div>--%>
<%--                        </c:if>--%>
                    </form>
                </div>
                <div class="col-md-9" style="border: 1px solid lightgray">
                    <c:choose>
                        <c:when test="${productList.size()==0}">
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
                                <c:forEach items="${productList}" var="product" varStatus="loop">
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
    </jsp:body>
</t:main>


