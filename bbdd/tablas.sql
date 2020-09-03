--
-- Creacion de la BBDD
--
DROP DATABASE IF EXISTS notasfast;
CREATE DATABASE notasfast;
GRANT ALL ON DATABASE notasfast TO dit;

--
-- Conexión con la BBDD
--
\c notasfast;

--
-- Estructura de tabla para la tabla `usuarios`
--
DROP TABLE IF EXISTS usuarios CASCADE;
CREATE TABLE IF NOT EXISTS usuarios (
  nombre VARCHAR( 20 ) NOT NULL PRIMARY KEY,
  clave VARCHAR( 100 ) NOT NULL,
  tipo_usu integer NOT NULL,
  urlimagen TEXT NOT NULL,
  rol integer NOT NULL,
  fecha_hora TIMESTAMP NOT NULL
);

--
-- Estructura de tabla para la tabla `notas`
--
DROP TABLE IF EXISTS notas;
CREATE TABLE IF NOT EXISTS notas (
  id SERIAL NOT NULL,
  nombre_usuario VARCHAR(20) NOT NULL,
  titulo VARCHAR(100) NOT NULL,
  nota TEXT,
  urlimagen TEXT,
  categoria TEXT, --t1
  color VARCHAR(7), --t1
  PRIMARY KEY (id),
  FOREIGN KEY (nombre_usuario) REFERENCES usuarios (nombre) ON DELETE CASCADE ON UPDATE CASCADE
) ;

--
-- Insercion de datos de ejemplo
--
INSERT INTO usuarios VALUES('usuario','clave',1,'imagenes/imagen1.png',1, '2020-09-01 06:44:22');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('usuario','Nota de prueba 1','Esta es la nota 1','../imagenes/nota.png', 'trabajo', '#FFFFFF');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('usuario','Nota de prueba 2','Esta es la nota 2','../imagenes/nota2.png', 'ocio', '#CE2CAE');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('usuario','Nota de prueba 3','Esta es la nota 3','../imagenes/nota2.png', 'trabajo', '#CFAEEA');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('usuario','Nota de prueba 4','Esta es la nota 4','../imagenes/nota2.png', 'universidad', 'blue');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen) VALUES('usuario','Nota de prueba 5','Esta es la nota 5','../imagenes/nota2.png');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('usuario','Nota de prueba 1','Esta es la nota 1','../imagenes/nota.png', 'trabajo', '#FFFFFF');

INSERT INTO usuarios VALUES('admin','clave',0,'imagenes/imagen0.png',0, '2020-09-01 11:44:22');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('admin','Nota de prueba 4','Esta es la nota 6','../imagenes/nota2.png', 'ocio', 'red');
INSERT INTO notas (nombre_usuario, titulo, nota, urlimagen, categoria, color) VALUES('admin','Nota Nueva','Esta es la nota 6','../imagenes/nota2.png', 'ocio', 'pink');

