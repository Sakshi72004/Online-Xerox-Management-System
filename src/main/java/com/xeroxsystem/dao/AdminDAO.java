package com.xeroxsystem.dao;

import java.util.List;
import java.util.ArrayList;

import com.xeroxsystem.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.xeroxsystem.util.DBConnection;

public class AdminDAO {

    public int getTotalUsers() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT COUNT(*) FROM users");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getTotalOrders() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT COUNT(*) FROM orders");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getPendingOrders() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT COUNT(*) FROM orders WHERE status='Pending'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public int getDeliveredOrders() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT COUNT(*) FROM orders WHERE status='Delivered'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public double getTotalRevenue() {

        double revenue = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                            "SELECT SUM(total_amount) FROM orders");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                revenue = rs.getDouble(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return revenue;
    }
    
    public int getPrintingOrders() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM orders WHERE status='Printing'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public int getPackedOrders() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM orders WHERE status='Packed'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public int getOutForDeliveryOrders() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM orders WHERE status='Out For Delivery'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public int getCancelledOrders() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM orders WHERE status='Cancelled'");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public int getTotalDocuments() {

        int count = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(file_name) FROM orders");

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public List<Order> getAllOrders() {

        List<Order> list = new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            		"SELECT o.*, u.full_name " +
            		"FROM orders o " +
            		"JOIN users u ON o.user_id = u.id " +
            		"ORDER BY o.id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Order o = new Order();

                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setFileName(rs.getString("file_name"));
                o.setCopies(rs.getInt("copies"));
                o.setPrintType(rs.getString("print_type"));
                o.setDeliveryAddress(
                        rs.getString("delivery_address"));

                o.setTotalAmount(
                        rs.getDouble("total_amount"));

                o.setStatus(
                        rs.getString("status"));
                o.setUserName(rs.getString("full_name"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setPaymentStatus(rs.getString("payment_status"));
                o.setTransactionId(rs.getString("transaction_id"));
                o.setOrderDate(rs.getString("order_date"));
                o.setExpectedDelivery(rs.getString("expected_delivery"));
                o.setPages(rs.getInt("pages"));

                list.add(o);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean updateOrderStatus(int id, String status) {

        boolean result = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE orders SET status=? WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, id);

            int row = ps.executeUpdate();

            if(row > 0) {
                result = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public boolean updatePrintSettings(double bwPrice, double colorPrice,
            double deliveryCharge) {

        boolean result = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE print_settings SET bw_price=?, color_price=?, delivery_charge=? WHERE id=1";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setDouble(1, bwPrice);
            ps.setDouble(2, colorPrice);
            ps.setDouble(3, deliveryCharge);

            result = ps.executeUpdate() > 0;

            if(!result) {

                String insertSql =
                        "INSERT INTO print_settings(id,bw_price,color_price,delivery_charge) VALUES(1,?,?,?)";

                PreparedStatement insertPs =
                        con.prepareStatement(insertSql);

                insertPs.setDouble(1, bwPrice);
                insertPs.setDouble(2, colorPrice);
                insertPs.setDouble(3, deliveryCharge);

                result = insertPs.executeUpdate() > 0;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return result;
    }
}
