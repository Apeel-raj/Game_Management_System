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
        <a href="index.jsp" class="logo">Game<span class="accent">Vault</span></a>
        <div class="nav-links">
            <a href="games">Explore</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </nav>

    <main class="main-content">
        <div class="header-section scroll-animate">
            <h1 class="">My <span class="accent">Wishlist</span></h1>
        </div>

        <div class="games-grid">
            <% 
                List<Game> wishlist = (List<Game>) session.getAttribute("wishlist");
                if (wishlist != null && !wishlist.isEmpty()) {
                    for (Game game : wishlist) {
            %>
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
                                    <span class="game-price">$<%= game.getPrice() %></span>
                                    
                                    <form action="wishlist" method="POST">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="gameId" value="<%= game.getId() %>">
                                        <button type="submit" class="btn-action" style="color: #ff5b5b;">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </div>
            <%      }
                } else { 
            %>
                    <div style="text-align: center; color: var(--text-muted); padding: 4rem; grid-column: 1 / -1;" class="scroll-animate">
                        Your wishlist is currently empty.
                        <div style="margin-top: 1.5rem;">
                            <a href="games" class="btn-primary">Explore Games</a>
                        </div>
                    </div>
            <% } %>
        </div>
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
