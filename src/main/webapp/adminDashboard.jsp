<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.dao.AdminDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.xeroxsystem.model.Order" %>
<%@ page import="com.xeroxsystem.model.User" %>
<%
User loggedUser = (User) session.getAttribute("loggedUser");

if(loggedUser == null || !"ADMIN".equalsIgnoreCase(loggedUser.getRole())) {
    response.sendRedirect("login.jsp");
    return;
}

AdminDAO adminDAO = new AdminDAO();

int totalUsers = adminDAO.getTotalUsers();
int totalOrders = adminDAO.getTotalOrders();
int pendingOrders = adminDAO.getPendingOrders();
int deliveredOrders = adminDAO.getDeliveredOrders();
double totalRevenue = adminDAO.getTotalRevenue();
int printingOrders = adminDAO.getPrintingOrders();
int packedOrders = adminDAO.getPackedOrders();
int outForDeliveryOrders = adminDAO.getOutForDeliveryOrders();
int cancelledOrders = adminDAO.getCancelledOrders();
int totalDocuments = adminDAO.getTotalDocuments();
List<Order> orders = adminDAO.getAllOrders();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/admin-dashboard.css">
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="adminDashboard.jsp">Print<span>Ease</span> Admin</a>
        <div class="ms-auto">
            <a href="logout" class="btn btn-primary">Logout</a>
        </div>
    </div>
</nav>

<section class="dashboard-section">
    <div class="container">
        <div class="admin-header">
            <span class="section-label">Shop Control Panel</span>
            <h2>Admin Dashboard</h2>
            <p>Manage print orders, payments, delivery tracking, and uploaded documents.</p>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= totalOrders %></h3><p>Total Orders</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3>₹<%= String.format("%.0f", totalRevenue) %></h3><p>Total Revenue</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= pendingOrders %></h3><p>Pending Orders</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= deliveredOrders %></h3><p>Delivered Orders</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= totalUsers %></h3><p>Total Users</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= printingOrders %></h3><p>Printing</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= packedOrders %></h3><p>Packed</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= outForDeliveryOrders %></h3><p>Out For Delivery</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= cancelledOrders %></h3><p>Cancelled</p></div></div>
            <div class="col-lg-3 col-md-4 col-sm-6"><div class="stats-card"><h3><%= totalDocuments %></h3><p>Documents</p></div></div>
        </div>

        <div class="card-box mb-4">
            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <h4 class="mb-0">All Orders</h4>
                <input type="text" id="adminSearch" class="form-control admin-search" placeholder="Search orders">
            </div>

            <div class="table-responsive">
                <table class="table align-middle" id="adminOrdersTable">
                    <thead>
                        <tr>
                            <th>Order</th>
                            <th>User</th>
                            <th>Document</th>
                            <th>Pages</th>
                            <th>Amount</th>
                            <th>Payment</th>
                            <th>Transaction</th>
                            <th>Status</th>
                            <th>Files</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for(Order o : orders) { %>
                        <tr>
                            <td>ORD<%= String.format("%03d", o.getId()) %></td>
                            <td><%= o.getUserName() %></td>
                            <td><%= o.getFileName() %></td>
                            <td><%= o.getPages() %></td>
                            <td>₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                            <td>
                                <span class="badge <%= "Paid".equalsIgnoreCase(o.getPaymentStatus()) ? "bg-success" : (("COD".equalsIgnoreCase(o.getPaymentStatus()) || "Pay at Shop".equalsIgnoreCase(o.getPaymentStatus())) ? "bg-primary" : "bg-danger") %>">
                                    <%= o.getPaymentStatus() %>
                                </span>
                                <small class="d-block text-muted"><%= o.getPaymentMethod() %></small>
                            </td>
                            <td>
                                <%= "COD".equalsIgnoreCase(o.getPaymentStatus()) ? "Payment on delivery" :
                                ("Pay at Shop".equalsIgnoreCase(o.getPaymentStatus()) ? "Payment at shop" :
                                (o.getTransactionId() == null ? "-" : o.getTransactionId())) %>
                            </td>
                            <td>
                                <form action="updateOrderStatus" method="post" class="status-form">
                                    <input type="hidden" name="id" value="<%= o.getId() %>">
                                    <select name="status" class="form-select form-select-sm">
                                        <option value="Pending" <%= "Pending".equals(o.getStatus()) ? "selected" : "" %>>Pending</option>
                                        <option value="Printing" <%= "Printing".equals(o.getStatus()) ? "selected" : "" %>>Printing</option>
                                        <option value="Packed" <%= "Packed".equals(o.getStatus()) ? "selected" : "" %>>Packed</option>
                                        <option value="Out For Delivery" <%= "Out For Delivery".equals(o.getStatus()) ? "selected" : "" %>>Out For Delivery</option>
                                        <option value="Delivered" <%= "Delivered".equals(o.getStatus()) ? "selected" : "" %>>Delivered</option>
                                        <option value="Cancelled" <%= "Cancelled".equals(o.getStatus()) ? "selected" : "" %>>Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-success btn-sm">Update</button>
                                </form>
                            </td>
                            <td class="file-actions">
                                <a href="uploads/<%= o.getFileName() %>" target="_blank" class="btn btn-info btn-sm">View</a>
                                <a href="uploads/<%= o.getFileName() %>" download class="btn btn-secondary btn-sm">Download</a>
                                <a href="deleteOrder?id=<%= o.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this order?')">Delete</a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card-box">
            <h4>Print Price Settings</h4>
            <form action="updatePrices" method="post">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label>B/W Price Per Page</label>
                        <input type="number" name="bwPrice" class="form-control" value="2">
                    </div>
                    <div class="col-md-4">
                        <label>Color Price Per Page</label>
                        <input type="number" name="colorPrice" class="form-control" value="5">
                    </div>
                    <div class="col-md-4">
                        <label>Delivery Charge</label>
                        <input type="number" name="deliveryCharge" class="form-control" value="20">
                    </div>
                </div>
                <button class="btn btn-primary mt-4">Save Settings</button>
            </form>
        </div>
    </div>
</section>

<script>
document.getElementById("adminSearch").addEventListener("input", function() {
    const search = this.value.toLowerCase();
    document.querySelectorAll("#adminOrdersTable tbody tr").forEach(row => {
        row.style.display = row.innerText.toLowerCase().includes(search) ? "" : "none";
    });
});
</script>
</body>
</html>
