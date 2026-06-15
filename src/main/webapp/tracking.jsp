<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.dao.OrderDAO" %>
<%@ page import="com.xeroxsystem.model.Order" %>
<%
String idParam = request.getParameter("id");

Order order = null;

if(idParam != null && !idParam.isEmpty()){

    int orderId =
            Integer.parseInt(idParam);

    OrderDAO dao =
            new OrderDAO();

    order =
            dao.getOrderById(orderId);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Track Order - PrintEase</title>

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

    <link rel="stylesheet" href="css/tracking.css">
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
                            href="dashboard.jsp">Dashboard</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                            href="upload.jsp">Upload</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link active-link"
                            href="tracking.jsp">Tracking</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link logout-btn"
                            href="index.jsp">Logout</a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Tracking Section -->

    <section class="tracking-section">

        <div class="container">

            <!-- Search Card -->

            <div class="track-card">

                <h2>Track Your Order 🚚</h2>

                <p>
                    Enter your Order ID to view printing and delivery status.
                </p>

                <form action="tracking.jsp" method="get">

    <div class="input-group mt-4">

        <input type="number"
            name="id"
            class="form-control"
            placeholder="Enter Order ID (e.g. 1)"
            required>

        <button type="submit"
            class="btn track-btn">

            Track Order

        </button>

    </div>

</form>

            </div>

            <!-- Order Details -->
			<%if(order != null){%>
			
            <div class="details-card">

                <h4>Order Details</h4>

                <div class="row mt-3">

                    <div class="col-md-6">
                        <p><strong>Order ID:</strong>  ORD<%= String.format("%03d", order.getId()) %></p>
                        <p><strong>Copies:</strong> <%= order.getCopies() %></p>
                    </div>

                    <div class="col-md-6">
                        <p><strong>Amount:</strong> ₹<%= order.getTotalAmount() %></p>
                        <p><strong>Status:</strong> <%= order.getStatus() %></p>
                    </div>
                    
                    <div class="col-md-6">
                    <p><strong>File Name:</strong><%= order.getFileName() %></p>
                    <p><strong>Print Type:</strong><%= order.getPrintType().equals("2")? "Color Print": "Black & White" %></p>
                    </div>
					
					<div class="col-md-6">
					<p><strong>Print Side:</strong><%= order.getPrintSide() %></p>
					<p><strong>Delivery Address:</strong><%= order.getDeliveryAddress() %></p>
					</div>

                </div>

            </div>

            <!-- Timeline -->
			<% if(!order.getStatus().equals("Cancelled")) { %>
			<div class="alert alert-danger mt-3">
    <strong>Order Cancelled!</strong>
    This order has been cancelled.
</div>
            <div class="timeline-card">

                <h4 class="mb-4">
                    Order Progress
                </h4>
                <%String status = order.getStatus();%>

 				<div class="timeline">

    <!-- Order Placed -->
    <div class="timeline-step completed">

        <i class="bi bi-check-circle-fill"></i>

        <span>Order Placed</span>

    </div>

    <!-- Printing -->
    <div class="timeline-step <%= (
        status.equals("Printing") ||
        status.equals("Packed") ||
        status.equals("Out For Delivery") ||
        status.equals("Delivered")
    ) ? "completed" : "" %>">

        <i class="bi bi-check-circle-fill"></i>

        <span>Printing</span>

    </div>

    <!-- Packed -->
    <div class="timeline-step <%= (
        status.equals("Packed") ||
        status.equals("Out For Delivery") ||
        status.equals("Delivered")
    ) ? "completed" : "" %>">

        <i class="bi bi-check-circle-fill"></i>

        <span>Packed</span>

    </div>

    <!-- Out For Delivery -->
    <div class="timeline-step <%= (
    status.equals("Delivered")
) ? "completed" :
(
    status.equals("Out For Delivery")
) ? "active" : "" %>">

        <%
if(status.equals("Delivered")){
%>

<i class="bi bi-check-circle-fill"></i>

<%
}else{
%>

<i class="bi bi-truck"></i>

<%
}
%>

        <span>Out For Delivery</span>

    </div>

    <!-- Delivered -->
    <div class="timeline-step <%= (
        status.equals("Delivered")
    ) ? "completed" : "" %>">

        <i class="bi bi-check-circle-fill"></i>

        <span>Delivered</span>

    </div>

</div>

            </div>
            <% } %>
            
<%
}
else{
%>

<div class="details-card">

    <h4>No Order Selected</h4>

    <p>
        Please open Tracking from the Orders page.
    </p>

</div>

<%
}
%>

        </div>

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>