package com.gamevault.controller;

import com.gamevault.dao.GameDao;
import com.gamevault.model.Game;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;

@WebServlet("/admin/games")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminController extends HttpServlet {

    private GameDao gameDao;
    private com.gamevault.dao.UserDao userDao;

    @Override
    public void init() {
        gameDao = new GameDao();
        userDao = new com.gamevault.dao.UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addGame".equals(action)) {
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            String platform = request.getParameter("platform");
            Date releaseDate = Date.valueOf(request.getParameter("releaseDate"));
            double price = Double.parseDouble(request.getParameter("price"));

            // File Upload Logic
            Part filePart = request.getPart("image");
            String fileName = null;
            if (filePart != null) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            }
            
            String imagePath = "images/default-game.jpg"; // Default
            
            if (fileName != null && !fileName.isEmpty()) {
                // Ensure images directory exists in deployment folder
                String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                // Save file with unique name
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadPath + File.separator + uniqueFileName);
                imagePath = "images/" + uniqueFileName;
            }

            Game game = new Game(title, genre, platform, releaseDate, price, imagePath);

            if (gameDao.addGame(game)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=Game added");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=Failed to add game");
            }
        } else if ("deleteGame".equals(action)) {
            int gameId = Integer.parseInt(request.getParameter("id"));
            if (gameDao.deleteGame(gameId)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=Game deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=Failed to delete game");
            }
        } else if ("updateUserRole".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String role = request.getParameter("role");
            if (userDao.updateUserRole(userId, role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?success=User role updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=Failed to update role");
            }
        }
    }
}
