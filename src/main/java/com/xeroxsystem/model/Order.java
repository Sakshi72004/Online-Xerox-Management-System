package com.xeroxsystem.model;

public class Order {

    private int id;
    private int userId;
    private String fileName;
    private int copies;
    private String printType;
    private String printSide;
    private String deliveryType;
    private String deliveryAddress;
    private String notes;
    private double totalAmount;
    private String status;
    private String userName;

    public Order() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getCopies() {
        return copies;
    }

    public void setCopies(int copies) {
        this.copies = copies;
    }

    public String getPrintType() {
        return printType;
    }

    public void setPrintType(String printType) {
        this.printType = printType;
    }

    public String getPrintSide() {
        return printSide;
    }

    public void setPrintSide(String printSide) {
        this.printSide = printSide;
    }

    public String getDeliveryType() {
        return deliveryType;
    }
    
    public String getUserName() {
        return userName;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
}