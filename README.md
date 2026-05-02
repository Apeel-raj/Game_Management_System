# 🎮 GameVault - Game Management System

A full-stack Java web application built with **Jakarta EE**, **Apache Tomcat 10**, and **MySQL**. GameVault allows users to browse, wishlist, and purchase games, while admins can manage the entire platform from a dedicated dashboard.

---

## 🚀 Features

### 👤 Users
- Register & Login with BCrypt password hashing
- Browse the game library with Search
- Add games to Wishlist
- Buy games

### 🛡️ Admin Panel
- View live analytics: Total Revenue, Total Users, Games in Vault
- Add new games with image/logo upload
- Delete games from the library
- Manage user roles (promote/demote to Admin)
- View Recent Sales report

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Framework | Jakarta EE (Servlet 6.0) |
| Server | Apache Tomcat 10 |
| Database | MySQL 8 |
| Build Tool | Maven |
| Security | jBCrypt (password hashing) |
| Frontend | HTML, CSS, JSP |

---

## ⚙️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Apeel-raj/Game_Management_System.git
```

### 2. Set Up the Database
- Open **phpMyAdmin** or **MySQL Workbench**
- Run the full `database.sql` file included in the root of this project
- This will create the `gamevault_db` database, all tables, and seed 3 sample games

### 3. Configure Database Connection
Open `src/main/java/com/gamevault/util/DBConnection.java` and update:
```java
private static final String URL = "jdbc:mysql://localhost:3306/gamevault_db";
private static final String USER = "root";       // your MySQL username
private static final String PASSWORD = "";       // your MySQL password
```

### 4. Import into Eclipse
- Open Eclipse → **File → Import → Existing Maven Projects**
- Select the cloned folder
- Right-click project → **Run As → Run on Server** (Tomcat 10)

### 5. Make Yourself an Admin
After registering an account, run this SQL:
```sql
UPDATE users SET role = 'admin' WHERE email = 'your@email.com';
```
Then log back in — you'll see the **Admin Panel** link in the nav!

---

## 📁 Project Structure

```
GameVault/
├── src/main/java/com/gamevault/
│   ├── controller/   # Servlets (Auth, Game, Wishlist, Admin, Purchase)
│   ├── dao/          # Database access (UserDao, GameDao, PurchaseDao)
│   ├── model/        # Java models (User, Game, Purchase)
│   ├── filter/       # AdminFilter (role-based access control)
│   └── util/         # DBConnection
├── src/main/webapp/
│   ├── css/          # Stylesheet
│   ├── WEB-INF/views/admin/  # Admin dashboard JSP
│   ├── index.jsp     # Homepage
│   ├── login.jsp
│   ├── register.jsp
│   └── wishlist.jsp
├── database.sql      # ⬅️ Run this first!
└── pom.xml
```
