<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    // Configurar la codificación para recibir caracteres como tildes y ñ
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");
    if (action == null) {
        response.sendRedirect("index.jsp?status=error");
        return;
    }

    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");
    String telefono = request.getParameter("telefono");
    String ciudad = request.getParameter("ciudad");
    String direccion = request.getParameter("direccion");

    Connection conn = null;
    PreparedStatement pstmt = null;
    boolean success = false;

    try {
        conn = getConnection();
        if (conn != null) {
            if (action.equals("create")) {
                String sql = "INSERT INTO alumnos (nombres, apellidos, telefono, ciudad, direccion) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nombres);
                pstmt.setString(2, apellidos);
                pstmt.setString(3, telefono);
                pstmt.setString(4, ciudad);
                pstmt.setString(5, direccion);
                
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    success = true;
                    response.sendRedirect("index.jsp?status=saved");
                    return;
                }
            } else if (action.equals("update")) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.trim().isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    String sql = "UPDATE alumnos SET nombres = ?, apellidos = ?, telefono = ?, ciudad = ?, direccion = ? WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, nombres);
                    pstmt.setString(2, apellidos);
                    pstmt.setString(3, telefono);
                    pstmt.setString(4, ciudad);
                    pstmt.setString(5, direccion);
                    pstmt.setInt(6, id);
                    
                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        success = true;
                        response.sendRedirect("index.jsp?status=updated");
                        return;
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
        if (conn != null) try { conn.close(); } catch(SQLException e){}
    }

    // Si llega a este punto sin redireccionar, hubo un error
    response.sendRedirect("index.jsp?status=error");
%>
