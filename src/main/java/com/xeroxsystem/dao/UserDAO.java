package com.xeroxsystem.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.xeroxsystem.model.User;
import com.xeroxsystem.util.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO users(full_name,email,phone,address,password,role) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPassword());
            ps.setString(6, "USER");

            int row = ps.executeUpdate();

            if(row > 0) {
                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return status;
    }
    
    public User loginUser(String email, String password) {

        User user = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }

        } catch(Exception e) {

            e.printStackTrace();

        }

        return user;
    }
    
    public boolean updateUser(User user) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "UPDATE users SET full_name=?, email=?, phone=?, address=?, password=? WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPassword());
            ps.setInt(6, user.getId());

            int row = ps.executeUpdate();

            if(row > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public User getUserById(int id) {

        User user = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(
                        rs.getString("full_name"));

                user.setEmail(
                        rs.getString("email"));

                user.setPhone(
                        rs.getString("phone"));

                user.setAddress(
                        rs.getString("address"));

                user.setPassword(
                        rs.getString("password"));

                user.setRole(
                        rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean resetPassword(String email, String phone, String newPassword) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE users SET password=? WHERE email=? AND phone=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.setString(3, phone);

            status = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}
