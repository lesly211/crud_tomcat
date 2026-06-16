<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de Alumnos - CRUD Premium</title>
    <!-- CSS Customizado -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- SweetAlert2 para alertas modernas -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

    <div class="app-container">
        <!-- Encabezado de la Aplicación -->
        <header class="app-header">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <div class="brand-info">
                    <h1>SGA - Alumnos</h1>
                    <p>Sistema de Gestión Académica • JDBC + JSP</p>
                </div>
            </div>
            <div class="search-container">
                <form action="index.jsp" method="GET" style="display: flex; gap: 8px; width: 100%;">
                    <%
                        String search = request.getParameter("search");
                        if (search == null) search = "";
                    %>
                    <input type="text" name="search" class="form-control-search" placeholder="Buscar por nombre, apellido o ciudad..." value="<%= search %>">
                    <button type="submit" class="btn btn-secondary">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>
            <div>
                <a href="add.jsp" class="btn btn-primary">
                    <i class="fa-solid fa-user-plus"></i> Nuevo Alumno
                </a>
            </div>
        </header>

        <!-- Tarjeta Principal con la Tabla de Datos -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">
                    <i class="fa-solid fa-list-ul" style="color: var(--primary);"></i>
                    Lista de Alumnos Matriculados
                </h2>
                <span style="font-size: 13px; color: var(--text-secondary);">
                    Base de Datos: <strong style="color: var(--success);">MySQL (colegio)</strong>
                </span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="premium-table">
                        <thead>
                            <tr>
                                <th style="width: 80px;">ID</th>
                                <th>Alumno</th>
                                <th>Teléfono</th>
                                <th>Ciudad</th>
                                <th>Dirección</th>
                                <th style="width: 180px; text-align: center;">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                int rowCount = 0;
                                try {
                                    conn = getConnection();
                                    if (conn != null) {
                                        String sql = "SELECT * FROM alumnos";
                                        if (!search.trim().isEmpty()) {
                                            sql += " WHERE nombres LIKE ? OR apellidos LIKE ? OR ciudad LIKE ?";
                                            pstmt = conn.prepareStatement(sql);
                                            String queryParam = "%" + search + "%";
                                            pstmt.setString(1, queryParam);
                                            pstmt.setString(2, queryParam);
                                            pstmt.setString(3, queryParam);
                                        } else {
                                            pstmt = conn.prepareStatement(sql);
                                        }
                                        
                                        rs = pstmt.executeQuery();
                                        while (rs.next()) {
                                            rowCount++;
                                            int id = rs.getInt("id");
                                            String nombres = rs.getString("nombres");
                                            String apellidos = rs.getString("apellidos");
                                            String telefono = rs.getString("telefono");
                                            String ciudad = rs.getString("ciudad");
                                            String direccion = rs.getString("direccion");
                                            
                                            // Obtener primera letra del nombre para el avatar
                                            String initial = "A";
                                            if (nombres != null && !nombres.isEmpty()) {
                                                initial = nombres.substring(0, 1).toUpperCase();
                                            }
                            %>
                            <tr>
                                <td style="font-weight: 700; color: var(--text-secondary);">#<%= id %></td>
                                <td>
                                    <div class="avatar-info">
                                        <div class="avatar-circle">
                                            <%= initial %>
                                        </div>
                                        <div>
                                            <div class="student-name"><%= nombres %></div>
                                            <div style="font-size: 12px; color: var(--text-secondary);"><%= apellidos %></div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <i class="fa-solid fa-phone" style="font-size: 12px; color: var(--text-muted); margin-right: 5px;"></i>
                                    <%= (telefono != null && !telefono.isEmpty()) ? telefono : "<span style='color: var(--text-muted); font-style: italic;'>No asignado</span>" %>
                                </td>
                                <td>
                                    <span class="badge badge-city">
                                        <i class="fa-solid fa-location-dot" style="margin-right: 4px;"></i><%= ciudad %>
                                    </span>
                                </td>
                                <td style="max-width: 250px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                    <%= direccion %>
                                </td>
                                <td>
                                    <div class="actions-group" style="justify-content: center;">
                                        <a href="edit.jsp?id=<%= id %>" class="btn btn-secondary btn-sm" title="Editar Alumno">
                                            <i class="fa-solid fa-pen-to-square" style="color: var(--primary);"></i> Editar
                                        </a>
                                        <button class="btn btn-danger btn-sm" title="Eliminar Alumno" onclick="confirmarEliminacion(<%= id %>, '<%= nombres + " " + apellidos %>')">
                                            <i class="fa-solid fa-trash-can"></i> Eliminar
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                        }
                                    } else {
                            %>
                            <tr>
                                <td colspan="6" style="text-align: center; color: var(--danger); padding: 30px;">
                                    <i class="fa-solid fa-circle-exclamation" style="font-size: 24px; margin-bottom: 10px;"></i>
                                    <div>Error: No se pudo establecer la conexión con la base de datos MySQL. Verifique que XAMPP esté iniciado.</div>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='6' style='color: var(--danger);'>Error al procesar consulta: " + e.getMessage() + "</td></tr>");
                                } finally {
                                    if (rs != null) try { rs.close(); } catch(SQLException e){}
                                    if (pstmt != null) try { pstmt.close(); } catch(SQLException e){}
                                    if (conn != null) try { conn.close(); } catch(SQLException e){}
                                }
                                
                                if (rowCount == 0 && conn != null) {
                            %>
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">
                                            <i class="fa-solid fa-user-slash"></i>
                                        </div>
                                        <h3>No se encontraron alumnos</h3>
                                        <p>Pruebe con otros términos de búsqueda o agregue un nuevo registro.</p>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Alertas de SweetAlert -->
        <%
            String status = request.getParameter("status");
            if (status != null) {
                if (status.equals("saved")) {
        %>
                <script>
                    Swal.fire({
                        title: '¡Guardado Exitoso!',
                        text: 'El alumno ha sido registrado correctamente.',
                        icon: 'success',
                        background: '#1e293b',
                        color: '#f8fafc',
                        confirmButtonColor: '#6366f1',
                        iconColor: '#34d399'
                    });
                </script>
        <%
                } else if (status.equals("updated")) {
        %>
                <script>
                    Swal.fire({
                        title: '¡Actualizado!',
                        text: 'Los datos del alumno han sido modificados.',
                        icon: 'success',
                        background: '#1e293b',
                        color: '#f8fafc',
                        confirmButtonColor: '#6366f1',
                        iconColor: '#34d399'
                    });
                </script>
        <%
                } else if (status.equals("deleted")) {
        %>
                <script>
                    Swal.fire({
                        title: '¡Eliminado!',
                        text: 'El alumno ha sido removido del sistema.',
                        icon: 'success',
                        background: '#1e293b',
                        color: '#f8fafc',
                        confirmButtonColor: '#6366f1',
                        iconColor: '#f87171'
                    });
                </script>
        <%
                } else if (status.equals("error")) {
        %>
                <script>
                    Swal.fire({
                        title: 'Error',
                        text: 'Ocurrió un error al procesar la solicitud.',
                        icon: 'error',
                        background: '#1e293b',
                        color: '#f8fafc',
                        confirmButtonColor: '#ef4444'
                    });
                </script>
        <%
                }
            }
        %>

        <script>
            function confirmarEliminacion(id, nombre) {
                Swal.fire({
                    title: '¿Está seguro de eliminar?',
                    text: "Esta acción eliminará permanentemente al alumno: " + nombre,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ef4444',
                    cancelButtonColor: 'rgba(255, 255, 255, 0.08)',
                    confirmButtonText: 'Sí, eliminar',
                    cancelButtonText: 'Cancelar',
                    background: '#1e293b',
                    color: '#f8fafc',
                    iconColor: '#fbbf24',
                    customClass: {
                        cancelButton: 'btn btn-secondary'
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'delete.jsp?id=' + id;
                    }
                });
            }
        </script>

        <footer class="app-footer">
            <p>&copy; 2026 SGA • Todos los derechos reservados. Desarrollado con tecnología Java EE & JSP.</p>
        </footer>
    </div>
</body>
</html>
