<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.xeroxsystem.dao.OrderDAO"%>
<%@page import="com.xeroxsystem.model.Order"%>
<%@ page import="com.xeroxsystem.model.User" %>
<%
String idParam = request.getParameter("id");

Order order = null;

if(idParam != null){

    int id = Integer.parseInt(idParam);

    OrderDAO dao = new OrderDAO();

    order = dao.getOrderById(id);
    
    if(order == null){
        out.println("<h2>Invoice Not Found</h2>");
        return;
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Invoice - PrintEase</title>

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

    <link rel="stylesheet" href="css/invoice.css">
</head>
<body>
	<!-- Navbar -->

    <nav class="navbar navbar-expand-lg">

        <div class="container">

            <a class="navbar-brand" href="#">
                Print<span>Ease</span>
            </a>

            <div class="ms-auto">

                <a href="dashboard.jsp" class="btn btn-light">
                    Back to Dashboard
                </a>

            </div>

        </div>

    </nav>

    <!-- Invoice -->

    <section class="invoice-section">

        <div class="container">

            <div class="invoice-card">

                <!-- Header -->

                <div class="invoice-header">

                    <div>

                        <h2>Invoice</h2>

                        <p>Invoice No: INV<%= String.format("%03d", order.getId()) %></p>

                        <p>Date: 21-05-2026</p>

                    </div>

                    <div class="text-end">

                        <h3>PrintEase</h3>

                        <p>Pune, Maharashtra</p>

                        <p>support@printease.com</p>

                    </div>

                </div>

                <hr>

                <!-- Customer Details -->

                <div class="row mb-4">

                    <div class="col-md-6">

                        <h5>Customer Details</h5>

<%
User user =
    (User)session.getAttribute("loggedUser");

if(user == null){
%>

<p><strong>Name:</strong> Guest User</p>
<p><strong>Email:</strong> Not Available</p>

<%
}else{
%>

<p>
    <strong>Name:</strong>
    <%= user.getFullName() %>
</p>

<p>
    <strong>Email:</strong>
    <%= user.getEmail() %>
</p>

<%
}
%>               
                    </div>

                    <div class="col-md-6">

                        <h5>Delivery Address</h5>

                        <p>
                            <%= order.getDeliveryAddress() %>
                            
                        </p>

                    </div>

                </div>

                <!-- Order Details -->

                <h5>Order Details</h5>

                <div class="table-responsive">

                    <table class="table">

                        <thead>

                            <tr>
                                <th>Document</th>
                                <th>Copies</th>
                                <th>Print Type</th>
                                <th>Amount</th>
                            </tr>

                        </thead>

                        <tbody>

                            <tr>

                                <td><%= order.getFileName() %></td>

<td><%= order.getCopies() %></td>

<td>
<%= order.getPrintType().equals("2")
    ? "Color Print"
    : "Black & White" %>
</td>

<td>
₹<%= order.getTotalAmount() %>
</td>

                            </tr>

                        </tbody>

                    </table>

                </div>

                <!-- Bill Summary -->

<%
double total = order.getTotalAmount();

double gst = total * 0.05;

double subtotal = total - gst;
%>
                <div class="summary-box">

                    <div class="summary-row">

                        <span>Print Charges</span>
                        <span>₹<%= subtotal %></span>

                    </div>

                    <div class="summary-row">

                        <span>Delivery Charges</span>
                        <span>₹0</span>

                    </div>

                    <div class="summary-row">

                        <span>GST (5%)</span>
                        <span>₹<%= gst %></span>

                    </div>

                    <hr>

                    <div class="summary-total">

                        <span>Grand Total</span>
                        <span>₹<%= total %></span>

                    </div>

                </div>

                <!-- Buttons -->

                <div class="text-center mt-4">

                    <button onclick="window.print()"
                            class="btn btn-primary me-2">

                        <i class="bi bi-printer"></i>
                        Print Invoice

                    </button>

                    <a href="downloadInvoice?id=<%= order.getId() %>"
   						class="btn btn-success">
						Download PDF</a>

                </div>

            </div>

        </div>

    </section>
	
</body>
</html>