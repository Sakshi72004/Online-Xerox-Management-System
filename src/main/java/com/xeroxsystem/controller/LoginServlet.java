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

@WebServlet("/login")

public class LoginServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        UserDAO dao =
                new UserDAO();

        User user =
                dao.loginUser(email, password);

        if(user != null){

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            if("ADMIN".equalsIgnoreCase(user.getRole())){

                response.sendRedirect("adminDashboard.jsp");

            }else{

                response.sendRedirect("dashboard.jsp");
            }

        }else{

            request.setAttribute("error",
                    "Invalid Email or Password");

            request.getRequestDispatcher("login.jsp")
                   .forward(request,response);
        }
    }
}