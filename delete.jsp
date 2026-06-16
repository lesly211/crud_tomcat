<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null || idStr.trim().isEmpty()) {
        response.sendRedirect("index.jsp?status=error");
        return;
    }

    int id = Integer.parseInt(idStr);
    Connection conn = null;
    PreparedStatement pstmt = null;
    boolean success = false;

    try {
        conn = getConnection();
        if (conn != null) {
            String sql = "DELETE FROM alumnos WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                success = true;
                response.sendRedirect("index.jsp?status=deleted");
                return;
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
