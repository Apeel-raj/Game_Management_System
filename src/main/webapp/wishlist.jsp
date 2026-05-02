<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.gamevault.model.Game, com.gamevault.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - My Wishlist</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav>
        <a href="index.jsp" class="logo">GameVault</a>
        <div class="nav-links">
            <a href="games">Explore</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </nav>

    <main class="container">
        <div class="header-section">
            <h1 class="fade-in">My <span class="accent">Wishlist</span></h1>
        </div>

        <div class="game-grid">
            <% 
                List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
                if (wishlist != null && !wishlist.isEmpty()) {
                    for (Game game : wishlist) {
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
                                    
                                    <form action="wishlist" method="POST" style="margin: 0;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <button type="submit" class="btn" style="background: rgba(239, 68, 68, 0.2); border: 1px solid rgba(239, 68, 68, 0.4); color: #f87171; padding: 0.4rem 0.8rem; font-size: 0.85rem;">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </div>
            <%      }
                } else { 
            %>
                    <div style="text-align: center; color: var(--text-secondary); width: 100%; grid-column: 1 / -1; padding: 4rem;">
                        Your wishlist is currently empty.
                        <div style="margin-top: 1rem;">
                            <a href="games" class="btn">Explore Games</a>
                        </div>
                    </div>
            <% } %>
        </div>
    </main>

</body>
</html>
