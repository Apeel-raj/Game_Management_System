<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Register</title>
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
            <h2 style="text-align: center; margin-bottom: 2rem;">Join the Vault</h2>
            
            <% if (request.getParameter("error") != null) { %>
                <p style="color: #ff4757; text-align: center;">Registration failed. That email might already be registered.</p>
            <% } %>

            <form action="auth" method="POST">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="input-field" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="input-field" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="input-field" required minlength="6">
                </div>
                
                <button type="submit" class="btn" style="width: 100%; margin-top: 1rem;">Sign Up</button>
            </form>
            
            <div class="auth-links">
                <span style="color: var(--text-secondary);">Already have an account?</span> 
                <a href="login.jsp" style="color: var(--primary);">Login</a>
            </div>
        </div>
    </div>

</body>
</html>
