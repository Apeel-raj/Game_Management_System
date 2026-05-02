package com.gamevault.controller;

import com.gamevault.dao.GameDao;
import com.gamevault.model.Game;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Maps to the homepage or main games page
@WebServlet("/games")
public class GameController extends HttpServlet {

    private GameDao gameDao;

    @Override
    public void init() {
        gameDao = new GameDao();
    }

    // Handles displaying games when someone visits /games
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get all games from the database using our Model Layer
        List<Game> gameList = gameDao.getAllGames();

        // 2. Attach the games to the "request" object so the View can see them
        request.setAttribute("games", gameList);

        // 3. Forward the user and the data to the View (index.jsp)
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
