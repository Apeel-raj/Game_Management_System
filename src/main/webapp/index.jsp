<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.gamevault.model.Game, com.gamevault.model.User, java.util.ArrayList" %>
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
        <a href="index.jsp" class="logo">Game<span class="accent">Vault</span></a>
        <div class="nav-links">
            <% 
                User user = (User) session.getAttribute("user");
                if (user != null) {
            %>
                    <span style="color: var(--text-muted);">Welcome, <%= user.getName() %></span>
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

    <main class="main-content">
        <div class="header-section scroll-animate">
            <div>
                <h1>Explore the Vault</h1>
                <p style="color: var(--text-muted); margin-top: 0.5rem;">Curated collection of the best gaming experiences.</p>
            </div>
            
            <form action="games" method="GET" style="display: flex; gap: 0.5rem;">
                <input type="text" name="search" class="input-field" placeholder="Search games..." 
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit" class="btn">Search</button>
            </form>
        </div>

        <% 
            List<Game> games = (List<Game>) request.getAttribute("games");
            String search = request.getParameter("search");
            
            List<Game> deals = new ArrayList<>();
            List<Game> regularGames = new ArrayList<>();
            
            boolean hasGames = false;
            if (games != null && !games.isEmpty()) {
                for (Game game : games) {
                    // Simple search filter
                    if (search != null && !search.isEmpty() && !game.getTitle().toLowerCase().contains(search.toLowerCase())) {
                        continue;
                    }
                    hasGames = true;
                    if (game.getPrice() < 30.0 && game.getPrice() > 0) {
                        deals.add(game);
                    } else {
                        regularGames.add(game);
                    }
                }
            }
        %>

        <% if (hasGames) { %>
            
            <% if (!deals.isEmpty()) { %>
            <h2 class="section-title scroll-animate">Featured Deals</h2>
            <div class="deals-grid">
                <% for (Game game : deals) { %>
                    <div class="game-card scroll-animate">
                        <div class="game-logo-container">
                            <% if (game.getImagePath() != null && !game.getImagePath().isEmpty()) { %>
                                <img src="<%= game.getImagePath() %>" alt="<%= game.getTitle() %>" loading="lazy">
                            <% } else { %>
                                <%= game.getTitle() %>
                            <% } %>
                        </div>
                        
                        <div class="game-content">
                            <h2 class="game-title"><%= game.getTitle() %></h2>
                            <span class="game-genre"><%= game.getGenre() %></span>
                            <p class="game-desc"><%= game.getPlatform() %></p>
                            
                            <div class="game-footer">
                                <div class="game-price-container">
                                    <span class="discount-badge">-15%</span>
                                    <span class="game-price">$<%= game.getPrice() %></span>
                                </div>
                                
                                <% if (user != null) { %>
                                <div class="card-actions">
                                    <form action="wishlist" method="POST">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <button type="submit" class="btn-action">Wishlist</button>
                                    </form>
                                    
                                    <form action="buy" method="POST">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <input type="hidden" name="price" value="<%= game.getPrice() %>">
                                        <button type="submit" class="btn-primary btn-small">Buy</button>
                                    </form>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            <% } %>

            <h2 class="section-title scroll-animate">All Games</h2>
            <div class="games-grid">
                <% for (Game game : regularGames) { %>
                    <div class="game-card scroll-animate">
                        <div class="game-logo-container">
                            <% if (game.getImagePath() != null && !game.getImagePath().isEmpty()) { %>
                                <img src="<%= game.getImagePath() %>" alt="<%= game.getTitle() %>" loading="lazy">
                            <% } else { %>
                                <%= game.getTitle() %>
                            <% } %>
                        </div>
                        
                        <div class="game-content">
                            <h2 class="game-title"><%= game.getTitle() %></h2>
                            <span class="game-genre"><%= game.getGenre() %></span>
                            <p class="game-desc"><%= game.getPlatform() %> | <%= game.getReleaseDate() %></p>
                            
                            <div class="game-footer">
                                <span class="game-price"><%= game.getPrice() == 0 ? "Free to Play" : "$" + game.getPrice() %></span>
                                
                                <% if (user != null) { %>
                                <div class="card-actions">
                                    <form action="wishlist" method="POST">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <button type="submit" class="btn-action" title="Add to Wishlist">♥</button>
                                    </form>
                                    
                                    <form action="buy" method="POST">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <input type="hidden" name="price" value="<%= game.getPrice() %>">
                                        <button type="submit" class="btn-primary btn-small">Buy</button>
                                    </form>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>

        <% } else { %>
            <div style="text-align: center; color: var(--text-muted); padding: 4rem;" class="scroll-animate">
                No games found in the vault yet...
            </div>
        <% } %>
    </main>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const observerOptions = {
                root: null,
                rootMargin: '0px',
                threshold: 0.1
            };

            const observer = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('in-view');
                        observer.unobserve(entry.target);
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.scroll-animate').forEach(el => {
                observer.observe(el);
            });
        });
    </script>
</body>
</html>
