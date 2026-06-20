package com.xeroxsystem.dao;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

import com.xeroxsystem.model.Order;
import com.xeroxsystem.util.DBConnection;

public class OrderDAO {

    // SAVE ORDER

    public boolean saveOrder(Order order) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO orders(user_id,file_name,copies,print_type,print_side,delivery_type,delivery_address,notes,total_amount,status) VALUES(?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getFileName());
            ps.setInt(3, order.getCopies());
            ps.setString(4, order.getPrintType());
            ps.setString(5, order.getPrintSide());
            ps.setString(6, order.getDeliveryType());
            ps.setString(7, order.getDeliveryAddress());
            ps.setString(8, order.getNotes());
            ps.setDouble(9, order.getTotalAmount());
            ps.setString(10, "Pending");

            int row = ps.executeUpdate();

            if (row > 0) {

                status = true;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    public int saveOrderAndReturnId(Order order) {

        int orderId = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO orders(user_id,file_name,copies,print_type,print_side,delivery_type,delivery_address,notes,total_amount,status,payment_method,payment_status,expected_delivery,pages) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getFileName());
            ps.setInt(3, order.getCopies());
            ps.setString(4, order.getPrintType());
            ps.setString(5, order.getPrintSide());
            ps.setString(6, order.getDeliveryType());
            ps.setString(7, order.getDeliveryAddress());
            ps.setString(8, order.getNotes());
            ps.setDouble(9, order.getTotalAmount());
            ps.setString(10, "Pending");
            ps.setString(11, "Pending");
            ps.setString(12, "Unpaid");
            ps.setString(13, order.getExpectedDelivery());
            ps.setInt(14, order.getPages());

            int row = ps.executeUpdate();

            if(row > 0) {

                ResultSet rs = ps.getGeneratedKeys();

                if(rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return orderId;
    }

    // GET ALL ORDERS

    public List<Order> getAllOrders() {

        List<Order> list = new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM orders ORDER BY id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setId(
                        rs.getInt("id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setFileName(
                        rs.getString("file_name"));

                order.setCopies(
                        rs.getInt("copies"));

                order.setPrintType(
                        rs.getString("print_type"));

                order.setPrintSide(
                        rs.getString("print_side"));

                order.setDeliveryType(
                        rs.getString("delivery_type"));

                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                order.setNotes(
                        rs.getString("notes"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                setPaymentFields(order, rs);

                list.add(order);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;
    }
    
    public List<Order> getOrdersByUser(int userId) {

        List<Order> list = new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM orders WHERE user_id=? ORDER BY id DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setFileName(rs.getString("file_name"));
                order.setCopies(rs.getInt("copies"));
                order.setPrintType(rs.getString("print_type"));
                order.setPrintSide(rs.getString("print_side"));
                order.setDeliveryType(rs.getString("delivery_type"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setNotes(rs.getString("notes"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                setPaymentFields(order, rs);

                list.add(order);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
    public Order getOrderById(int id) {

        Order order = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM orders WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                order = new Order();

                order.setId(
                        rs.getInt("id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setFileName(
                        rs.getString("file_name"));

                order.setCopies(
                        rs.getInt("copies"));

                order.setPrintType(
                        rs.getString("print_type"));

                order.setPrintSide(
                        rs.getString("print_side"));

                order.setDeliveryType(
                        rs.getString("delivery_type"));

                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                order.setNotes(
                        rs.getString("notes"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setStatus(
                        rs.getString("status"));

                setPaymentFields(order, rs);

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return order;
    }
    
    public boolean cancelOrder(int id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE orders SET status=? WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, "Cancelled");
            ps.setInt(2, id);

            int row = ps.executeUpdate();

            if(row > 0) {

                status = true;

            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    public boolean updatePayment(int orderId, int userId, String paymentMethod,
            String paymentStatus, String transactionId, double amount) {

        boolean result = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String updateOrderSql =
                    "UPDATE orders SET payment_method=?, payment_status=?, transaction_id=? WHERE id=? AND user_id=?";

            PreparedStatement ps =
                    con.prepareStatement(updateOrderSql);

            ps.setString(1, paymentMethod);
            ps.setString(2, paymentStatus);
            ps.setString(3, transactionId);
            ps.setInt(4, orderId);
            ps.setInt(5, userId);

            int row = ps.executeUpdate();

            if(row > 0) {

                String insertPaymentSql =
                        "INSERT INTO payments(order_id,user_id,payment_method,payment_status,transaction_id,amount) VALUES(?,?,?,?,?,?)";

                PreparedStatement paymentPs =
                        con.prepareStatement(insertPaymentSql);

                paymentPs.setInt(1, orderId);
                paymentPs.setInt(2, userId);
                paymentPs.setString(3, paymentMethod);
                paymentPs.setString(4, paymentStatus);
                paymentPs.setString(5, transactionId);
                paymentPs.setDouble(6, amount);

                paymentPs.executeUpdate();
                result = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return result;
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
    
    public boolean deleteOrder(int id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "DELETE FROM orders WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            status =
                    ps.executeUpdate() > 0;

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }

    private void setPaymentFields(Order order, ResultSet rs) {

        try {
            order.setPaymentMethod(rs.getString("payment_method"));
            order.setPaymentStatus(rs.getString("payment_status"));
            order.setTransactionId(rs.getString("transaction_id"));
            order.setOrderDate(rs.getString("order_date"));
            order.setExpectedDelivery(rs.getString("expected_delivery"));
            order.setPages(rs.getInt("pages"));
        } catch(Exception e) {
            order.setPaymentMethod("Pending");
            order.setPaymentStatus("Unpaid");
            order.setTransactionId("-");
            order.setOrderDate("-");
            order.setExpectedDelivery("-");
            order.setPages(1);
        }
    }
}
