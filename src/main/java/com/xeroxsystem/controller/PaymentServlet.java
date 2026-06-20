package com.xeroxsystem.controller;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xeroxsystem.dao.OrderDAO;
import com.xeroxsystem.model.Order;
import com.xeroxsystem.model.User;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session =
                    request.getSession();

            User user =
                    (User) session.getAttribute("loggedUser");

            if(user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int orderId =
                    Integer.parseInt(request.getParameter("orderId"));

            String paymentMethod =
                    request.getParameter("paymentMethod");

            OrderDAO dao =
                    new OrderDAO();

            Order order =
                    dao.getOrderById(orderId);

            if(order == null || order.getUserId() != user.getId()) {
                response.sendRedirect("orders.jsp");
                return;
            }

            boolean homeDelivery =
                    order.getDeliveryAddress() != null &&
                    !order.getDeliveryAddress().trim().isEmpty() &&
                    !"Self Pickup".equalsIgnoreCase(order.getDeliveryAddress()) &&
                    !"Self Pickup".equalsIgnoreCase(order.getDeliveryType());

            if(!homeDelivery && "COD".equalsIgnoreCase(paymentMethod)) {
                response.sendRedirect("payment.jsp?id=" + orderId + "&error=invalid");
                return;
            }

            if(homeDelivery && "Pay at Shop".equalsIgnoreCase(paymentMethod)) {
                response.sendRedirect("payment.jsp?id=" + orderId + "&error=invalid");
                return;
            }

            String paymentStatus =
                    ("COD".equalsIgnoreCase(paymentMethod) ||
                    "Pay at Shop".equalsIgnoreCase(paymentMethod))
                    ? paymentMethod
                    : "Paid";

            String transactionId = "-";

            if(!"COD".equalsIgnoreCase(paymentMethod) &&
                    !"Pay at Shop".equalsIgnoreCase(paymentMethod)) {
                transactionId =
                        "TXN" + UUID.randomUUID().toString()
                        .replace("-", "")
                        .substring(0, 10)
                        .toUpperCase();
            }

            boolean result =
                    dao.updatePayment(
                            orderId,
                            user.getId(),
                            paymentMethod,
                            paymentStatus,
                            transactionId,
                            order.getTotalAmount());

            if(result) {
                response.sendRedirect("payment-success.jsp?id=" + orderId);
            } else {
                response.sendRedirect("payment.jsp?id=" + orderId + "&error=1");
            }

        } catch(Exception e) {

            e.printStackTrace();
            response.sendRedirect("orders.jsp");
        }
    }
}
