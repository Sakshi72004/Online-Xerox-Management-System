<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.xeroxsystem.dao.OrderDAO" %>
<%@ page import="com.xeroxsystem.model.Order" %>
<%@ page import="com.xeroxsystem.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");

if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}

OrderDAO orderDAO = new OrderDAO();
List<Order> orders = orderDAO.getOrdersByUser(user.getId());

int totalOrders = orders.size();
int pendingOrders = 0;
int deliveredOrders = 0;
int activeOrders = 0;
double totalSpent = 0;

for(Order order : orders) {
    totalSpent += order.getTotalAmount();

    if("Pending".equalsIgnoreCase(order.getStatus())) {
        pendingOrders++;
    }

    if("Delivered".equalsIgnoreCase(order.getStatus())) {
        deliveredOrders++;
    }

    if(!"Delivered".equalsIgnoreCase(order.getStatus()) &&
            !"Cancelled".equalsIgnoreCase(order.getStatus())) {
        activeOrders++;
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="dashboard.jsp">Print<span>Ease</span></a>
        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active-link" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="upload.jsp">Upload</a></li>
                <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="tracking.jsp">Tracking</a></li>
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                <li class="nav-item"><a class="nav-link logout-btn" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="dashboard-section">
    <div class="container">
        <div class="welcome-card">
            <span class="section-label">User Dashboard</span>
            <h2>Welcome, <%= user.getFullName() %></h2>
            <p>Upload documents, complete payment, and track print delivery from one place.</p>
            <a href="upload.jsp" class="btn btn-light"><i class="bi bi-cloud-upload"></i> Upload New Document</a>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <a href="upload.jsp" class="action-card">
                    <i class="bi bi-cloud-upload"></i>
                    <h5>Upload Document</h5>
                </a>
            </div>
            <div class="col-md-3">
                <a href="orders.jsp" class="action-card">
                    <i class="bi bi-receipt"></i>
                    <h5>My Orders</h5>
                </a>
            </div>
            <div class="col-md-3">
                <a href="tracking.jsp" class="action-card">
                    <i class="bi bi-truck"></i>
                    <h5>Live Tracking</h5>
                </a>
            </div>
            <div class="col-md-3">
                <a href="profile.jsp" class="action-card">
                    <i class="bi bi-person-circle"></i>
                    <h5>Profile</h5>
                </a>
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-3"><div class="stats-card"><h3><%= totalOrders %></h3><p>Total Orders</p></div></div>
            <div class="col-md-3"><div class="stats-card"><h3><%= pendingOrders %></h3><p>Pending</p></div></div>
            <div class="col-md-3"><div class="stats-card"><h3><%= activeOrders %></h3><p>Active</p></div></div>
            <div class="col-md-3"><div class="stats-card"><h3>₹<%= String.format("%.0f", totalSpent) %></h3><p>Total Spent</p></div></div>
        </div>

        <div class="table-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="mb-0">Recent Orders</h4>
                <a href="orders.jsp" class="btn btn-sm btn-outline-primary">View All</a>
            </div>
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>File</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    int count = 0;
                    for(Order order : orders) {
                        if(count == 5) {
                            break;
                        }
                        count++;
                    %>
                        <tr>
                            <td>ORD<%= String.format("%03d", order.getId()) %></td>
                            <td><%= order.getFileName() %></td>
                            <td><span class="badge bg-primary"><%= order.getStatus() %></span></td>
                            <td><span class="badge bg-success"><%= order.getPaymentStatus() %></span></td>
                            <td>₹<%= String.format("%.2f", order.getTotalAmount()) %></td>
                        </tr>
                    <% } %>
                    <% if(orders.isEmpty()) { %>
                        <tr><td colspan="5" class="text-center text-muted">No orders yet. Upload your first document.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

