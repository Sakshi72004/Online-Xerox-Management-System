<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login - PrintEase</title>

    <!-- Bootstrap -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Font -->

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <!-- CSS -->

    <link rel="stylesheet" href="css/login.css">
</head>
<body>
	<!-- Navbar -->

    <nav class="navbar navbar-expand-lg">

        <div class="container">

            <a class="navbar-brand" href="index.jsp">
                Print<span>Ease</span>
            </a>

            <button class="navbar-toggler bg-light" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav ms-auto">

                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active-link" href="login.jsp">Login</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link register-btn" href="register.jsp">
                            Register
                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Login Section -->

    <section class="login-section">

        <div class="container">

            <div class="row justify-content-center align-items-center">

                <div class="col-lg-5 col-md-8">

                    <div class="login-card">

                        <div class="text-center mb-4">

                            <h2>Welcome Back</h2>

                            <p>
                                Login to continue your printing services
                            </p>

                        </div>                        <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>

                        <% if(request.getAttribute("success") != null) { %>
                        <div class="alert alert-success">
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>
                        <!-- Login Form -->

                        <form action="login" method="post">

                            <!-- Email -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Email Address
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-envelope-fill"></i>
                                    </span>

                                    <input type="email"
                                    		 name="email"
                                        class="form-control"
                                        placeholder="Enter your email" required>

                                </div>

                            </div>

                            <!-- Password -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Password
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-lock-fill"></i>
                                    </span>

                                    <input type="password"
                                    		name="password"
                                        class="form-control"
                                        placeholder="Enter your password" required>

                                </div>

                            </div>

                            <!-- Remember Me -->

                            <div
                                class="d-flex justify-content-between align-items-center mb-4">

                                <div class="form-check">

                                    <input class="form-check-input"
                                        type="checkbox">

                                    <label class="form-check-label">
                                        Remember Me
                                    </label>

                                </div>

                                <a href="forgot-password.jsp" class="forgot-link">
                                    Forgot Password?
                                </a>

                            </div>

                            <!-- Login Button -->

                            <button type="submit"
                                class="btn login-btn w-100">

                                Login

                            </button>

                        </form>

                        <!-- Register -->

                        <div class="text-center mt-4">

                            <p>
                                Don't have an account?

                                <a href="register.jsp"
                                    class="register-link">

                                    Register

                                </a>

                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <!-- Bootstrap JS -->

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>
