package com.xeroxsystem.controller;

import java.io.IOException;

import com.xeroxsystem.dao.UserDAO;
import com.xeroxsystem.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")

public class RegisterServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phone =
                request.getParameter("phone");

        String address =
                request.getParameter("address");

        String password =
                request.getParameter("password");

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setPassword(password);

        UserDAO dao = new UserDAO();

        boolean result =
                dao.registerUser(user);

        if(result) {

            response.sendRedirect(
                    "login.jsp");

        }
        else {

            response.getWriter().println(
                    "Email already registered!");

        }
    }
}
