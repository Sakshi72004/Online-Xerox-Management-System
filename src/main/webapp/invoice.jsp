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
}

if(order == null || order.getUserId() != user.getId()) {
    out.println("<h2>Invoice Not Found</h2>");
    return;
}

boolean homeDelivery =
        order.getDeliveryAddress() != null &&
        !order.getDeliveryAddress().trim().isEmpty() &&
        !"Self Pickup".equalsIgnoreCase(order.getDeliveryAddress()) &&
        !"Self Pickup".equalsIgnoreCase(order.getDeliveryType());

double total = order.getTotalAmount();
double subtotal = total / 1.05;
double gst = total - subtotal;

String transactionText =
        "COD".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment on delivery" :
        ("Pay at Shop".equalsIgnoreCase(order.getPaymentStatus()) ? "Payment at shop" :
        (order.getTransactionId() == null ? "-" : order.getTransactionId()));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Invoice - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/invoice.css">
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="dashboard.jsp">Print<span>Ease</span></a>
        <div class="ms-auto">
            <a href="orders.jsp" class="btn btn-light">Back to Orders</a>
        </div>
    </div>
</nav>

<section class="invoice-section">
    <div class="container">
        <div class="invoice-card">
            <div class="invoice-header">
                <div>
                    <h2>Invoice</h2>
                    <p>Invoice No: INV<%= String.format("%03d", order.getId()) %></p>
                    <p>Date: <%= order.getOrderDate() == null ? "-" : order.getOrderDate() %></p>
                </div>
                <div class="text-end">
                    <h3>PrintEase</h3>
                    <p>Pune, Maharashtra</p>
                    <p>support@printease.com</p>
                </div>
            </div>

            <hr>

            <div class="row mb-4">
                <div class="col-md-6">
                    <h5>Customer Details</h5>
                    <p><strong>Name:</strong> <%= user.getFullName() %></p>
                    <p><strong>Email:</strong> <%= user.getEmail() %></p>
                    <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                </div>

                <div class="col-md-6">
                    <h5>Order Type</h5>
                    <p><%= homeDelivery ? "Home Delivery" : "Self Pickup" %></p>
                    <% if(homeDelivery) { %>
                    <p><strong>Address:</strong> <%= order.getDeliveryAddress() %></p>
                    <p><strong>Expected Delivery:</strong> <%= order.getExpectedDelivery() %></p>
                    <% } %>
                </div>
            </div>

            <h5>Order Details</h5>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Document</th>
                            <th>Pages</th>
                            <th>Copies</th>
                            <th>Print Type</th>
                            <th>Print Side</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= order.getFileName() %></td>
                            <td><%= order.getPages() %></td>
                            <td><%= order.getCopies() %></td>
                            <td><%= "5".equals(order.getPrintType()) ? "Color Print" : "Black & White" %></td>
                            <td><%= order.getPrintSide() %></td>
                            <td>₹<%= String.format("%.2f", total) %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <h5>Payment Details</h5>
            <div class="summary-box mb-4">
                <div class="summary-row">
                    <span>Payment Status</span>
                    <span><%= order.getPaymentStatus() %></span>
                </div>
                <div class="summary-row">
                    <span>Payment Method</span>
                    <span><%= order.getPaymentMethod() %></span>
                </div>
                <div class="summary-row">
                    <span>Transaction</span>
                    <span><%= transactionText %></span>
                </div>
            </div>

            <div class="summary-box">
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<%= String.format("%.2f", subtotal) %></span>
                </div>
                <div class="summary-row">
                    <span>GST (5%)</span>
                    <span>₹<%= String.format("%.2f", gst) %></span>
                </div>
                <hr>
                <div class="summary-total">
                    <span>Grand Total</span>
                    <span>₹<%= String.format("%.2f", total) %></span>
                </div>
            </div>

            <div class="text-center mt-4">
                <button onclick="window.print()" class="btn btn-primary me-2">
                    <i class="bi bi-printer"></i> Print Invoice
                </button>
                <a href="downloadInvoice?id=<%= order.getId() %>" class="btn btn-success">
                    Download PDF
                </a>
            </div>
        </div>
    </div>
</section>
</body>
</html>
