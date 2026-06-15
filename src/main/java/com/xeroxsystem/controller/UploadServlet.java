package com.xeroxsystem.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xeroxsystem.dao.OrderDAO;
import com.xeroxsystem.model.Order;
import com.xeroxsystem.model.User;

import java.io.File;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
@MultipartConfig
@WebServlet("/upload")
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
    			
            throws ServletException, IOException {
    					System.out.println("UploadServlet Called");
        try {

            // Get Logged-in User from Session
            HttpSession session = request.getSession();

            User user =
                (User) session.getAttribute("loggedUser");

            if(user == null) {

                response.sendRedirect("login.jsp");
                return;

            }

            // Get Form Data
            System.out.println("fileName = " + request.getParameter("fileName"));
            System.out.println("copies = " + request.getParameter("copies"));
            System.out.println("printType = " + request.getParameter("printType"));
            System.out.println("printSide = " + request.getParameter("printSide"));
            System.out.println("deliveryType = " + request.getParameter("deliveryType"));
            System.out.println("deliveryAddress = " + request.getParameter("deliveryAddress"));
            System.out.println("notes = " + request.getParameter("notes"));
            System.out.println("totalAmount = " + request.getParameter("totalAmount"));

            Part filePart =
                    request.getPart("fileName");

            String fileName =
                    filePart.getSubmittedFileName();
            
            String uploadPath =
                    getServletContext()
                    .getRealPath("/uploads");

            File uploadDir =
                    new File(uploadPath);

            if(!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(
                    uploadPath +
                    File.separator +
                    fileName);
            
            System.out.println("Upload Path = " + uploadPath);
            System.out.println("Saved File = " + fileName);
            
            System.out.println("copies = " +
                    request.getParameter("copies"));
            int copies =
                    Integer.parseInt(
                    request.getParameter("copies"));

            String printType =
                    request.getParameter("printType");

            String printSide =
                    request.getParameter("printSide");

            String deliveryType =
                    request.getParameter("deliveryType");

            String deliveryAddress =
                    request.getParameter("deliveryAddress");

            String notes =
                    request.getParameter("notes");

            String total =
                    request.getParameter("totalAmount");

            if(total == null || total.isEmpty()) {

                total = "0";

            }

            double totalAmount =
                    Double.parseDouble(total);
            
            // Create Order Object

            Order order = new Order();

            order.setUserId(user.getId());
            order.setFileName(fileName);
            order.setCopies(copies);
            order.setPrintType(printType);
            order.setPrintSide(printSide);
            order.setDeliveryType(deliveryType);
            order.setDeliveryAddress(deliveryAddress);
            order.setNotes(notes);
            order.setTotalAmount(totalAmount);

            // Save Order

            OrderDAO dao = new OrderDAO();

            boolean result =
                    dao.saveOrder(order);

            if(result) {

                response.sendRedirect("orders.jsp");

            } else {

                response.getWriter().println(
                        "Order Failed!");

            }

        } catch(Exception e) {

        	System.out.println("ERROR OCCURRED");
        	e.printStackTrace();

        	response.getWriter().println(
        	        "Error : " + e.getMessage());
        }

    }
}
