<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.dao.AdminDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.xeroxsystem.model.Order" %>
<%
AdminDAO adminDAO = new AdminDAO();

int totalUsers = adminDAO.getTotalUsers();
int totalOrders = adminDAO.getTotalOrders();
int pendingOrders = adminDAO.getPendingOrders();
int deliveredOrders = adminDAO.getDeliveredOrders();
double totalRevenue = adminDAO.getTotalRevenue();
int printingOrders = adminDAO.getPrintingOrders();

int packedOrders = adminDAO.getPackedOrders();

int outForDeliveryOrders =
        adminDAO.getOutForDeliveryOrders();

int cancelledOrders =
        adminDAO.getCancelledOrders();

int totalDocuments =
        adminDAO.getTotalDocuments();
List<Order> orders =adminDAO.getAllOrders();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard - PrintEase</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="css/admin-dashboard.css">

</head>
<body>
	<nav class="navbar navbar-expand-lg">

<div class="container">

<a class="navbar-brand" href="#">
Print<span>Ease</span> Admin
</a>

<div class="ms-auto">

<a href="index.jsp"
class="btn btn-primary">

Logout

</a>

</div>

</div>

</nav>

<section class="dashboard-section">

<div class="container">

<h2 class="mb-4">
Admin Dashboard
</h2>

<!-- Stats -->

<div class="row g-4 mb-5">

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= totalOrders %></h3>

<p>Total Orders</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3>₹<%= totalRevenue %></h3>

<p>Total Revenue</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= pendingOrders %></h3>

<p>Pending Orders</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= deliveredOrders %></h3>

<p>Delivered Orders</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= totalUsers %></h3>

<p>Total Users</p>

</div>
</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= printingOrders %></h3>

<p>Printing Orders</p>

</div>

</div>
<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= packedOrders %></h3>

<p>Packed Orders</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= outForDeliveryOrders %></h3>

<p>Out For Delivery</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= cancelledOrders %></h3>

<p>Cancelled Orders</p>

</div>

</div>

<div class="col-lg-3 col-md-4 col-sm-6">

<div class="stats-card">

<h3><%= totalDocuments %></h3>

<p>Documents Uploaded</p>

</div>

</div>

</div>

</div>

<!-- Orders Table -->

<!-- Orders Table -->

<div class="card-box mb-4">

    <h4>Recent Orders</h4>

    <div class="table-responsive">

        <table class="table">

            <thead>

                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Amount</th>
                    <th>Document</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>

            </thead>

            <tbody>

            <%
            for(Order o : orders){
            %>

                <tr>

                    <td>ORD<%= o.getId() %></td>

                    <td><%= o.getUserName() %></td>

                    <td>₹<%= o.getTotalAmount() %></td>
                    
                    <td>

						<a href="uploads/<%= o.getFileName() %>"
   							target="_blank"
   							class="btn btn-info btn-sm">
							View File
							
							
						</a> &nbsp; &nbsp;
						<a href="uploads/<%= o.getFileName() %>"
       						download
       						class="btn btn-secondary btn-sm">
       						Download
    						</a>
    						<a href="deleteOrder?id=<%= o.getId() %>"
   							class="btn btn-danger btn-sm"
   							onclick="return confirm('Delete this order?')">
   							Delete
						</a>

					</td>

                <td>

<form action="updateOrderStatus"
      method="post"
      class="d-flex gap-2">

<input type="hidden"
       name="id"
       value="<%= o.getId() %>">

<select name="status"
        class="form-select">

<option value="Pending"
<%= o.getStatus().equals("Pending") ? "selected" : "" %>>
Pending
</option>

<option value="Printing"
<%= o.getStatus().equals("Printing") ? "selected" : "" %>>
Printing
</option>

<option value="Packed"
<%= o.getStatus().equals("Packed") ? "selected" : "" %>>
Packed
</option>

<option value="Out For Delivery"
<%= o.getStatus().equals("Out For Delivery") ? "selected" : "" %>>
Out For Delivery
</option>

<option value="Delivered"
<%= o.getStatus().equals("Delivered") ? "selected" : "" %>>
Delivered
</option>

<option value="Cancelled"
<%= o.getStatus().equals("Cancelled") ? "selected" : "" %>>
Cancelled
</option>

</select>

<button type="submit"
        class="btn btn-success btn-sm">

Update

</button>

</form>

</td>    

                </tr>

            <%
            }
            %>

            </tbody>

        </table>

    </div>

</div>



<!-- Users Table -->

<div class="card-box mb-4">

<h4>Registered Users</h4>

<div class="table-responsive">

<table class="table">

<thead>

<tr>

<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<tr>
    <td>Sakshi Santosh Pawar</td>
    <td>sakshipawar72004@gmail.com</td>
    <td>9307174929</td>

    <td>
        <button class="btn btn-danger btn-sm">
            Delete
        </button>
    </td>
</tr>

</tbody>

</table>

</div>

</div>

<!-- Price Settings -->

<div class="card-box">

<h4>Print Price Settings</h4>

<div class="row">

<div class="col-md-4">

<label>B/W Price (per page)</label>

<input type="number"
class="form-control"
value="2">

</div>

<div class="col-md-4">

<label>Color Price (per page)</label>

<input type="number"
class="form-control"
value="5">

</div>

<div class="col-md-4">

<label>Delivery Charge</label>

<input type="number"
class="form-control"
value="20">

</div>

</div>

<button class="btn btn-primary mt-4">

Save Settings

</button>

</div>

</div>

</section>
</body>
</html>