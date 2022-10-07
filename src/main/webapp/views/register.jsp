<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<t:main>
    <jsp:body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-5">
                    <h3 class="text-center text-secondary mt-5 mb-3">User Login</h3>
                    <c:if test="${hasError}">
                        <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Sign Up Fail: </strong> ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <form method="post" action="${pageContext.request.contextPath}/auth/register" class="border rounded w-100 mb-5 mx-auto px-3 pt-3 bg-light">
                        <div class="form-group">
                            <label for="name">Fullname</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Your Name">
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input name="email" id="email" type="text" class="form-control" placeholder="Email">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input name="password" id="password" type="password" class="form-control" placeholder="Password">
                        </div>
                        <div class="form-group">
                            <label for="confirmpassword">Confirm Password</label>
                            <input name="confirmpassword" id="confirmpassword" type="password" class="form-control" placeholder="Confirm Password">
                        </div>
                        <div class="form-group">
                            <button class="btn btn-success px-5" type="submit">Register</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </jsp:body>
</t:main>
