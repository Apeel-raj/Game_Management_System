package com.gamevault.dao;

import com.gamevault.model.Purchase;
import com.gamevault.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PurchaseDao {

    // 1. Add a purchase (When user clicks Buy)
    public boolean addPurchase(Purchase purchase) {
        String sql = "INSERT INTO purchases (user_id, game_id, price_at_purchase) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, purchase.getUserId());
            stmt.setInt(2, purchase.getGameId());
            stmt.setDouble(3, purchase.getPrice());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Get total revenue (For Admin Dashboard)
    public double getTotalRevenue() {
        String sql = "SELECT SUM(price_at_purchase) as total FROM purchases";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // 3. Get recent sales (For Admin Dashboard)
    public List<Purchase> getRecentPurchases() {
        List<Purchase> sales = new ArrayList<>();
        // Join with users and games to get nice names for the dashboard table
        String sql = "SELECT p.*, u.name as user_name, g.title as game_title " +
                     "FROM purchases p " +
                     "JOIN users u ON p.user_id = u.id " +
                     "JOIN games g ON p.game_id = g.id " +
                     "ORDER BY p.purchase_date DESC LIMIT 10";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Purchase p = new Purchase();
                p.setId(rs.getInt("id"));
                p.setUserId(rs.getInt("user_id"));
                p.setGameId(rs.getInt("game_id"));
                p.setPrice(rs.getDouble("price_at_purchase"));
                p.setPurchaseDate(rs.getTimestamp("purchase_date"));
                p.setUserName(rs.getString("user_name"));
                p.setGameTitle(rs.getString("game_title"));
                sales.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }
}
