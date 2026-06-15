package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xeroxsystem.dao.UserDAO;
import com.xeroxsystem.model.User;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        User user =
        (User) session.getAttribute("loggedUser");

        if(user == null) {

            response.sendRedirect("login.jsp");
            return;

        }

        user.setFullName(
                request.getParameter("fullName"));

        user.setEmail(
                request.getParameter("email"));

        user.setPhone(
                request.getParameter("phone"));

        user.setAddress(
                request.getParameter("address"));
        
        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if(newPassword != null &&
           !newPassword.isEmpty() &&
           newPassword.equals(confirmPassword)) {

            user.setPassword(newPassword);
        }

        UserDAO dao = new UserDAO();

        boolean status =
                dao.updateUser(user);

        if(status) {

            session.setAttribute(
                    "loggedUser",
                    user);

        }

        response.sendRedirect(
                "profile.jsp");
    }
}
