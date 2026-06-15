<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Document - PrintEase</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="css/upload.css">
</head>
<body>
	<!-- Navbar -->

    <nav class="navbar navbar-expand-lg">

        <div class="container">

            <a class="navbar-brand" href="#">
                Print<span>Ease</span>
            </a>

            <div class="ms-auto">

                <a href="dashboard.jsp" class="btn btn-primary">
                    Dashboard
                </a>

            </div>

        </div>

    </nav>

    <!-- Upload Section -->

    <section class="upload-section">

        <div class="container">

            <div class="row g-4">

                <!-- LEFT CARD -->

                <div class="col-lg-7">

				<div class="upload-card">

    <h2 class="mb-4">
        Upload Document 📄
    </h2>

    <form action="upload" method="post" enctype="multipart/form-data" >

        <!-- Document Name -->

        <div class="mb-4">

                            <label class="form-label">
                                Upload File
                            </label>

                            <input type="file"
                                class="form-control"
                                id="fileInput"
                                name="fileName">

                            <small class="text-muted">

                                Selected File:
                                <span id="fileNamePreview">

                                    No file selected

                                </span>

                            </small>

                        </div>

        <!-- Copies -->

        <div class="mb-4">

            <label class="form-label">
                Number of Copies
            </label>

            <input type="number"
                   id="copies"
                   name="copies"
                   class="form-control"
                   value="1"
                   min="1"
                   required>

        </div>

        <!-- Print Type -->

        <div class="mb-4">

            <label class="form-label">
                Print Type
            </label>

            <select id="printType"
                    name="printType"
                    class="form-select">

                <option value="2">
                    Black & White
                </option>

                <option value="5">
                    Color Print
                </option>

            </select>

        </div>

        <!-- Print Side -->

        <div class="mb-4">

            <label class="form-label">
                Print Side
            </label>

            <select class="form-select"
                    name="printSide">

                <option value="Single Side">
                    Single Side
                </option>

                <option value="Double Side">
                    Double Side
                </option>

            </select>

        </div>

        <!-- Extra Services -->

        <div class="mb-4">

            <label class="form-label">
                Extra Services
            </label>

            <div class="form-check">

                <input type="checkbox"
                       class="form-check-input extra-service"
                       value="20">

                <label class="form-check-label">
                    Spiral Binding (+ ₹20)
                </label>

            </div>

            <div class="form-check">

                <input type="checkbox"
                       class="form-check-input extra-service"
                       value="10">

                <label class="form-check-label">
                    Lamination (+ ₹10)
                </label>

            </div>

        </div>

        <!-- Notes -->

        <div class="mb-4">

            <label class="form-label">
                Notes For Printer
            </label>

            <textarea class="form-control"
                      name="notes"
                      rows="3"
                      placeholder="Example: First page color print, spiral binding required"></textarea>

        </div>

        <!-- Coupon -->

        <div class="mb-4">

            <label class="form-label">
                Coupon Code
            </label>

            <div class="input-group">

                <input type="text"
                       id="couponCode"
                       class="form-control"
                       placeholder="Enter Coupon">

                <button type="button"
                        id="applyCoupon"
                        class="btn btn-primary">

                    Apply

                </button>

            </div>

            <small id="couponMessage"></small>

        </div>

        <!-- Delivery -->

        <div class="mb-4">

            <div class="form-check">

                <input type="checkbox"
                       class="form-check-input"
                       id="deliveryCheck">

                <label class="form-check-label">
                    Need Delivery?
                </label>

            </div>

        </div>

        <!-- Delivery Fields -->

        <div id="deliveryFields">

            <div class="mb-3">

                <label class="form-label">
                    Delivery Address
                </label>

                <textarea class="form-control"
                          name="deliveryAddress"
                          rows="3"></textarea>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Delivery Type
                </label>

                <select id="deliveryType"
                        name="deliveryType"
                        class="form-select">

                    <option value="20">
                        Normal Delivery
                    </option>

                    <option value="50">
                        Express Delivery
                    </option>

                </select>

            </div>

        </div>

        <!-- Hidden Total -->

        <input type="hidden"
               id="hiddenTotal"
               name="totalAmount">

        <!-- Submit Button -->

        <button type="submit"
                class="btn order-btn">

            Place Order

        </button>

    </form>

</div>

                </div>

                <!-- SUMMARY CARD -->

                <div class="col-lg-5">

                    <div class="summary-card">

                        <h3 class="mb-4">

                            Order Summary

                        </h3>

                        <div class="summary-item">
                            <span>Copies</span>
                            <span id="summaryCopies">1</span>
                        </div>

                        <div class="summary-item">
                            <span>Print Cost</span>
                            <span id="printCost">₹2</span>
                        </div>

                        <div class="summary-item">
                            <span>Extra Services</span>
                            <span id="extraCost">₹0</span>
                        </div>

                        <div class="summary-item">
                            <span>Discount</span>
                            <span id="discountAmount">₹0</span>
                        </div>

                        <div class="summary-item">
                            <span>Delivery Charges</span>
                            <span id="deliveryCost">₹0</span>
                        </div>

                        <div class="summary-item">
                            <span>GST (5%)</span>
                            <span id="gst">₹0</span>
                        </div>

                        <div class="summary-item">
                            <span>Estimated Delivery</span>
                            <span id="deliveryDate"></span>
                        </div>

                        <hr>

                        <div class="summary-total">

                            <span>Total Amount</span>

                            <span id="totalAmount">

                                ₹0

                            </span>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <script src="js/upload.js"></script>
</body>
</html>