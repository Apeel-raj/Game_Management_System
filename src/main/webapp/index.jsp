<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.gamevault.model.Game, com.gamevault.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Explore Games</title>
    <meta name="description" content="Discover, manage, and wishlist your favorite games on GameVault.">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav>
        <a href="index.jsp" class="logo">GameVault</a>
        <div class="nav-links">
            <% 
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
                    <span style="color: var(--text-secondary);">Welcome, <%= user.getName() %></span>
                    <% if ("admin".equals(session.getAttribute("role"))) { %>
                        <a href="admin/dashboard">Admin Panel</a>
                    <% } %>
                    <a href="wishlist">Wishlist</a>
                    <a href="auth?action=logout">Logout</a>
            <% } else { %>
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp" class="btn">Sign Up</a>
            <% } %>
        </div>
    </nav>

    <main class="container">
        <div class="header-section fade-in">
            <div>
                <h1>Explore the <span class="accent">Vault</span></h1>
                <p style="color: var(--text-secondary);">Curated collection of the best gaming experiences.</p>
            </div>
            
            <form action="games" method="GET" style="display: flex; gap: 0.5rem;">
                <input type="text" name="search" class="input-field" placeholder="Search games..." 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" 
                       style="margin: 0; padding: 0.5rem 1rem;">
                <button type="submit" class="btn" style="padding: 0.5rem 1rem;">Search</button>
            </form>
        </div>

        <div class="game-grid">
            <% 
                List<Game> games = (List<Game>) request.getAttribute("games");
                String search = request.getParameter("search");
                
                boolean hasGames = false;
                if (games != null && !games.isEmpty()) {
                    for (Game game : games) {
                        // Simple search filter
                        if (search != null && !search.isEmpty() && !game.getTitle().toLowerCase().contains(search.toLowerCase())) {
                            continue;
                        }
                        hasGames = true;
            %>
                        <div class="game-card fade-in">
                            <div class="game-logo-container">
                                <% if (game.getImagePath() != null && !game.getImagePath().isEmpty()) { %>
                                    <img src="<%= game.getImagePath() %>" alt="<%= game.getTitle() %>">
                                <% } else { %>
                                    No Logo
                                <% } %>
                            </div>
                            
                            <div class="game-content">
                                <h2 class="game-title"><%= game.getTitle() %></h2>
                                <span class="game-genre"><%= game.getGenre() %></span>
                                <p class="game-desc" style="font-size: 0.85rem; color: var(--text-secondary); margin: 0.3rem 0;"><%= game.getPlatform() %> | <%= game.getReleaseDate() %></p>
                                
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto;">
                                    <span class="game-price" style="margin: 0;">$<%= game.getPrice() %></span>
                                    
                                    <% if (user != null) { %>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <form action="wishlist" method="POST" style="margin: 0;">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                            <button type="submit" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.85rem; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.15);">Wishlist</button>
                                        </form>
                                        
                                        <form action="buy" method="POST" style="margin: 0;">
                                            <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                            <input type="hidden" name="price" value="<%= game.getPrice() %>">
                                            <button type="submit" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.85rem;">Buy Now</button>
                                        </form>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
            <% 
                    }
                }
                
                if (!hasGames) { 
            %>
                    <div style="text-align: center; color: var(--text-secondary); width: 100%; grid-column: 1 / -1; padding: 4rem;">
                        No games found in the vault yet...
                    </div>
            <% } %>
        </div>
    </main>

</body>
</html>
