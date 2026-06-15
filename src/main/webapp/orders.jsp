<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="com.xeroxsystem.dao.OrderDAO" %>
<%@ page import="com.xeroxsystem.model.Order" %> 
   
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders - PrintEase</title>

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

    <link rel="stylesheet" href="css/orders.css">
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
                        <a class="nav-link active-link"
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
                        <a class="nav-link logout-btn"
                            href="index.jsp">
                            Logout
                        </a>
                    </li>

                </ul>

            </div>

        </div>

    </nav>

    <!-- Orders Section -->

    <section class="orders-section">

        <div class="container">

            <!-- Page Title -->

            <div class="page-header">

                <h2>My Orders 📦</h2>

                <p>
                    View and manage all your printing orders.
                </p>

            </div>

            <!-- Search -->

            <div class="search-card">

                <input type="text"
                    class="form-control"
                    placeholder="Search Order ID...">

            </div>

            <!-- Orders Table -->

            <div class="table-card">

                <div class="table-responsive">

                    <table class="table align-middle">

                        <thead>

                            <tr>

                                <th>Order ID</th>
								<th>Date</th>
								<th>File Name</th>
								<th>Amount</th>
								<th>Status</th>
								<th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

<%
    OrderDAO dao = new OrderDAO();

    List<Order> orders = dao.getAllOrders();

    for(Order o : orders) {
%>

<tr>

    <td>ORD<%= String.format("%03d", o.getId()) %></td>

    <td>--</td>

    <td><%= o.getFileName() %></td>

    <td>₹<%= o.getTotalAmount() %></td>

    <td>
	<%
String status = o.getStatus();

if("Pending".equalsIgnoreCase(status)){
%>

<span class="badge bg-warning">
    Pending
</span>

<%
}
else if("Printing".equalsIgnoreCase(status)){
%>

<span class="badge bg-info">
    Printing
</span>

<%
}
else if("Packed".equalsIgnoreCase(status)){
%>

<span class="badge bg-primary">
    Packed
</span>

<%
}
else if("Out For Delivery".equalsIgnoreCase(status)){
%>

<span class="badge bg-secondary">
    Out For Delivery
</span>

<%
}
else if("Delivered".equalsIgnoreCase(status)){
%>

<span class="badge bg-success">
    Delivered
</span>

<%
}
else if("Cancelled".equalsIgnoreCase(status)){
%>

<span class="badge bg-danger">
    Cancelled
</span>

<%
}
%>

    </td>

    <td>

        <a href="tracking.jsp?id=<%=o.getId()%>"
   			class="btn btn-sm btn-primary">
    			Track
		</a>
		<a href="invoice.jsp?id=<%=o.getId()%>"
       		class="btn btn-sm btn-success">
        		Invoice
    		</a>
    		
    		<% if(o.getStatus().equals("Pending")) { %>

		<a href="cancelOrder?id=<%=o.getId()%>"
   			class="btn btn-sm btn-danger"
   			onclick="return confirm('Cancel this order?');">

   			Cancel

		</a>

<% } %>

    </td>

</tr>

<%
    }
%>

</tbody>

                    </table>

                </div>

            </div>

        </div>

    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>