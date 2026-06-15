package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xeroxsystem.dao.OrderDAO;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                request.getParameter("id"));

        OrderDAO dao =
                new OrderDAO();

        dao.cancelOrder(id);

        response.sendRedirect(
                "orders.jsp");
    }
}
