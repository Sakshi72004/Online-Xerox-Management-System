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

OrderDAO dao = new OrderDAO();
List<Order> orders = dao.getOrdersByUser(user.getId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/orders.css">
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
                <li class="nav-item"><a class="nav-link active-link" href="orders.jsp">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="tracking.jsp">Tracking</a></li>
                <li class="nav-item"><a class="nav-link logout-btn" href="logout">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<section class="orders-section">
    <div class="container">
        <div class="page-header">
            <div>
                <span class="section-label">Print History</span>
                <h2>My Orders</h2>
                <p>View payments, invoices, cancellation, and live order status.</p>
            </div>
            <a href="upload.jsp" class="btn btn-primary"><i class="bi bi-cloud-upload"></i> New Order</a>
        </div>

        <div class="search-card">
            <i class="bi bi-search"></i>
            <input type="text" id="orderSearch" class="form-control" placeholder="Search by order id, file, status, or payment">
        </div>

        <div class="table-card">
            <div class="table-responsive">
                <table class="table align-middle" id="ordersTable">
                    <thead>
                        <tr>
                            <th>Order</th>
                            <th>Date</th>
                            <th>File</th>
                            <th>Pages</th>
                            <th>Amount</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for(Order o : orders) { %>
                        <tr>
                            <td><strong>ORD<%= String.format("%03d", o.getId()) %></strong></td>
                            <td><%= o.getOrderDate() == null ? "-" : o.getOrderDate() %></td>
                            <td><%= o.getFileName() %></td>
                            <td><%= o.getPages() %></td>
                            <td>₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                            <td>
                                <% if("Paid".equalsIgnoreCase(o.getPaymentStatus())) { %>
                                    <span class="badge bg-success">Paid</span>
                                <% } else if("COD".equalsIgnoreCase(o.getPaymentStatus())) { %>
                                    <span class="badge bg-primary">COD</span>
                                <% } else if("Pay at Shop".equalsIgnoreCase(o.getPaymentStatus())) { %>
                                    <span class="badge bg-primary">Pay at Shop</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Unpaid</span>
                                <% } %>
                            </td>
                            <td>
                                <% String status = o.getStatus(); %>
                                <% if("Pending".equalsIgnoreCase(status)) { %>
                                    <span class="badge bg-warning text-dark">Pending</span>
                                <% } else if("Printing".equalsIgnoreCase(status)) { %>
                                    <span class="badge bg-info text-dark">Printing</span>
                                <% } else if("Packed".equalsIgnoreCase(status)) { %>
                                    <span class="badge bg-primary">Packed</span>
                                <% } else if("Out For Delivery".equalsIgnoreCase(status)) { %>
                                    <span class="badge bg-secondary">Out For Delivery</span>
                                <% } else if("Delivered".equalsIgnoreCase(status)) { %>
                                    <span class="badge bg-success">Delivered</span>
                                <% } else { %>
                                    <span class="badge bg-danger">Cancelled</span>
                                <% } %>
                            </td>
                            <td class="action-cell">
                                <% if(!"Paid".equalsIgnoreCase(o.getPaymentStatus()) &&
                                        !"COD".equalsIgnoreCase(o.getPaymentStatus()) &&
                                        !"Pay at Shop".equalsIgnoreCase(o.getPaymentStatus())) { %>
                                    <a href="payment.jsp?id=<%= o.getId() %>" class="btn btn-sm btn-warning">Pay</a>
                                <% } %>
                                <a href="tracking.jsp?id=<%= o.getId() %>" class="btn btn-sm btn-primary">Track</a>
                                <a href="invoice.jsp?id=<%= o.getId() %>" class="btn btn-sm btn-success">Invoice</a>
                                <% if("Pending".equalsIgnoreCase(o.getStatus())) { %>
                                    <a href="cancelOrder?id=<%= o.getId() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Cancel this order?');">Cancel</a>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<script>
document.getElementById("orderSearch").addEventListener("input", function() {
    const search = this.value.toLowerCase();
    document.querySelectorAll("#ordersTable tbody tr").forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(search) ? "" : "none";
    });
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

