package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.xeroxsystem.dao.OrderDAO;

@WebServlet("/updateOrderStatus")
public class UpdateOrderStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter("id"));

        String status =
                request.getParameter("status");

        OrderDAO dao = new OrderDAO();

        dao.updateOrderStatus(id, status);

        response.sendRedirect("adminDashboard.jsp");
    }
}



