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

OrderDAO dao = new OrderDAO();
Order order = dao.getOrderById(Integer.parseInt(request.getParameter("id")));

if(order == null || order.getUserId() != user.getId()) {
    response.sendRedirect("orders.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment Success - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/payment.css">
</head>
<body>
<section class="success-section">
    <div class="success-card">
        <div class="success-icon">
            <i class="bi bi-check2"></i>
        </div>
        <h2>Order Confirmed</h2>
        <p>Your payment details have been saved and your print order is now in the queue.</p>

        <div class="receipt-box">
            <div><span>Order ID</span><strong>ORD<%= String.format("%03d", order.getId()) %></strong></div>
            <div><span>Payment Status</span><strong><%= order.getPaymentStatus() %></strong></div>
            <div><span>Payment Method</span><strong><%= order.getPaymentMethod() %></strong></div>
            <div>
                <span>Transaction ID</span>
                <strong>
                    <%= "COD".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment on delivery" :
                    ("Pay at Shop".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment at shop" : order.getTransactionId()) %>
                </strong>
            </div>
            <div><span>Amount</span><strong>₹<%= String.format("%.2f", order.getTotalAmount()) %></strong></div>
        </div>

        <div class="d-flex gap-2 justify-content-center flex-wrap mt-4">
            <a href="tracking.jsp?id=<%= order.getId() %>" class="btn btn-primary">Track Order</a>
            <a href="orders.jsp" class="btn btn-outline-secondary">My Orders</a>
        </div>
    </div>
</section>
</body>
</html>
