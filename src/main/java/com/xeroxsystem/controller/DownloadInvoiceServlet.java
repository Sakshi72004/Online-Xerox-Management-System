package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import com.xeroxsystem.dao.OrderDAO;
import com.xeroxsystem.dao.UserDAO;
import com.xeroxsystem.model.Order;
import com.xeroxsystem.model.User;

@WebServlet("/downloadInvoice")
public class DownloadInvoiceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");

        response.setHeader(
                "Content-Disposition",
                "attachment; filename=invoice.pdf");

        try {

            HttpSession session =
                    request.getSession(false);

            User loggedUser =
                    session == null ? null :
                    (User) session.getAttribute("loggedUser");

            if(loggedUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int id = Integer.parseInt(
                    request.getParameter("id"));

            OrderDAO orderDao = new OrderDAO();
            Order order = orderDao.getOrderById(id);

            if(order == null || order.getUserId() != loggedUser.getId()) {
                response.sendRedirect("orders.jsp");
                return;
            }

            UserDAO userDao = new UserDAO();
            User user = userDao.getUserById(
                    order.getUserId());

            Document document = new Document();

            PdfWriter.getInstance(
                    document,
                    response.getOutputStream());

            document.open();

            Font titleFont = new Font(
                    Font.FontFamily.HELVETICA,
                    20,
                    Font.BOLD);

            Font headingFont = new Font(
                    Font.FontFamily.HELVETICA,
                    14,
                    Font.BOLD);

            document.add(
                    new Paragraph(
                            "PRINTEASE INVOICE",
                            titleFont));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "Invoice No : INV"
                    + String.format("%03d",
                    order.getId())));

            document.add(new Paragraph(
                    "Order Status : "
                    + order.getStatus()));

            document.add(new Paragraph(
                    "Payment Status : "
                    + order.getPaymentStatus()));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "CUSTOMER DETAILS",
                    headingFont));

            document.add(new Paragraph(
                    "Name : "
                    + user.getFullName()));

            document.add(new Paragraph(
                    "Email : "
                    + user.getEmail()));

            document.add(new Paragraph(
                    "Phone : "
                    + user.getPhone()));

            document.add(new Paragraph(
                    "Address : "
                    + user.getAddress()));

            document.add(new Paragraph(" "));

            document.add(new Paragraph(
                    "ORDER DETAILS",
                    headingFont));

            document.add(new Paragraph(
                    "Document : "
                    + order.getFileName()));

            document.add(new Paragraph(
                    "Copies : "
                    + order.getCopies()));

            document.add(new Paragraph(
                    "Pages : "
                    + order.getPages()));

            document.add(new Paragraph(
                    "Print Type : "
                    + ("5".equals(order.getPrintType())
                    ? "Color Print" : "Black & White")));

            document.add(new Paragraph(
                    "Print Side : "
                    + order.getPrintSide()));

            document.add(new Paragraph(
                    "Delivery Type : "
                    + order.getDeliveryType()));

            document.add(new Paragraph(
                    "Delivery Address : "
                    + order.getDeliveryAddress()));

            document.add(new Paragraph(
                    "Payment Method : "
                    + order.getPaymentMethod()));

            String transactionText =
                    "COD".equalsIgnoreCase(order.getPaymentStatus())
                    ? "Payment on delivery"
                    : ("Pay at Shop".equalsIgnoreCase(order.getPaymentStatus())
                    ? "Payment at shop"
                    : order.getTransactionId());

            document.add(new Paragraph(
                    "Transaction : "
                    + transactionText));

            document.add(new Paragraph(
                    "Notes : "
                    + order.getNotes()));

            document.add(new Paragraph(" "));

            double gst =
                    order.getTotalAmount() * 0.05;

            double printCharge =
                    order.getTotalAmount() - gst;

            document.add(new Paragraph(
                    "Print Charges : Rs. "
                    + printCharge));

            document.add(new Paragraph(
                    "GST (5%) : Rs. "
                    + gst));

            document.add(new Paragraph(
                    "Grand Total : Rs. "
                    + order.getTotalAmount(),
                    headingFont));

            document.add(new Paragraph(" "));
            document.add(new Paragraph(" "));
            document.add(new Paragraph(
                    "Thank you for choosing PrintEase."));

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
