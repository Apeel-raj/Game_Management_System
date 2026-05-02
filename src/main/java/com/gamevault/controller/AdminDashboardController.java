package com.gamevault.controller;

import com.gamevault.dao.GameDao;
import com.gamevault.dao.PurchaseDao;
import com.gamevault.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private GameDao gameDao;
    private UserDao userDao;
    private PurchaseDao purchaseDao;

    @Override
    public void init() {
        gameDao = new GameDao();
        userDao = new UserDao();
        purchaseDao = new PurchaseDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch all data for the dashboard
        request.setAttribute("games", gameDao.getAllGames());
        request.setAttribute("users", userDao.getAllUsers());
        request.setAttribute("totalRevenue", purchaseDao.getTotalRevenue());
        request.setAttribute("recentSales", purchaseDao.getRecentPurchases());

        // Forward the request to the hidden JSP in WEB-INF
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
