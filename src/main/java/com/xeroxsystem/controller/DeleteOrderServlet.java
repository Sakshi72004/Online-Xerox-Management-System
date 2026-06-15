package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.xeroxsystem.dao.OrderDAO;

@WebServlet("/deleteOrder")
public class DeleteOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter("id"));

        OrderDAO dao = new OrderDAO();

        dao.deleteOrder(id);

        response.sendRedirect("adminDashboard.jsp");
    }
}