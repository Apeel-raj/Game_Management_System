<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - GameVault</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .error-container { text-align: center; margin-top: 10%; }
        .error-code { font-size: 6rem; font-weight: 800; color: var(--accent-glow); margin-bottom: 1rem; }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">Oops!</div>
        <h2>Something went wrong in the Vault.</h2>
        <p style="color: var(--text-secondary); margin: 2rem 0;">
            ${exception != null ? exception.message : "An unexpected error occurred."}
        </p>
        <a href="${pageContext.request.contextPath}/games" class="btn-primary">Return to Safety</a>
    </div>
</body>
</html>
