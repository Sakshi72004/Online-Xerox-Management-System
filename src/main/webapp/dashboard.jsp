<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Dashboard - PrintEase</title>

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

    <link rel="stylesheet" href="css/dashboard.css">
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
                        <a class="nav-link active-link"
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
                        <a class="nav-link"
                            href="profile.jsp">
                            Profile
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link logout-btn"
                            href="index.jsp">
                            Logout
                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Dashboard -->

    <section class="dashboard-section">

        <div class="container">

            <!-- Welcome Card -->

            <div class="welcome-card">

                <h2>Welcome Back 👋</h2>

                <p>
                    Manage your documents, orders and deliveries from one place.
                </p>

            </div>

            <!-- Quick Actions -->

            <div class="row g-4 mb-5">

                <div class="col-md-3">

                    <a href="upload.jsp" class="action-card">

                        <i class="bi bi-cloud-upload"></i>

                        <h5>Upload Document</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="orders.jsp" class="action-card">

                        <i class="bi bi-box-seam"></i>

                        <h5>My Orders</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="tracking.jsp" class="action-card">

                        <i class="bi bi-truck"></i>

                        <h5>Track Order</h5>

                    </a>

                </div>

                <div class="col-md-3">

                    <a href="orders.jsp" class="action-card">

                        <i class="bi bi-receipt"></i>

                        <h5>Invoices</h5>

                    </a>

                </div>

            </div>

            <!-- Statistics -->

            <div class="row g-4 mb-5">

                <div class="col-md-3">

                    <div class="stats-card">

                        <h3>12</h3>

                        <p>Total Orders</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="stats-card">

                        <h3>3</h3>

                        <p>Pending</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="stats-card">

                        <h3>6</h3>

                        <p>Completed</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="stats-card">

                        <h3>3</h3>

                        <p>Delivered</p>

                    </div>

                </div>

            </div>

            <!-- Recent Orders -->

            <div class="table-card">

                <h4 class="mb-4">Recent Orders</h4>

                <div class="table-responsive">

                    <table class="table">

                        <thead>

                            <tr>
                                <th>Order ID</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Amount</th>
                            </tr>

                        </thead>

                        <tbody>

                            <tr>
                                <td>ORD101</td>
                                <td>20-05-2026</td>
                                <td>
                                    <span class="badge bg-warning">
                                        Printing
                                    </span>
                                </td>
                                <td>₹120</td>
                            </tr>

                            <tr>
                                <td>ORD102</td>
                                <td>18-05-2026</td>
                                <td>
                                    <span class="badge bg-success">
                                        Delivered
                                    </span>
                                </td>
                                <td>₹85</td>
                            </tr>

                            <tr>
                                <td>ORD103</td>
                                <td>15-05-2026</td>
                                <td>
                                    <span class="badge bg-primary">
                                        Packed
                                    </span>
                                </td>
                                <td>₹150</td>
                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>