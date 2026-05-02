<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.gamevault.model.Game, com.gamevault.model.User, com.gamevault.model.Purchase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 1rem; background: rgba(30, 41, 59, 0.5); border-radius: 12px; overflow: hidden; }
        .admin-table th, .admin-table td { padding: 1rem; text-align: left; border-bottom: 1px solid rgba(255,255,255,0.05); }
        .admin-table th { background: rgba(30, 41, 59, 0.8); color: var(--text-secondary); font-weight: 500; }
        .action-btn { background: none; border: none; color: #ff4757; cursor: pointer; text-decoration: underline; font-family: inherit; }
        .metrics-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .metric-card { background: var(--surface); padding: 1.5rem; border-radius: 12px; border: 1px solid rgba(255,255,255,0.05); text-align: center; }
        .metric-value { font-size: 2rem; font-weight: bold; color: var(--primary); margin-top: 0.5rem; }
    </style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/games" class="logo">GameVault <span style="font-size: 0.8rem; color: var(--primary);">ADMIN</span></a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/games">View Site</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>

    <main class="container fade-in">
        <h1 style="margin-bottom: 2rem;">Admin Dashboard</h1>
        
        <!-- Analytics Metrics -->
        <% 
            Double totalRev = (Double) request.getAttribute("totalRevenue"); 
            List<Game> games = (List<Game>) request.getAttribute("games");
            List<User> users = (List<User>) request.getAttribute("users");
            List<Purchase> sales = (List<Purchase>) request.getAttribute("recentSales");
        %>
        <div class="metrics-grid">
            <div class="metric-card">
                <div style="color: var(--text-secondary);">Total Revenue</div>
                <div class="metric-value">$<%= String.format("%.2f", totalRev != null ? totalRev : 0.0) %></div>
            </div>
            <div class="metric-card">
                <div style="color: var(--text-secondary);">Total Users</div>
                <div class="metric-value"><%= users != null ? users.size() : 0 %></div>
            </div>
            <div class="metric-card">
                <div style="color: var(--text-secondary);">Games in Vault</div>
                <div class="metric-value"><%= games != null ? games.size() : 0 %></div>
            </div>
        </div>

        <!-- Add New Game -->
        <div class="card" style="padding: 2rem; margin-bottom: 2rem;">
            <h3>Add New Game</h3>
            <form action="${pageContext.request.contextPath}/admin/games" method="POST" enctype="multipart/form-data" style="display: grid; gap: 1rem; margin-top: 1rem;">
                <input type="hidden" name="action" value="addGame">
                <input type="text" name="title" class="input-field" placeholder="Game Title" required>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                    <input type="text" name="genre" class="input-field" placeholder="Genre" required>
                    <input type="text" name="platform" class="input-field" placeholder="Platform" required>
                    <input type="date" name="releaseDate" class="input-field" required>
                    <input type="number" step="0.01" name="price" class="input-field" placeholder="Price (e.g. 59.99)" required>
                </div>
                <div>
                    <label style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 0.5rem; display: block;">Game Logo Image</label>
                    <input type="file" name="image" class="input-field" accept="image/*">
                </div>
                <button type="submit" class="btn" style="justify-self: start;">Add Game</button>
            </form>
        </div>

        <!-- User Management -->
        <h3 style="margin-top: 2rem;">User Management</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% if (users != null && !users.isEmpty()) {
                    for (User u : users) { %>
                    <tr>
                        <td><%= u.getId() %></td>
                        <td><%= u.getName() %></td>
                        <td><%= u.getEmail() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/games" method="POST" style="margin: 0; display: flex; gap: 0.5rem;">
                                <input type="hidden" name="action" value="updateUserRole">
                                <input type="hidden" name="userId" value="<%= u.getId() %>">
                                <select name="role" style="background: var(--bg-dark); color: white; border: 1px solid rgba(255,255,255,0.1); padding: 0.2rem; border-radius: 4px;">
                                    <option value="user" <%= "user".equals(u.getRole()) ? "selected" : "" %>>User</option>
                                    <option value="admin" <%= "admin".equals(u.getRole()) ? "selected" : "" %>>Admin</option>
                                </select>
                                <button type="submit" class="btn" style="padding: 0.2rem 0.5rem; font-size: 0.8rem;">Update</button>
                            </form>
                        </td>
                        <td>-</td>
                    </tr>
                <% } } %>
            </tbody>
        </table>

        <!-- Recent Sales -->
        <h3 style="margin-top: 2rem;">Recent Sales</h3>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>User</th>
                    <th>Game</th>
                    <th>Price Paid</th>
                </tr>
            </thead>
            <tbody>
                <% if (sales != null && !sales.isEmpty()) {
                    for (Purchase p : sales) { %>
                    <tr>
                        <td><%= p.getPurchaseDate() != null ? p.getPurchaseDate().toString().substring(0, 16) : "N/A" %></td>
                        <td><%= p.getUserName() %></td>
                        <td><%= p.getGameTitle() %></td>
                        <td style="color: var(--primary); font-weight: bold;">$<%= String.format("%.2f", p.getPrice()) %></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="4" style="text-align: center; color: var(--text-secondary);">No sales yet.</td></tr>
                <% } %>
            </tbody>
        </table>

        <!-- Manage Games -->
        <h3 style="margin-top: 2rem;">Current Library</h3>
        <table class="admin-table" style="margin-bottom: 4rem;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (games != null && !games.isEmpty()) {
                    for (Game game : games) { %>
                        <tr>
                            <td><%= game.getId() %></td>
                            <td><%= game.getTitle() %></td>
                            <td><%= game.getGenre() %></td>
                            <td>$<%= game.getPrice() %></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/games" method="POST" style="margin: 0; display: inline;">
                                    <input type="hidden" name="action" value="deleteGame">
                                    <input type="hidden" name="id" value="<%= game.getId() %>">
                                    <button type="submit" class="action-btn" onclick="return confirm('Delete this game?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                <% } } else { %>
                    <tr><td colspan="5" style="text-align: center; color: var(--text-secondary);">No games available.</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>

</body>
</html>
