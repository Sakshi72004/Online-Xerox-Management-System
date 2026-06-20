<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Forgot Password - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/login.css">
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Print<span>Ease</span></a>
        <div class="ms-auto">
            <a href="login.jsp" class="btn btn-primary">Login</a>
        </div>
    </div>
</nav>

<section class="login-section">
    <div class="container">
        <div class="row justify-content-center align-items-center">
            <div class="col-lg-5 col-md-8">
                <div class="login-card">
                    <div class="text-center mb-4">
                        <h2>Reset Password</h2>
                        <p>Verify your email and phone number to set a new password.</p>
                    </div>

                    <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                    <form action="forgotPassword" method="post">
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                                <input type="email" name="email" class="form-control" placeholder="Enter registered email" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                                <input type="text" name="phone" class="form-control" placeholder="Enter registered phone" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" name="newPassword" class="form-control" minlength="4" placeholder="Enter new password" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Confirm Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
                                <input type="password" name="confirmPassword" class="form-control" minlength="4" placeholder="Confirm new password" required>
                            </div>
                        </div>

                        <button type="submit" class="btn login-btn w-100">
                            Reset Password
                        </button>
                    </form>

                    <div class="text-center mt-4">
                        <a href="login.jsp" class="register-link">Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
