<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.model.User" %>

<%
User user = (User) session.getAttribute("loggedUser");

if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Profile - PrintEase</title>

    <!-- Bootstrap -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Font -->

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="css/profile.css">
</head>
<body>
	<!-- Navbar -->

    <nav class="navbar navbar-expand-lg">

        <div class="container">

            <a class="navbar-brand" href="#">
                Print<span>Ease</span>
            </a>

            <button class="navbar-toggler bg-light"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div class="collapse navbar-collapse"
                id="navbarNav">

                <ul class="navbar-nav ms-auto">

                    <li class="nav-item">
                        <a class="nav-link"
                            href="dashboard.jsp">
                            Dashboard
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                            href="upload.jsp">
                            Upload
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                            href="orders.jsp">
                            Orders
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                            href="tracking.jsp">
                            Tracking
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active-link"
                            href="profile.jsp">
                            Profile
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link logout-btn"
                            href="logout">
                            Logout
                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Profile Section -->

    <section class="profile-section">

        <div class="container">

            <div class="profile-card">

                <div class="text-center mb-4">

                    <div class="profile-avatar">
                        <i class="bi bi-person-fill"></i>
                    </div>

                    <h2>My Profile</h2>
                    
                    <p class="text-muted">Role : <%= user.getRole() %></p>

                    <p>Manage your account information</p>

                </div>

                <form action="updateProfile" method="post">

                    <div class="row">

                        <div class="col-md-6 mb-3">

                            <label class="form-label">
                                Full Name
                            </label>

                            <input type="text"
                                class="form-control" name="fullName"
                                value="<%= user.getFullName() %>" >

                        </div>

                        <div class="col-md-6 mb-3">

                            <label class="form-label">
                                Email Address
                            </label>

                            <input type="email"
                                class="form-control"  name="email"
                                value="<%= user.getEmail() %>" >

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6 mb-3">

                            <label class="form-label">
                                Phone Number
                            </label>

                            <input type="text"
                                class="form-control" name="phone"
                                value="<%= user.getPhone() %>"  >

                        </div>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            Address
                        </label>

                        <textarea class="form-control" name="address"
                            rows="3" ><%= user.getAddress() %> </textarea>

                    </div>

                    <hr class="my-4">

                    <h5 class="mb-3">
                        Change Password
                    </h5>

                    <div class="row">

                        <div class="col-md-4 mb-3">

                            <input type="password"
                                class="form-control"
                                name="currentPassword"
                                placeholder="Current Password">

                        </div>

                        <div class="col-md-4 mb-3">

                            <input type="password"
                                class="form-control"
                                name="newPassword"
                                placeholder="New Password">

                        </div>

                        <div class="col-md-4 mb-3">

                            <input type="password"
                                class="form-control"
                                name="confirmPassword"
                                placeholder="Confirm Password">

                        </div>

                    </div>

                    <button type="submit"
                        class="btn save-btn">

                        Save Changes

                    </button>

                </form>

            </div>

        </div>

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>
