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
    response.sendRedirect("orders.jsp");
    return;
}

boolean homeDelivery =
        order.getDeliveryAddress() != null &&
        !order.getDeliveryAddress().trim().isEmpty() &&
        !"Self Pickup".equalsIgnoreCase(order.getDeliveryAddress()) &&
        !"Self Pickup".equalsIgnoreCase(order.getDeliveryType());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Payment - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/payment.css">
</head>
<body>
<nav class="navbar navbar-expand-lg app-navbar">
    <div class="container">
        <a class="navbar-brand" href="dashboard.jsp">Print<span>Ease</span></a>
        <a href="orders.jsp" class="btn btn-outline-light btn-sm">My Orders</a>
    </div>
</nav>

<section class="payment-section">
    <div class="container">
        <div class="row g-4 align-items-start">
            <div class="col-lg-7">
                <div class="payment-panel">
                    <div class="section-label">Secure Checkout</div>
                    <h2>Complete Payment</h2>
                    <p class="text-muted">Choose a payment mode to confirm your print order.</p>

                    <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger">Payment could not be saved. Please try again.</div>
                    <% } %>

                    <form action="payment" method="post">
                        <input type="hidden" name="orderId" value="<%= order.getId() %>">

                        <div class="payment-options">
                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="UPI" checked>
                                <span><i class="bi bi-phone"></i> UPI Payment</span>
                                <small>Google Pay, PhonePe, Paytm demo</small>
                            </label>

                            <label class="payment-option">
                                <input type="radio" name="paymentMethod" value="Card">
                                <span><i class="bi bi-credit-card"></i> Debit/Credit Card</span>
                                <small>Academic demo card payment</small>
                            </label>

                            <% if(homeDelivery) { %>
                                <label class="payment-option">
                                    <input type="radio" name="paymentMethod" value="COD">
                                    <span><i class="bi bi-wallet2"></i> Cash on Delivery</span>
                                    <small>Pay when documents are delivered</small>
                                </label>
                            <% } else { %>
                                <label class="payment-option">
                                    <input type="radio" name="paymentMethod" value="Pay at Shop">
                                    <span><i class="bi bi-shop"></i> Pay at Shop</span>
                                    <small>Pay while collecting your print order</small>
                                </label>
                            <% } %>
                        </div>

                        <button type="submit" class="btn pay-btn mt-4">
                            Pay ₹<%= String.format("%.2f", order.getTotalAmount()) %>
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="summary-panel">
                    <h4>Order Summary</h4>
                    <div class="summary-row">
                        <span>Order ID</span>
                        <strong>ORD<%= String.format("%03d", order.getId()) %></strong>
                    </div>
                    <div class="summary-row">
                        <span>File</span>
                        <strong><%= order.getFileName() %></strong>
                    </div>
                    <div class="summary-row">
                        <span>Copies</span>
                        <strong><%= order.getCopies() %></strong>
                    </div>
                    <div class="summary-row">
                        <span>Pages</span>
                        <strong><%= order.getPages() %></strong>
                    </div>
                    <div class="summary-row">
                        <span>Print</span>
                        <strong><%= "5".equals(order.getPrintType()) ? "Color" : "Black & White" %></strong>
                    </div>
                    <div class="summary-row">
                        <span>Expected Delivery</span>
                        <strong><%= "-".equals(order.getExpectedDelivery()) ? "Self Pickup" : order.getExpectedDelivery() %></strong>
                    </div>
                    <hr>
                    <div class="summary-total">
                        <span>Total</span>
                        <strong>₹<%= String.format("%.2f", order.getTotalAmount()) %></strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
