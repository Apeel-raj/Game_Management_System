package com.gamevault.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// This filter intercepts any request that goes to /admin/*
@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Check if session exists and role is admin
        boolean isAdmin = (session != null && "admin".equals(session.getAttribute("role")));

        if (isAdmin) {
            // User is admin, allow the request to pass through
            chain.doFilter(request, response);
        } else {
            // User is not an admin, redirect them to login with an error message
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=Access Denied! Admin privileges required.");
        }
    }

    @Override
    public void destroy() {}
}
