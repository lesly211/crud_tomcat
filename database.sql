-- Crear base de datos
CREATE DATABASE IF NOT EXISTS colegio;
USE colegio;

-- Crear tabla alumnos
CREATE TABLE IF NOT EXISTS alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    direccion VARCHAR(150)
);

-- Insertar algunos datos de ejemplo
INSERT INTO alumnos (nombres, apellidos, telefono, ciudad, direccion) VALUES
('Carlos', 'Mendoza Gomez', '987654321', 'Lima', 'Av. Larco 123 - Miraflores'),
('Maria', 'Flores Quispe', '912345678', 'Huancayo', 'Jr. Real 456 - El Tambo'),
('Juan', 'Rojas Silva', '945612378', 'Arequipa', 'Calle Melgar 789 - Cercado'),
('Ana', 'Perez Delgado', '933221144', 'Trujillo', 'Av. España 1011'),
('Luis', 'Torres Castro', '955667788', 'Cusco', 'Urb. Larapa G-5');
