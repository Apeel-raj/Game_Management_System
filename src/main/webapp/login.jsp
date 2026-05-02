<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Login</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .auth-container { max-width: 400px; margin: 4rem auto; }
        .auth-card { padding: 2.5rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; color: var(--text-secondary); }
        .form-group input { width: 100%; }
        .auth-links { margin-top: 1.5rem; text-align: center; font-size: 0.9rem; }
    </style>
</head>
<body>

    <nav>
        <a href="index.jsp" class="logo">GameVault</a>
    </nav>

    <main class="container auth-container fade-in">
        <div class="card auth-card">
            <h2 style="text-align: center; margin-bottom: 2rem;">Welcome Back</h2>
            
            <% if (request.getParameter("error") != null) { %>
                <p style="color: #ff4757; text-align: center;">Invalid username or password.</p>
            <% } %>

            <form action="auth" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="input-field" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="input-field" required>
                </div>
                
                <button type="submit" class="btn" style="width: 100%; margin-top: 1rem;">Login</button>
            </form>
            
            <div class="auth-links">
                <span style="color: var(--text-secondary);">New to the Vault?</span> 
                <a href="register.jsp" style="color: var(--primary);">Create an account</a>
            </div>
        </div>
    </main>

</body>
</html>
