<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.xeroxsystem.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");

if(user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Upload Document - PrintEase</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/upload.css">
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="dashboard.jsp">Print<span>Ease</span></a>
        <div class="ms-auto">
            <a href="dashboard.jsp" class="btn btn-primary">Dashboard</a>
        </div>
    </div>
</nav>

<section class="upload-section">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-7">
                <div class="upload-card">
                    <span class="section-label">New Print Order</span>
                    <h2 class="mb-4">Upload Document</h2>

                    <% if("address".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">
                        Please enter delivery address or uncheck Need Delivery for self pickup.
                    </div>
                    <% } %>

                    <% if("file".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">
                        Please select a document before placing the order.
                    </div>
                    <% } %>

                    <% if("size".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">
                        File size must be 10 MB or less.
                    </div>
                    <% } %>

                    <% if("type".equals(request.getParameter("error"))) { %>
                    <div class="alert alert-danger">
                        Invalid file type. Upload PDF, Word, PowerPoint, Excel, text, JPG, JPEG, or PNG files only.
                    </div>
                    <% } %>

                    <form action="upload" method="post" enctype="multipart/form-data">
                        <div class="mb-4">
                            <label class="form-label">Upload File</label>
                            <input type="file" class="form-control" id="fileInput" name="fileName" accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt,.jpg,.jpeg,.png" required>
                            <small class="text-muted">
                                Selected file: <span id="fileNamePreview">No file selected</span>
                            </small>
                            <small class="text-muted d-block" id="pageCountNote">
                                PDF pages are counted automatically. Word/PPT files are counted as 1 file.
                            </small>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Number of Copies</label>
                            <input type="number" id="copies" name="copies" class="form-control" value="1" min="1" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Print Type</label>
                            <select id="printType" name="printType" class="form-select">
                                <option value="2">Black & White - ₹2</option>
                                <option value="5">Color Print - ₹5</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Print Side</label>
                            <select class="form-select" name="printSide">
                                <option value="Single Side">Single Side</option>
                                <option value="Double Side">Double Side</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Extra Services</label>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input extra-service" name="extraServices" value="20" id="spiral">
                                <label class="form-check-label" for="spiral">Spiral Binding (+ ₹20)</label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input extra-service" name="extraServices" value="10" id="lamination">
                                <label class="form-check-label" for="lamination">Lamination (+ ₹10)</label>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Notes For Printer</label>
                            <textarea class="form-control" name="notes" rows="3" placeholder="Example: First page color print, spiral binding required"></textarea>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Coupon Code</label>
                            <div class="input-group">
                                <input type="text" id="couponCode" class="form-control" placeholder="Try WELCOME10">
                                <button type="button" id="applyCoupon" class="btn btn-primary">Apply</button>
                            </div>
                            <small id="couponMessage"></small>
                        </div>

                        <div class="mb-4">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="deliveryCheck">
                                <label class="form-check-label" for="deliveryCheck">Need Delivery?</label>
                            </div>
                        </div>

                        <div id="deliveryFields">
                            <div class="mb-3">
                                <label class="form-label">Delivery Address</label>
                                <textarea class="form-control" id="deliveryAddress" name="deliveryAddress" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Delivery Type</label>
                                <select id="deliveryType" name="deliveryType" class="form-select">
                                    <option value="20">Normal Delivery - ₹20</option>
                                    <option value="50">Express Delivery - ₹50</option>
                                </select>
                            </div>
                        </div>

                        <input type="hidden" id="hiddenTotal" name="totalAmount">
                        <input type="hidden" id="deliveryRequired" name="deliveryRequired" value="no">

                        <button type="submit" class="btn order-btn">
                            Continue to Payment
                        </button>
                    </form>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="summary-card">
                    <h3 class="mb-4">Order Summary</h3>
                    <div class="summary-item"><span>Copies</span><span id="summaryCopies">1</span></div>
                    <div class="summary-item"><span>Pages</span><span id="summaryPages">1</span></div>
                    <div class="summary-item"><span>Print Cost</span><span id="printCost">₹2</span></div>
                    <div class="summary-item"><span>Extra Services</span><span id="extraCost">₹0</span></div>
                    <div class="summary-item"><span>Discount</span><span id="discountAmount">₹0</span></div>
                    <div class="summary-item"><span>Delivery Charges</span><span id="deliveryCost">₹0</span></div>
                    <div class="summary-item"><span>GST (5%)</span><span id="gst">₹0</span></div>
                    <div class="summary-item"><span>Estimated Delivery</span><span id="deliveryDate"></span></div>
                    <hr>
                    <div class="summary-total">
                        <span>Total Amount</span>
                        <span id="totalAmount">₹0</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
<script src="js/upload.js?v=3"></script>
</body>
</html>
