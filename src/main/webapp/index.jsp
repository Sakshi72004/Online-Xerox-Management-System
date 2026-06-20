<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>PrintEase - Online Xerox Management System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <!-- CSS File -->
    <link rel="stylesheet" href="css/index.css">

</head>
<body>
	<!-- Navbar -->

    <nav class="navbar navbar-expand-lg">
        <div class="container">

            <a class="navbar-brand" href="#">
                Print<span>Ease</span>
            </a>

            <button class="navbar-toggler bg-light" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">

                <span class="navbar-toggler-icon"></span>

            </button>

            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav ms-auto align-items-lg-center">

    <li class="nav-item">
        <a class="nav-link" href="#home">Home</a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="#services">Services</a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="#Working-Flow">
            Working Flow
        </a>
    </li>

    <li class="nav-item">
        <a class="nav-link" href="#contact">Contact</a>
    </li>

    <li class="nav-item">
        <a class="nav-link login-btn" href="login.jsp">
            Login
        </a>
    </li>

</ul>

            </div>

        </div>
    </nav>

    <!-- Hero Section -->

    <section class="hero" id="home">

        <div class="container">

            <div class="row align-items-center">

                <div class="col-lg-6">

                    <h1>
                        Upload Documents & Get Printouts
                        <span>Delivered</span>
                    </h1>

                    <p>
                        Fast, secure and smart online xerox management system with
                        delivery tracking, invoice generation and instant print services.
                    </p>

                    <a href="login.jsp"
   class="hero-btn btn-primary-custom">
   <i class="bi bi-cloud-upload"></i>
   Upload Now
</a>

<a href="login.jsp"
   class="hero-btn btn-outline-custom">
   <i class="bi bi-truck"></i>
   Track Order
</a>

                </div>

                <div class="col-lg-6 hero-image text-center">

                    <img src="https://cdn-icons-png.flaticon.com/512/942/942748.png"
                        alt="Printing Illustration">

                </div>

            </div>

        </div>

    </section>

    <!-- Features -->

    <section class="py-5" id="services">

        <div class="container">

            <div class="section-title">

                <h2>Our Services</h2>

                <p>
                    Smart features designed for fast and professional printing service.
                </p>

            </div>

            <div class="row g-4">

                <div class="col-md-6 col-lg-3">

                    <div class="feature-card">

                        <div class="feature-icon">
                            <i class="bi bi-file-earmark-arrow-up"></i>
                        </div>

                        <h4>Easy Upload</h4>

                        <p>
                            Upload PDF, DOCX and PPT files securely in seconds.
                        </p>

                    </div>

                </div>

                <div class="col-md-6 col-lg-3">

                    <div class="feature-card">

                        <div class="feature-icon">
                            <i class="bi bi-truck"></i>
                        </div>

                        <h4>Fast Delivery</h4>

                        <p>
                            Get your printouts delivered directly to your location.
                        </p>

                    </div>

                </div>

                <div class="col-md-6 col-lg-3">

                    <div class="feature-card">

                        <div class="feature-icon">
                            <i class="bi bi-credit-card"></i>
                        </div>

                        <h4>Secure Payment</h4>

                        <p>
                            Safe online payment system with invoice generation.
                        </p>

                    </div>

                </div>

                <div class="col-md-6 col-lg-3">

                    <div class="feature-card">

                        <div class="feature-icon">
                            <i class="bi bi-geo-alt"></i>
                        </div>

                        <h4>Live Tracking</h4>

                        <p>
                            Track your printing and delivery status in real-time.
                        </p>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <!-- How It Works -->

    <section class="how-section" id="Working-Flow">
    

        <div class="container">

            <div class="section-title">

                <h2>How It Works</h2>

                <p>
                    Simple steps to place your printing order online.
                </p>

            </div>

            <div class="row">

                <div class="col-md-3">

                    <div class="step-card">

                        <div class="step-number">1</div>

                        <h5>Upload File</h5>

                        <p>Select your document file.</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="step-card">

                        <div class="step-number">2</div>

                        <h5>Select Print</h5>

                        <p>Choose copies and print type.</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="step-card">

                        <div class="step-number">3</div>

                        <h5>Make Payment</h5>

                        <p>Pay securely online.</p>

                    </div>

                </div>

                <div class="col-md-3">

                    <div class="step-card">

                        <div class="step-number">4</div>

                        <h5>Get Delivered</h5>

                        <p>Receive your order quickly.</p>

                    </div>

                </div>

            </div>

        </div>

    </section>

    <!-- Footer -->

    <footer id="contact">

        <div class="container">

            <div class="row">

                <div class="col-lg-4">

                    <h5>PrintEase</h5>

                    <p>
                        Smart online xerox management system with modern
                        printing and delivery services.
                    </p>

                </div>

                <div class="col-lg-4">

                    <h5>Quick Links</h5>

                    <p>
    <a href="#home" class="footer-link">
        Home
    </a>
</p>

<p>
    <a href="#services" class="footer-link">
        Services
    </a>
</p>

<p>
    <a href="#Working-Flow" class="footer-link">
        Working Flow
    </a>
</p>

<p>
    <a href="#contact" class="footer-link">
        Contact
    </a>
</p>

                </div>

                <div class="col-lg-4">

                    <h5>Contact</h5>

                    <p>Email: printease@gmail.com</p>
                    <p>Phone: +91 9876543210</p>
                    <p>Pune, Maharashtra</p>

                </div>

            </div>

            <div class="footer-bottom">

                <p>
                    © 2026 PrintEase. All Rights Reserved.
                </p>

            </div>

        </div>

    </footer>

    <!-- Bootstrap JS -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>

const sections =
document.querySelectorAll("section");

const navLinks =
document.querySelectorAll(".nav-link");

window.addEventListener("scroll", () => {

    let current = "";

    sections.forEach(section => {

        const sectionTop =
        section.offsetTop - 100;

        const sectionHeight =
        section.clientHeight;

        if(pageYOffset >= sectionTop){

            current =
            section.getAttribute("id");

        }

    });

    navLinks.forEach(link => {

        link.classList.remove("active");

        if(link.getAttribute("href")
           === "#" + current){

            link.classList.add("active");

        }

    });

});

</script>
	
</body>
</html>