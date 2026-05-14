package com.gamevault.controller;

import com.gamevault.dao.UserDao;
import com.gamevault.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// This annotation maps the servlet to the URL /auth. So if the user goes to /auth?action=login, this Servlet handles it!
@WebServlet("/auth")
public class AuthController extends HttpServlet {
    
    private UserDao userDao;

    @Override
    public void init() {
        // Initialize our Data Access Object when the Servlet starts
        userDao = new UserDao();
    }

    // Handles form submissions (like pressing "Submit" on a login or register form)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("logout".equals(action)) {
            handleLogout(request, response);
        }
    }

    // Handles the actual Registration Logic
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");

        // Hash the password for security before saving it to the database!
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

        User newUser = new User(name, email, hashedPassword);

        if (userDao.registerUser(newUser)) {
            // Registration successful, redirect to login page
            response.sendRedirect("login.jsp?success=Registration successful! Please login.");
        } else {
            // Registration failed (maybe email already exists)
            response.sendRedirect("register.jsp?error=Registration failed. Email might already be taken.");
        }
    }

    // Handles the actual Login Logic
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String rawPassword = request.getParameter("password");

        User user = userDao.getUserByEmail(email);

        // Check if user exists and the password matches the hashed password in the DB
        if (user != null && BCrypt.checkpw(rawPassword, user.getPassword())) {
            // Passwords match! Create a "Session" to remember this user
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Storing the user object in the session
            session.setAttribute("role", user.getRole()); // Storing role for easy access
            
            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/dashboard"); // We will create this admin route later
            } else {
                response.sendRedirect("games"); // Normal users go to the homepage
            }
        } else {
            // Login failed
            response.sendRedirect("login.jsp?error=Invalid email or password");
        }
    }

    // Handles logging out by destroying the session
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Destroy the session
        }
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            response.sendRedirect("games");
        }
    }
}
