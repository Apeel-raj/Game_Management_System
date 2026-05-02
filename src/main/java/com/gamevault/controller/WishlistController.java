package com.gamevault.controller;

import com.gamevault.dao.GameDao;
import com.gamevault.model.Game;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistController extends HttpServlet {

    private GameDao gameDao;

    @Override
    public void init() {
        gameDao = new GameDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);

        // Only allow logged in users to use the wishlist
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login to add games to your wishlist.");
            return;
        }

        if ("add".equals(action)) {
            int gameId = Integer.parseInt(request.getParameter("gameId"));
            Game game = gameDao.getGameById(gameId);

            if (game != null) {
                // Get or create the wishlist in the session
                List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
                if (wishlist == null) {
                    wishlist = new ArrayList<>();
                }

                // Check if already in wishlist to prevent duplicates
                boolean exists = wishlist.stream().anyMatch(g -> g.getId() == game.getId());
                if (!exists) {
                    wishlist.add(game);
                    session.setAttribute("wishlist", wishlist);
                    response.sendRedirect("games?success=Added to wishlist!");
                } else {
                    response.sendRedirect("games?error=Game is already in your wishlist!");
                }
            }
        } else if ("remove".equals(action)) {
            int gameId = Integer.parseInt(request.getParameter("gameId"));
            List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
            if (wishlist != null) {
                // Remove game from session wishlist
                wishlist.removeIf(g -> g.getId() == gameId);
                session.setAttribute("wishlist", wishlist);
            }
            response.sendRedirect("wishlist");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login to view your wishlist.");
            return;
        }
        
        // Forward to the JSP to render the page
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }
}
