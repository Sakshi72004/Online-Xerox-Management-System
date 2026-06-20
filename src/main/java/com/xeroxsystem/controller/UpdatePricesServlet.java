package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xeroxsystem.dao.AdminDAO;

@WebServlet("/updatePrices")
public class UpdatePricesServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            double bwPrice =
                    Double.parseDouble(request.getParameter("bwPrice"));

            double colorPrice =
                    Double.parseDouble(request.getParameter("colorPrice"));

            double deliveryCharge =
                    Double.parseDouble(request.getParameter("deliveryCharge"));

            AdminDAO dao =
                    new AdminDAO();

            dao.updatePrintSettings(
                    bwPrice,
                    colorPrice,
                    deliveryCharge);

            response.sendRedirect("adminDashboard.jsp");

        } catch(Exception e) {

            e.printStackTrace();
            response.sendRedirect("adminDashboard.jsp");
        }
    }
}
