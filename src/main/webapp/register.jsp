<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register - PrintEase</title>

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

    <link rel="stylesheet" href="css/register.css">
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
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active-link register-btn"
                            href="register.jsp">

                            Register

                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Register Section -->

    <section class="register-section">

        <div class="container">

            <div class="row justify-content-center align-items-center">

                <div class="col-lg-6 col-md-9">

                    <div class="register-card">

                        <div class="text-center mb-4">

                            <h2>Create Account 🚀</h2>

                            <p>
                                Register to start online printing services
                            </p>

                        </div>

                        <!-- Register Form -->

                        <form action="register" method="post">

                            <!-- Full Name -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Full Name
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-person-fill"></i>
                                    </span>

                                    <input type="text"
                                    		name="fullName"
                                        class="form-control"
                                        placeholder="Enter your full name" required>

                                </div>

                            </div>

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

                            <!-- Phone -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Phone Number
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-telephone-fill"></i>
                                    </span>

                                    <input type="tel"
                                    		 name="phone"
                                        class="form-control"
                                        placeholder="Enter your phone number" required>

                                </div>

                            </div>

                            <!-- Address -->

                            <div class="mb-3">

                                <label class="form-label">
                                    Address
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-geo-alt-fill"></i>
                                    </span>

                                    <textarea name="address" class="form-control"
                                        rows="3"
                                        placeholder="Enter your address" required></textarea>

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
                                        placeholder="Create password">

                                </div>

                            </div>

                            <!-- Confirm Password -->

                            <div class="mb-4">

                                <label class="form-label">
                                    Confirm Password
                                </label>

                                <div class="input-group">

                                    <span class="input-group-text">
                                        <i class="bi bi-shield-lock-fill"></i>
                                    </span>

                                    <input type="password"
                                        class="form-control"
                                        placeholder="Confirm password">

                                </div>

                            </div>

                            <!-- Register Button -->

                            <button type="submit"
                                class="btn register-submit-btn w-100">

                                Create Account

                            </button>

                        </form>

                        <!-- Login -->

                        <div class="text-center mt-4">

                            <p>
                                Already have an account?

                                <a href="login.jsp"
                                    class="login-link">

                                    Login

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