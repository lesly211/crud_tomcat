<%@ page import="java.sql.*" %>
<%!
    // Método para obtener la conexión a la base de datos
    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/colegio?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            conn = DriverManager.getConnection(url, "root", "");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver JDBC no encontrado. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error: Falló la conexión a la base de datos. " + e.getMessage());
        }
        return conn;
    }
%>
