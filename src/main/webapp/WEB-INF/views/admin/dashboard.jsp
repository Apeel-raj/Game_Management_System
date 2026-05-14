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
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 1rem; background: var(--bg-card); border-radius: 4px; overflow: hidden; border: 1px solid rgba(0,0,0,0.5); }
        .admin-table th, .admin-table td { padding: 1rem; text-align: left; border-bottom: 1px solid var(--border-light); }
        .admin-table th { background: rgba(0,0,0,0.4); color: var(--accent-blue); font-weight: 600; text-transform: uppercase; font-size: 0.85rem; }
        .admin-table tr:hover { background: rgba(255,255,255,0.02); }
        .action-btn { background: none; border: none; color: #ff5b5b; cursor: pointer; text-decoration: underline; font-family: inherit; font-size: 0.9rem; }
        .action-btn:hover { color: #ff8c8c; }
        .metrics-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .metric-card { background: var(--bg-card); padding: 1.5rem; border-radius: 4px; border: 1px solid rgba(0,0,0,0.5); text-align: center; }
        .metric-value { font-size: 2.5rem; font-weight: 800; color: var(--accent-blue); margin-top: 0.5rem; }
        .admin-panel-card { background: var(--bg-card); border: 1px solid rgba(0,0,0,0.5); padding: 2rem; border-radius: 4px; margin-bottom: 2rem; }
        .admin-title { color: var(--text-bright); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; font-size: 1.2rem; text-transform: uppercase; }
        .admin-title::before { content: ''; width: 4px; height: 1.2rem; background: var(--accent-blue); display: block; }
    </style>
</head>
<body>

    <nav>
        <a href="${pageContext.request.contextPath}/games" class="logo">Game<span class="accent">Vault</span> <span style="font-size: 0.8rem; color: var(--text-muted); font-weight: 400; letter-spacing: 1px;">ADMIN</span></a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/games">View Store</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>

    <main class="main-content scroll-animate in-view">
        <h1 style="margin-bottom: 2rem; color: var(--text-bright);">Dashboard Overview</h1>
        
        <!-- Analytics Metrics -->
        <% 
            Double totalRev = (Double) request.getAttribute("totalRevenue"); 
            List<Game> games = (List<Game>) request.getAttribute("games");
            List<User> users = (List<User>) request.getAttribute("users");
            List<Purchase> sales = (List<Purchase>) request.getAttribute("recentSales");
        %>
        <div class="metrics-grid">
            <div class="metric-card">
                <div style="color: var(--text-muted); text-transform: uppercase; font-size: 0.85rem; font-weight: 600;">Total Revenue</div>
                <div class="metric-value">$<%= String.format("%.2f", totalRev != null ? totalRev : 0.0) %></div>
            </div>
            <div class="metric-card">
                <div style="color: var(--text-muted); text-transform: uppercase; font-size: 0.85rem; font-weight: 600;">Total Users</div>
                <div class="metric-value"><%= users != null ? users.size() : 0 %></div>
            </div>
            <div class="metric-card">
                <div style="color: var(--text-muted); text-transform: uppercase; font-size: 0.85rem; font-weight: 600;">Games in Vault</div>
                <div class="metric-value"><%= games != null ? games.size() : 0 %></div>
            </div>
        </div>

        <!-- Add New Game -->
        <div class="admin-panel-card">
            <h3 class="admin-title">Add New Game</h3>
            <form action="${pageContext.request.contextPath}/admin/games" method="POST" enctype="multipart/form-data" style="display: grid; gap: 1rem;">
                <input type="hidden" name="action" value="addGame">
                <div class="form-group" style="margin:0;">
                    <input type="text" name="title" placeholder="Game Title" required>
                </div>
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 1rem;">
                    <div class="form-group" style="margin:0;"><input type="text" name="genre" placeholder="Genre" required></div>
                    <div class="form-group" style="margin:0;"><input type="text" name="platform" placeholder="Platform" required></div>
                    <div class="form-group" style="margin:0;"><input type="date" name="releaseDate" required style="color: var(--text-muted);"></div>
                    <div class="form-group" style="margin:0;"><input type="number" step="0.01" name="price" placeholder="Price (e.g. 59.99)" required></div>
                </div>
                <div class="form-group" style="margin:0;">
                    <label style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: 0.5rem; display: block; text-transform: uppercase;">Game Logo Image</label>
                    <input type="file" name="image" accept="image/*" style="background: rgba(0,0,0,0.2); border: 1px dashed var(--accent-blue); padding: 1rem;">
                </div>
                <button type="submit" class="btn-primary" style="justify-self: start; margin-top: 0.5rem;">Publish Game</button>
            </form>
        </div>

        <!-- User Management -->
        <h3 class="admin-title" style="margin-top: 3rem;">User Management</h3>
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
                        <td style="color: var(--text-muted);"><%= u.getId() %></td>
                        <td style="font-weight: 600;"><%= u.getName() %></td>
                        <td style="color: var(--text-muted);"><%= u.getEmail() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/admin/games" method="POST" style="margin: 0; display: flex; gap: 0.5rem; align-items: center;">
                                <input type="hidden" name="action" value="updateUserRole">
                                <input type="hidden" name="userId" value="<%= u.getId() %>">
                                <select name="role" style="background: rgba(0,0,0,0.4); color: var(--text-primary); border: 1px solid var(--border-light); padding: 0.4rem; border-radius: 2px;">
                                    <option value="user" <%= "user".equals(u.getRole()) ? "selected" : "" %>>User</option>
                                    <option value="admin" <%= "admin".equals(u.getRole()) ? "selected" : "" %>>Admin</option>
                                </select>
                                <button type="submit" class="btn" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Update</button>
                            </form>
                        </td>
                        <td>-</td>
                    </tr>
                <% } } %>
            </tbody>
        </table>

        <!-- Recent Sales -->
        <h3 class="admin-title" style="margin-top: 3rem;">Recent Sales</h3>
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
                        <td style="color: var(--text-muted);"><%= p.getPurchaseDate() != null ? p.getPurchaseDate().toString().substring(0, 16) : "N/A" %></td>
                        <td style="font-weight: 600;"><%= p.getUserName() %></td>
                        <td><%= p.getGameTitle() %></td>
                        <td style="color: var(--accent-green); font-weight: 800;">$<%= String.format("%.2f", p.getPrice()) %></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="4" style="text-align: center; color: var(--text-muted); padding: 2rem;">No sales yet.</td></tr>
                <% } %>
            </tbody>
        </table>

        <!-- Manage Games -->
        <h3 class="admin-title" style="margin-top: 3rem;">Current Library</h3>
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
                            <td style="color: var(--text-muted);"><%= game.getId() %></td>
                            <td style="font-weight: 600; color: var(--text-bright);"><%= game.getTitle() %></td>
                            <td style="color: var(--text-muted);"><%= game.getGenre() %></td>
                            <td style="color: var(--accent-blue);">$<%= game.getPrice() %></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/games" method="POST" style="margin: 0; display: inline;">
                                    <input type="hidden" name="action" value="deleteGame">
                                    <input type="hidden" name="id" value="<%= game.getId() %>">
                                    <button type="submit" class="action-btn" onclick="return confirm('Delete this game?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                <% } } else { %>
                    <tr><td colspan="5" style="text-align: center; color: var(--text-muted); padding: 2rem;">No games available.</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>

</body>
</html>
