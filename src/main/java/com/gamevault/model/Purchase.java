package com.gamevault.model;

import java.sql.Timestamp;

public class Purchase {
    private int id;
    private int userId;
    private int gameId;
    private String userName;
    private String gameTitle;
    private double price;
    private Timestamp purchaseDate;

    // Default constructor
    public Purchase() {}

    public Purchase(int userId, int gameId, double price) {
        this.userId = userId;
        this.gameId = gameId;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getGameId() { return gameId; }
    public void setGameId(int gameId) { this.gameId = gameId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getGameTitle() { return gameTitle; }
    public void setGameTitle(String gameTitle) { this.gameTitle = gameTitle; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Timestamp getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Timestamp purchaseDate) { this.purchaseDate = purchaseDate; }
}
