package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xeroxsystem.dao.UserDAO;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if(newPassword == null ||
                !newPassword.equals(confirmPassword)) {

            request.setAttribute("error",
                    "New password and confirm password do not match.");

            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
            return;
        }

        UserDAO dao =
                new UserDAO();

        boolean result =
                dao.resetPassword(email, phone, newPassword);

        if(result) {

            request.setAttribute("success",
                    "Password reset successfully. Please login with your new password.");

            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);

        } else {

            request.setAttribute("error",
                    "Email and phone number do not match any account.");

            request.getRequestDispatcher("forgot-password.jsp")
                   .forward(request, response);
        }
    }
}
