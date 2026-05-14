<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GameVault - Register</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav>
        <a href="index.jsp" class="logo">Game<span class="accent">Vault</span></a>
    </nav>

    <main class="auth-container">
        <div class="glass-card">
            <h2>Join the Vault</h2>
            <p>Create a free account to continue</p>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert error">Registration failed. That email might already be registered.</div>
            <% } %>

            <form action="auth" method="POST">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required minlength="6">
                </div>
                
                <button type="submit" class="btn-primary btn-full">Sign Up</button>
            </form>
            
            <div class="switch-auth">
                Already have an account? <a href="login.jsp">Login</a>
            </div>
        </div>
    </main>

</body>
</html>
