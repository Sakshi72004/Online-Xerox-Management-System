<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.dao.OrderDAO" %>
<%@ page import="com.xeroxsystem.model.Order" %>
<%@ page import="com.xeroxsystem.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");

if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}

String idParam = request.getParameter("id");
Order order = null;

if(idParam != null && !idParam.isEmpty()) {
    OrderDAO dao = new OrderDAO();
    order = dao.getOrderById(Integer.parseInt(idParam));

    if(order != null && order.getUserId() != user.getId()) {
        order = null;
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% if(order != null && !"Delivered".equalsIgnoreCase(order.getStatus()) && !"Cancelled".equalsIgnoreCase(order.getStatus())) { %>
<meta http-equiv="refresh" content="8">
<% } %>
<title>Track Order - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/tracking.css">
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
                <li class="nav-item"><a class="nav-link" href="dashboard.jsp">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="upload.jsp">Upload</a></li>
                <li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a></li>
                <li class="nav-item"><a class="nav-link active-link" href="tracking.jsp">Tracking</a></li>
                <li class="nav-item"><a class="nav-link logout-btn" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="tracking-section">
    <div class="container">
        <div class="track-card">
            <span class="section-label">Live Tracking</span>
            <h2>Track Your Order</h2>
            <p>Enter your order number or open tracking directly from My Orders.</p>
            <form action="tracking.jsp" method="get">
                <div class="input-group mt-4">
                    <input type="number" name="id" class="form-control" placeholder="Enter Order ID, example 1" required>
                    <button type="submit" class="btn track-btn">Track Order</button>
                </div>
            </form>
        </div>

        <% if(order != null) { 
            String status = order.getStatus();
            boolean cancelled = "Cancelled".equalsIgnoreCase(status);
            boolean homeDelivery =
            	    order.getDeliveryAddress() != null &&
            	    !order.getDeliveryAddress().trim().isEmpty() &&
            	    !"Self Pickup".equalsIgnoreCase(order.getDeliveryAddress()) &&
            	    !"Self Pickup".equalsIgnoreCase(order.getDeliveryType());
        %>
        
        <div class="details-card">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
            
                <div>
                    <h4>ORD<%= String.format("%03d", order.getId()) %></h4>
                    <p class="mb-0"><%= order.getFileName() %></p>
                </div>
                <div class="text-lg-end">
                    <span class="badge bg-dark"><%= status %></span>
                    <span class="badge bg-success"><%= order.getPaymentStatus() %></span>
                </div>
            </div>

            <div class="row mt-4 g-3">
                <div class="col-md-4"><strong>Amount</strong><p>₹<%= String.format("%.2f", order.getTotalAmount()) %></p></div>
                <div class="col-md-4"><strong>Copies</strong><p><%= order.getCopies() %></p></div>
                <div class="col-md-4"><strong>Pages</strong><p><%= order.getPages() %></p></div>
                <div class="col-md-4"><strong>Order Type</strong><p><%= homeDelivery ? "Home Delivery" : "Self Pickup" %></p></div>
                <% if(homeDelivery) { %>
                <div class="col-md-4"><strong>Expected Delivery</strong><p><%= order.getExpectedDelivery() %></p></div>
                <% } %>
                <div class="col-md-4"><strong>Print Type</strong><p><%= "5".equals(order.getPrintType()) ? "Color" : "Black & White" %></p></div>
                <div class="col-md-4"><strong>Print Side</strong><p><%= order.getPrintSide() %></p></div>
                <div class="col-md-4">
                    <strong>Transaction ID</strong>
                    <p>
                        <%= "COD".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment on delivery" :
                        ("Pay at Shop".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment at shop" :
                        (order.getTransactionId() == null ? "-" : order.getTransactionId())) %>
                    </p>
                </div>
            </div>
        </div>
        <% if(cancelled) { %>
        <div class="alert alert-danger mt-4">
            <strong>Order Cancelled.</strong> This order is no longer active.
        </div>
        <% } else { %>
        <div class="timeline-card">
            <h4 class="mb-4">Order Progress</h4>
            <div class="timeline">
                <% if(homeDelivery) { %>

    <!-- Home Delivery Timeline -->

    <div class="timeline-step completed">
        <i class="bi bi-check-circle-fill"></i>
        <span>Order Placed</span>
    </div>

    <div class="timeline-step <%= ("Printing".equals(status) || "Packed".equals(status) || "Out For Delivery".equals(status) || "Delivered".equals(status)) ? "completed" : "" %>">
        <i class="bi bi-printer-fill"></i>
        <span>Printing</span>
    </div>

    <div class="timeline-step <%= ("Packed".equals(status) || "Out For Delivery".equals(status) || "Delivered".equals(status)) ? "completed" : "" %>">
        <i class="bi bi-box2-heart-fill"></i>
        <span>Packed</span>
    </div>

    <div class="timeline-step <%= ("Out For Delivery".equals(status)) ? "active" : ("Delivered".equals(status) ? "completed" : "") %>">
        <i class="bi bi-truck"></i>
        <span>Out For Delivery</span>
    </div>

    <div class="timeline-step <%= "Delivered".equals(status) ? "completed" : "" %>">
        <i class="bi bi-house-check-fill"></i>
        <span>Delivered</span>
    </div>

<% } else { %>

    <!-- Self Pickup Timeline -->

    <div class="timeline-step completed">
        <i class="bi bi-check-circle-fill"></i>
        <span>Order Placed</span>
    </div>

    <div class="timeline-step <%= ("Printing".equals(status) || "Ready For Pickup".equals(status) || "Collected".equals(status)) ? "completed" : "" %>">
        <i class="bi bi-printer-fill"></i>
        <span>Printing</span>
    </div>

    <div class="timeline-step <%= ("Ready For Pickup".equals(status)) ? "active" : ("Collected".equals(status) ? "completed" : "") %>">
        <i class="bi bi-box-seam-fill"></i>
        <span>Ready For Pickup</span>
    </div>

    <div class="timeline-step <%= "Collected".equals(status) ? "completed" : "" %>">
        <i class="bi bi-bag-check-fill"></i>
        <span>Collected</span>
    </div>

<% } %>
            </div>
            <p class="refresh-note">This page refreshes automatically while your order is active.</p>
        </div>
        <% } %>
        <% } else { %>
        <div class="details-card">
            <h4>No Order Selected</h4>
            <p>Please enter a valid order id or open Tracking from the Orders page.</p>
        </div>
        <% } %>
    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


