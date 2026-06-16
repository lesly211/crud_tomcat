<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Alumno - SGA</title>
    <!-- CSS Customizado -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <%
        // Obtener el ID del alumno a editar
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("index.jsp?status=error");
            return;
        }

        int id = Integer.parseInt(idStr);
        String nombres = "";
        String apellidos = "";
        String telefono = "";
        String ciudad = "";
        String direccion = "";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean found = false;

        try {
            conn = getConnection();
            if (conn != null) {
                String sql = "SELECT * FROM alumnos WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    nombres = rs.getString("nombres");
                    apellidos = rs.getString("apellidos");
                    telefono = rs.getString("telefono");
                    ciudad = rs.getString("ciudad");
                    direccion = rs.getString("direccion");
                    found = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException e){}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
            if (conn != null) try { conn.close(); } catch(SQLException e){}
        }

        if (!found) {
            response.sendRedirect("index.jsp?status=error");
            return;
        }
    %>

    <div class="app-container" style="max-width: 800px;">
        <!-- Encabezado -->
        <header class="app-header">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fa-solid fa-user-pen"></i>
                </div>
                <div class="brand-info">
                    <h1>Editar Alumno</h1>
                    <p>Modificar la información del estudiante en el sistema</p>
                </div>
            </div>
            <div>
                <a href="index.jsp" class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left"></i> Volver
                </a>
            </div>
        </header>

        <!-- Tarjeta del Formulario -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fa-solid fa-id-card" style="color: var(--primary);"></i>
                    Actualizar Datos del Alumno #<%= id %>
                </h2>
            </div>
            <div class="card-body">
                <form action="save.jsp" method="POST">
                    <!-- Campo oculto para indicar acción de actualización y el ID -->
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= id %>">

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="nombres" class="form-label">Nombres <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="nombres" name="nombres" class="form-control" placeholder="Ej. Carlos Augusto" value="<%= nombres %>" required autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="apellidos" class="form-label">Apellidos <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="apellidos" name="apellidos" class="form-control" placeholder="Ej. Mendoza Gomez" value="<%= apellidos %>" required autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="telefono" class="form-label">Teléfono / Celular</label>
                            <input type="tel" id="telefono" name="telefono" class="form-control" placeholder="Ej. 987654321" value="<%= (telefono != null) ? telefono : "" %>" autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="ciudad" class="form-label">Ciudad <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="ciudad" name="ciudad" class="form-control" placeholder="Ej. Lima" value="<%= ciudad %>" required autocomplete="off">
                        </div>

                        <div class="form-group full-width">
                            <label for="direccion" class="form-label">Dirección Domiciliaria</label>
                            <input type="text" id="direccion" name="direccion" class="form-control" placeholder="Ej. Av. Larco 123, Dpto. 401" value="<%= (direccion != null) ? direccion : "" %>" autocomplete="off">
                        </div>
                    </div>

                    <div class="form-actions">
                        <a href="index.jsp" class="btn btn-secondary">
                            <i class="fa-solid fa-xmark"></i> Cancelar
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-cloud-arrow-up"></i> Actualizar Alumno
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <footer class="app-footer">
            <p>&copy; 2026 SGA • Todos los derechos reservados.</p>
        </footer>
    </div>
</body>
</html>
