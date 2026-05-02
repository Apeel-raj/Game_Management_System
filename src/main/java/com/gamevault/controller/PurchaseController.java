package com.gamevault.controller;

import com.gamevault.dao.PurchaseDao;
import com.gamevault.model.Purchase;
import com.gamevault.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/buy")
public class PurchaseController extends HttpServlet {
    private PurchaseDao purchaseDao;

    @Override
    public void init() {
        purchaseDao = new PurchaseDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login to buy games.");
            return;
        }

        User user = (User) session.getAttribute("user");
        int gameId = Integer.parseInt(request.getParameter("gameId"));
        double price = Double.parseDouble(request.getParameter("price"));

        Purchase purchase = new Purchase(user.getId(), gameId, price);
        if (purchaseDao.addPurchase(purchase)) {
            response.sendRedirect("games?success=Game purchased successfully!");
        } else {
            response.sendRedirect("games?error=Failed to complete purchase.");
        }
    }
}
