package com.gamevault.dao;

import com.gamevault.model.Game;
import com.gamevault.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GameDao {

    // 1. Get all games
    public List<Game> getAllGames() {
        List<Game> games = new ArrayList<>();
        String sql = "SELECT * FROM games ORDER BY release_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Game game = new Game();
                game.setId(rs.getInt("id"));
                game.setTitle(rs.getString("title"));
                game.setGenre(rs.getString("genre"));
                game.setPlatform(rs.getString("platform"));
                game.setReleaseDate(rs.getDate("release_date"));
                game.setPrice(rs.getDouble("price"));
                game.setImagePath(rs.getString("image_path"));
                game.setCreatedAt(rs.getTimestamp("created_at"));
                games.add(game);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return games;
    }

    // 2. Add a new game (Admin only)
    public boolean addGame(Game game) {
        boolean isSuccess = false;
        String sql = "INSERT INTO games (title, genre, platform, release_date, price, image_path) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, game.getTitle());
            stmt.setString(2, game.getGenre());
            stmt.setString(3, game.getPlatform());
            stmt.setDate(4, game.getReleaseDate());
            stmt.setDouble(5, game.getPrice());
            stmt.setString(6, game.getImagePath());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }

    // 3. Get game by ID
    public Game getGameById(int id) {
        Game game = null;
        String sql = "SELECT * FROM games WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                game = new Game();
                game.setId(rs.getInt("id"));
                game.setTitle(rs.getString("title"));
                game.setGenre(rs.getString("genre"));
                game.setPlatform(rs.getString("platform"));
                game.setReleaseDate(rs.getDate("release_date"));
                game.setPrice(rs.getDouble("price"));
                game.setImagePath(rs.getString("image_path"));
                game.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return game;
    }

    // 4. Delete a game
    public boolean deleteGame(int id) {
        String sql = "DELETE FROM games WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
