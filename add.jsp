<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Nuevo Alumno - SGA</title>
    <!-- CSS Customizado -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <div class="app-container" style="max-width: 800px;">
        <!-- Encabezado -->
        <header class="app-header">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fa-solid fa-user-plus"></i>
                </div>
                <div class="brand-info">
                    <h1>Nuevo Alumno</h1>
                    <p>Agregar un nuevo registro al sistema</p>
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
                    <i class="fa-regular fa-clipboard" style="color: var(--primary);"></i>
                    Formulario de Registro
                </h2>
            </div>
            <div class="card-body">
                <form action="save.jsp" method="POST">
                    <!-- Campo oculto para indicar acción de registro -->
                    <input type="hidden" name="action" value="create">

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="nombres" class="form-label">Nombres <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="nombres" name="nombres" class="form-control" placeholder="Ej. Carlos Augusto" required autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="apellidos" class="form-label">Apellidos <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="apellidos" name="apellidos" class="form-control" placeholder="Ej. Mendoza Gomez" required autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="telefono" class="form-label">Teléfono / Celular</label>
                            <input type="tel" id="telefono" name="telefono" class="form-control" placeholder="Ej. 987654321" autocomplete="off">
                        </div>

                        <div class="form-group">
                            <label for="ciudad" class="form-label">Ciudad <span style="color: var(--danger);">*</span></label>
                            <input type="text" id="ciudad" name="ciudad" class="form-control" placeholder="Ej. Lima" required autocomplete="off">
                        </div>

                        <div class="form-group full-width">
                            <label for="direccion" class="form-label">Dirección Domiciliaria</label>
                            <input type="text" id="direccion" name="direccion" class="form-control" placeholder="Ej. Av. Larco 123, Dpto. 401" autocomplete="off">
                        </div>
                    </div>

                    <div class="form-actions">
                        <a href="index.jsp" class="btn btn-secondary">
                            <i class="fa-solid fa-xmark"></i> Cancelar
                        </a>
                        <button type="submit" class="btn btn-success">
                            <i class="fa-solid fa-floppy-disk"></i> Guardar Alumno
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
