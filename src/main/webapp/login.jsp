<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav>
        <a href="index.jsp" class="logo">Game<span class="accent">Vault</span></a>
    </nav>

    <main class="auth-container">
        <div class="glass-card">
            <h2>Welcome Back</h2>
            <p>Login to your account</p>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert error">Invalid username or password.</div>
            <% } %>

            <form action="auth" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn-primary btn-full">Login</button>
            </form>
            
            <div class="switch-auth">
                New to the Vault? <a href="register.jsp">Create an account</a>
            </div>
        </div>
    </main>

</body>
</html>
