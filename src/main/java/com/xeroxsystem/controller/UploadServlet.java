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
import com.itextpdf.text.pdf.PdfReader;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

            String originalFileName =
                    filePart.getSubmittedFileName();

            if(originalFileName == null ||
                    originalFileName.trim().isEmpty()) {
                response.sendRedirect("upload.jsp?error=file");
                return;
            }

            if(filePart.getSize() > 10 * 1024 * 1024) {
                response.sendRedirect("upload.jsp?error=size");
                return;
            }

            String extension =
                    getExtension(originalFileName);

            if(!isAllowedExtension(extension)) {
                response.sendRedirect("upload.jsp?error=type");
                return;
            }

            String safeOriginalName =
                    new File(originalFileName).getName()
                    .replaceAll("[^a-zA-Z0-9._-]", "_");

            String fileName =
                    System.currentTimeMillis() + "_" + safeOriginalName;
            
            String uploadPath =
                    getServletContext()
                    .getRealPath("/uploads");

            File uploadDir =
                    new File(uploadPath);

            if(!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File savedFile =
                    new File(uploadPath, fileName);

            filePart.write(savedFile.getAbsolutePath());
            
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

            String deliveryRequired =
                    request.getParameter("deliveryRequired");

            boolean isDelivery =
                    "yes".equalsIgnoreCase(deliveryRequired);

            if(!isDelivery) {
                deliveryType = "Self Pickup";
                deliveryAddress = "Self Pickup";
            }

            if(isDelivery &&
                    (deliveryAddress == null ||
                    deliveryAddress.trim().isEmpty())) {

                response.sendRedirect("upload.jsp?error=address");
                return;
            }

            if(deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
                deliveryAddress = "Self Pickup";
            } else {
                deliveryAddress = deliveryAddress.trim();
            }

            int pages =
                    getPageCount(savedFile, fileName);

            String[] selectedExtras =
                    request.getParameterValues("extraServices");

            int extraCharges = 0;

            if(selectedExtras != null) {
                for(String service : selectedExtras) {
                    extraCharges += Integer.parseInt(service);
                }
            }

            int printRate =
                    Integer.parseInt(printType);

            int deliveryCharge = 0;

            if(isDelivery && deliveryType != null) {
                deliveryCharge =
                        Integer.parseInt(deliveryType);
            }

            double subtotal =
                    (pages * copies * printRate) +
                    extraCharges +
                    deliveryCharge;

            double totalAmount =
                    subtotal + (subtotal * 0.05);

            String expectedDelivery =
                    "-";

            if(isDelivery) {
                expectedDelivery =
                        LocalDate.now()
                        .plusDays("50".equals(deliveryType) ? 1 : 2)
                        .format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
            }
            
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
            order.setExpectedDelivery(expectedDelivery);
            order.setPages(pages);

            // Save Order

            OrderDAO dao = new OrderDAO();

            int orderId =
                    dao.saveOrderAndReturnId(order);

            if(orderId > 0) {

                response.sendRedirect("payment.jsp?id=" + orderId);

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

    private int getPageCount(File file, String fileName) {

        int pages = 1;

        if(fileName != null &&
                fileName.toLowerCase().endsWith(".pdf")) {

            PdfReader reader = null;

            try {
                reader = new PdfReader(file.getAbsolutePath());
                pages = reader.getNumberOfPages();
            } catch(Exception e) {
                e.printStackTrace();
                pages = 1;
            } finally {
                if(reader != null) {
                    reader.close();
                }
            }
        }

        return pages;
    }

    private String getExtension(String fileName) {

        int index =
                fileName.lastIndexOf(".");

        if(index == -1) {
            return "";
        }

        return fileName.substring(index + 1)
                .toLowerCase();
    }

    private boolean isAllowedExtension(String extension) {

        return "pdf".equals(extension) ||
                "doc".equals(extension) ||
                "docx".equals(extension) ||
                "ppt".equals(extension) ||
                "pptx".equals(extension) ||
                "xls".equals(extension) ||
                "xlsx".equals(extension) ||
                "txt".equals(extension) ||
                "jpg".equals(extension) ||
                "jpeg".equals(extension) ||
                "png".equals(extension);
    }
}
