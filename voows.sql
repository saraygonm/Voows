/*CODIGO SQL PROYECTO VOOWS*/

/*Tablas*/
CREATE TABLE Planes(
    idp NUMBER(6) NOT NULL,
    estado VARCHAR2(5),
    fecha_inicio DATE,
    publicidad VARCHAR2(5)

);

CREATE TABLE Plus(
    idp_plan NUMBER(6) NOT NULL,
    cantidad_megustas NUMBER, /*infinito??*/
    fecha_de_fin DATE, 
    precio NUMBER(9),
    medio_pago VARCHAR2(1)
);

CREATE TABLE Free(
    idp_plan NUMBER(6) NOT NULL,
    cantidad_megustas NUMBER (30)
);

CREATE TABLE Publicidad(
    idpu NUMBER(6) NOT NULL,
    idp_plan NUMBER(6),
    nombre VARCHAR2(50),
    descripcion VARCHAR2(150)
);

CREATE TABLE Libro(
    id_usuario NUMBER(10) NOT NULL,
    ISBN NUMBER(10) NOT NULL,
    titulo VARCHAR2(50),
    autor VARCHAR2(30),
    sinopsis VARCHAR2(280),
    editorial VARCHAR2(30),
    comentario VARCHAR2(2000) NULL,
    fecha_impresion DATE,
    estado VARCHAR2(1)
);

CREATE TABLE Archivo(
    codigo NUMBER(6) NOT NULL,
    ISBN_libros NUMBER(10) NOT NULL,
    id_usuario NUMBER(10) NOT NULL,
    tipo VARCHAR2(3),
    URRL VARCHAR2(50)
);

CREATE TABLE Genero(  
    genero VARCHAR2(2)NOT NULL,
    ISBN_libros NUMBER(10),
    id_usuario NUMBER(10)
);


CREATE TABLE Localizacion(
    id_localizacion NUMBER(6) NOT NULL,
    latitud NUMBER(10,8), 
    longitud NUMBER(10,8)
);

CREATE TABLE Evento(
    id_evento NUMBER(6) NOT NULL,
    id_grupo VARCHAR2(50),
    id_localizacion NUMBER(6) NULL,
    nombre VARCHAR2(100),
    proposito VARCHAR2(280),
    fecha_inicio DATE,
    fecha_finalizacion DATE, 
    asisten VARCHAR2(50) NULL,
    interesados VARCHAR2(50) NULL
);

CREATE TABLE Usuario(
    idu NUMBER(10) NOT NULL,
    id_free NUMBER(6) NULL,
    id_pluss NUMBER(6) NULL,
    id_localizacion NUMBER(6),
    organizador_grupo VARCHAR2(50) NULL, 
    correo VARCHAR2(50),
    contrasenia VARCHAR2(12),
    fecha_conexion DATE,
    nombre VARCHAR2(15),
    estado VARCHAR2(1)
);

CREATE TABLE Grupo(
    nombre VARCHAR2(50) NOT NULL,
    estado VARCHAR2(1),
    reglas VARCHAR2(1000),
    descripcion VARCHAR2(280),
    miembros VARCHAR2(50)
);

CREATE TABLE UsuarioXgrupo(
    nombre VARCHAR2(50) NOT NULL,
    id_usuario NUMBER(10) NOT NULL
    
);

CREATE TABLE Chat(
    id_chat NUMBER(10) NOT NULL,
    nombre_grupo VARCHAR2(50),
    apodo VARCHAR2(12)
);

CREATE TABLE Intercambio(
    id_inter NUMBER(6) NOT NULL,
    id_chat NUMBER(10),
    libro_inter1 NUMBER(10),
    usuario1 NUMBER(10),
    libro_inter2 NUMBER(10),
    usuario2 NUMBER(10),
    fechaCreacion DATE,
    fechaEntrega DATE,
    calificacion NUMBER(1),
    estado VARCHAR2(1)
);

CREATE TABLE Notificacion(
    codigo_noti NUMBER(6),
    id_inter NUMBER(6),
    estado VARCHAR2(20),
    descripcion VARCHAR2(50) NULL,
    fecha DATE
);

/*xTablas*/
DROP TABLE Archivo;
DROP TABLE Evento;
DROP TABLE UsuarioXgrupo;
DROP TABLE Notificacion;
DROP TABLE Intercambio;
DROP TABLE Chat;
DROP TABLE Planes;
DROP TAblE Free;
DROP TABLE Grupo;
DROP TABLE Libro;
DROP TABLE Localizacion;
DROP TABLE Genero;
DROP TABLE Usuario;
DROP TABLE Publicidad;
DROP TABLE Plus;


/*Los usuarios en la tabla de intercambios deben ser diferentes*/


/*Atributos*/
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_idp CHECK(idp >=0);
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_Booleano CHECK(estado = 'True' OR estado = 'False');
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_Booleano2 CHECK(publicidad = 'True' OR publicidad = 'False');

ALTER TABLE Plus ADD CONSTRAINT CK_Plus_precio CHECK(precio = '15000' OR precio = '25000' OR precio = '150000');
ALTER TABLE Plus ADD CONSTRAINT CK_Plus_medioPago CHECK(medio_pago = 'C' OR medio_pago = 'D' OR medio_pago = 'T');

ALTER TABLE Libro ADD CONSTRAINT CK_Libro_ISBN CHECK (ISBN >=0);
ALTER TABLE Libro ADD CONSTRAINT CK_Libro_estado CHECK (estado = 'A' OR estado = 'C' );

ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_codigo CHECK (codigo >= 0); /*consecutivo?*/
ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_tipo CHECK (tipo = '%jpg' OR tipo ='%gif' OR tipo='%bmp' OR tipo = '%png');
ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_TURL CHECK(URRL like 'https://%' and URRL like '%pdf');

ALTER TABLE Genero ADD CONSTRAINT CK_Genero_genero CHECK(
    genero = 'Comedy' OR
    genero = 'Drama' OR
    genero = 'Children' OR
    genero = 'Animation' OR
    genero = 'Mystery' OR
    genero = 'Fantasy' OR
    genero = 'Sci-Fi' OR
    genero = 'Action' OR
    genero = 'Horror' OR
    genero = 'Documentary' OR
    genero = 'Crime' OR
    genero = 'Thriller' OR
    genero = 'Musical' OR
    genero = 'Romance' OR
    genero = 'Western' OR
    genero = 'War'
);

ALTER TABLE Localizacion ADD CONSTRAINT CK_Localizacion_id CHECK(id_localizacion >= 0);

ALTER TABLE Evento ADD CONSTRAINT CK_Evento_id CHECK( id_evento >= 1000000);

ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_id CHECK (idu >= 0); /*consecutivo?*/
ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_correo CHECK (INSTR(correo, '@') > 0 AND INSTR(correo, '.') > 0);
ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_estado CHECK(estado = 'A' OR estado = 'C');
ALTER TABLE Usuario
ADD CONSTRAINT check_contrasena
CHECK (
    contrasenia LIKE '%[A-Z]%'
    AND contrasenia LIKE '%[a-z]%'
    AND contrasenia LIKE '%[0-9]%'
    AND contrasenia LIKE '%[!@#$%^&*()]%'
    AND contrasenia NOT LIKE '% %'
);


ALTER TABLE Grupo ADD CONSTRAINT CK_Grupo_estado CHECK (estado = 'A' OR estado = 'C');

ALTER TABLE Chat ADD CONSTRAINT CK_Chat_id CHECK (id_chat >= 1000);

ALTER TABLE Intercambio ADD CONSTRAINT CK_Intercambio_id CHECK (id_inter >= 0 );
ALTER TABLE Intercambio ADD CONSTRAINT CK_Intercambio_calificacion CHECK(calificacion >=0 AND calificacion <=5);
ALTER TABLE Intercambio ADD CONSTRAINT CK_Intercambio_estado CHECK(estado = 'A' OR estado = 'C');

ALTER TABLE Notificacion ADD CONSTRAINT CK_Notificacion_codigo CHECK (codigo_noti >=0); /*consecutivo?*/
ALTER TABLE Notificacion ADD CONSTRAINT CK_Notificacion_estado CHECK (estado = 'Solicitado' OR estado = 'En proceso' OR estado ='Entregado' OR estado = 'Cancelado' OR estado= 'Oculto');

/*Primarias*/
ALTER TABLE Planes ADD CONSTRAINT PK_Planes PRIMARY KEY (idp);
ALTER TABLE Plus ADD CONSTRAINT PK_Plus  PRIMARY KEY (idp_plan);
ALTER TABLE Free ADD CONSTRAINT PK_Free PRIMARY KEY (idp_plan);
ALTER TABLE Publicidad ADD CONSTRAINT PK_Publicidad PRIMARY KEY (idpu);
ALTER TABLE Libro ADD CONSTRAINT PK_Libro PRIMARY KEY (id_usuario, ISBN);
ALTER TABLE Archivo ADD CONSTRAINT PK_Archivo PRIMARY KEY (codigo,id_usuario, ISBN_libros);
ALTER TABLE Genero ADD CONSTRAINT PK_Genero  PRIMARY KEY (genero,ISBN_libros,id_usuario);
ALTER TABLE Localizacion ADD CONSTRAINT PK_Localizacion PRIMARY KEY (id_localizacion);
ALTER TABLE Evento ADD CONSTRAINT PK_Evento PRIMARY KEY (id_evento);
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (idu);
ALTER TABLE Grupo ADD CONSTRAINT PK_Grupo  PRIMARY KEY (nombre);
ALTER TABLE UsuarioXgrupo ADD CONSTRAINT PK_UsuarioXgrupo PRIMARY KEY (nombre,id_usuario);
ALTER TABLE Chat ADD CONSTRAINT PK_Chat PRIMARY KEY (id_chat);
ALTER TABLE Intercambio ADD CONSTRAINT PK_Intercambio PRIMARY KEY (id_inter);
ALTER TABLE Notificacion ADD CONSTRAINT PK_Notificacion PRIMARY KEY (codigo_noti);

/*Unicas*/
ALTER TABLE Usuario ADD CONSTRAINT UK_Usuario_correo UNIQUE (correo);


/*Foraneas*/

ALTER TABLE Plus ADD CONSTRAINT FK_Plus FOREIGN KEY (idp_plan) REFERENCES Planes(idp);

ALTER TABLE Free ADD CONSTRAINT FK_Free FOREIGN KEY (idp_plan) REFERENCES Planes(idp);

ALTER TABLE Publicidad ADD CONSTRAINT FK_Publicidad FOREIGN KEY (idp_plan) REFERENCES Free(idp_plan);

ALTER TABLE Libro ADD CONSTRAINT FK_Libro FOREIGN KEY (id_usuario) REFERENCES Usuario(idu);

ALTER TABLE Archivo ADD CONSTRAINT FK_Archivo FOREIGN KEY (id_usuario, ISBN_libros) REFERENCES Libro(id_usuario, ISBN);

ALTER TABLE Genero ADD CONSTRAINT FK_Genero  FOREIGN KEY (ISBN_libros,id_usuario) REFERENCES Libro(ISBN, id_usuario);

ALTER TABLE Evento ADD CONSTRAINT FK_Evento_grupo FOREIGN KEY (id_grupo) REFERENCES Grupo(nombre);
ALTER TABLE Evento ADD CONSTRAINT FK_Evento_localizacion FOREIGN KEY (id_localizacion) REFERENCES Localizacion(id_localizacion);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario FOREIGN KEY (id_free) REFERENCES Free(idp_plan);
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_pluss FOREIGN KEY (id_pluss) REFERENCES Plus(idp_plan);
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_localizacion FOREIGN KEY (id_localizacion) REFERENCES Localizacion(id_localizacion);
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_grupo FOREIGN KEY (organizador_grupo) REFERENCES Grupo(nombre);

ALTER TABLE UsuarioXgrupo ADD CONSTRAINT FK_UsuarioXgrupo_nombre FOREIGN KEY (nombre) REFERENCES Grupo (nombre);
ALTER TABLE UsuarioXgrupo ADD CONSTRAINT FK_UsuarioXgrupo_idu FOREIGN KEY (id_usuario) REFERENCES Usuario(idu);

ALTER TABLE Chat ADD CONSTRAINT FK_Chat FOREIGN KEY (nombre_grupo) REFERENCES Grupo(nombre);

ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_chat FOREIGN KEY (id_chat) REFERENCES Chat(id_chat);
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN1 FOREIGN KEY (libro_inter1,usuario1) REFERENCES Libro(ISBN, id_usuario);
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN2 FOREIGN KEY (libro_inter2, usuario2) REFERENCES Libro(ISBN, id_usuario);

ALTER TABLE Notificacion ADD CONSTRAINT FK_Notificacion FOREIGN KEY (id_inter) REFERENCES Intercambio(id_inter);

/*ELIMINAR TODOS LOS TRIGGER*/
SELECT 'DROP TRIGGER ' || trigger_name || ';' 
FROM user_triggers;

/*Mantener notificaciones*/

/*Ad*/
/* el estado inicial de una notificacion es oculto*/
CREATE OR REPLACE TRIGGER TR_Notificacion_Estado_inicial
BEFORE INSERT ON Notificacion
FOR EACH ROW
BEGIN
    If :NEW.estado = null AND :NEW.fecha = null THEN
        :NEW.estado := 'Solicitado';
        :NEW.fecha := SYSDATE;
    END IF;
END; 
/

/*Mo*/
/*El estado se puede modificar de "Solicitado" a  "Cancelado" y de "En proceso" a "Entregado".*/
CREATE OR REPLACE TRIGGER TR_Notificacion_ModEstado
BEFORE UPDATE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado = 'Solicitado' AND :NEW.estado != 'Cancelado' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar');
    END IF;
    IF :OLD.estado = 'En proceso' AND :NEW.estado != 'Entregado' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar');
    END IF;
END;
/
/*El estado puede pasar a "Oculto" una vez el estado este en "Cancelado" o "Entregado"*/
CREATE OR REPLACE TRIGGER TR_Notificacion_ModEstadoAOculto
BEFORE UPDATE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado = 'Cancelado' OR :OLD.estado = 'Entregado' THEN
        IF :NEW.estado != 'Oculto' THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar');
        END IF;
    END IF;
END;
/

/*EL*/
/*Solo se puede eliminar las notificaciones en "Oculto"*/
CREATE OR REPLACE TRIGGER TR_Notificacion_Eliminar
BEFORE DELETE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'Oculto' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar una notificacion que no este en oculto');
    END IF;
END;
/

/*Mantener libros*/

/*Ad*/

/*los libros  deben tener todos los datos, el comentario es opcional.*/
CREATE OR REPLACE TRIGGER TR_Libro_inicial
BEFORE INSERT ON Libro
FOR EACH ROW
BEGIN
    If :NEW.titulo = null AND :NEW.autor = null AND :NEW.sinopsis = null AND :NEW.editorial = null AND :NEW.fecha_impresion = null THEN
        RAISE_APPLICATION_ERROR(-20002, 'Faltan datos obligatorios');
    END IF;
END; 
/
/*el estado de un libro se genera en abierto y el numero es automatizado*/
CREATE SEQUENCE secuencia_libro
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/

CREATE OR REPLACE TRIGGER TR_Libro_inicial_estado
BEFORE INSERT ON Libro
FOR EACH ROW
BEGIN
    If :NEW.estado = null AND :NEW.estado = null THEN
        :NEW.estado := secuencia_libro.NEXTVAL;
        :NEW.estado := 'A';
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'El estado inicial debe ser abierto');
    END IF;
END;
/
/*Mo*/

/*El estado se puede modificar de abierto 
a cerrado si el libro esta en un proceso de intercambio.*/
CREATE OR REPLACE TRIGGER TR_Libro_ModificarEstado
BEFORE UPDATE ON Libro
FOR EACH ROW
BEGIN 
    IF :OLD.estado = 'A' AND :NEW.estado != 'C' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado abierto');
    ELSIF :OLD.estado = 'C' AND :NEW.estado != 'C' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado oculto');
    END IF;
END;
/
/*Solo se pueden eliminar libros con un proceso cerrado y entregado.*/



/*Mantener intercambios*/

/*Ad*/

/*los Libros solicitados deben estar disponibles*/
CREATE OR REPLACE TRIGGER TR_Libro_dip
BEFORE INSERT ON Intercambio
FOR EACH ROW
DECLARE
    disp VARCHAR2(10);   
BEGIN 
    SELECT estado INTO disp FROM Libro WHERE ISBN = :NEW.libro_inter1 AND estado = 'A';
    IF disp != 'true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE');
    END IF;
    SELECT estado INTO disp FROM Libro WHERE ISBN = :NEW.libro_inter2 AND estado = 'A';
    IF disp != 'true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE');
    END IF;
END;
/
/*Mo*/

/* Sólo se pueden modificar todos los datos de intercambio si la notificacion está en estado oculta*/
CREATE OR REPLACE TRIGGER TR_ModificarEstadoOculta
BEFORE UPDATE ON Intercambio
FOR EACH ROW
DECLARE
    estado_actual CHAR(1);
BEGIN
    SELECT estado INTO estado_actual FROM Notificacion WHERE :OLD.numero = :NEW.numero;
    IF estado_actual != 'O' AND :NEW.estado != 'A'THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede modificar si el estado es oculto');
    END IF;
END IF;
/
/*El*/
   /*-Solo se puede eliminar los intercambios con notificaciones ocultos*/

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_chat;
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_chat FOREIGN KEY (id_chat) 
REFERENCES Chat(id_chat)ON DELETE CASCADE;

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_ISBN1;
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN1 FOREIGN KEY (libro_inter1, usuario1) 
REFERENCES Libro(ISBN, id_usuario) ON DELETE CASCADE;

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_ISBN2;
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_idu FOREIGN KEY (libro_inter2, usuario2) 
REFERENCES Libro(ISBN, id_usuario)ON DELETE CASCADE;


create or replace TRIGGER TR_Eliminar_inter
BEFORE DELETE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'O' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta en estado oculto');
    END IF;
END;
/

/*VISTAS*/
--Vista de usuarios con planes Plus
CREATE VIEW usuarios_plus AS
SELECT u.idu, u.nombre, p.idp, p.estado, p.fecha_inicio, pl.cantidad_megustas, pl.fecha_de_fin, pl.precio, pl.medio_pago
FROM Usuario u
INNER JOIN Planes p ON u.id_pluss = p.idp
INNER JOIN Plus pl ON p.idp = pl.idp_plan;

--Vista de usuarios con planes Free
CREATE VIEW usuarios_free AS
SELECT u.idu, u.nombre, p.idp, p.estado, p.fecha_inicio, f.cantidad_megustas
FROM Usuario u
INNER JOIN Planes p ON u.id_free = p.idp
INNER JOIN Free f ON p.idp = f.idp_plan;

--Vista de libros con su localizacion
CREATE VIEW libros_localizacion AS
SELECT l.ISBN, l.titulo, l.autor, l.sinopsis, l.editorial, loc.id_localizacion, loc.latitud, loc.longitud
FROM Libro l
LEFT JOIN Localizacion loc ON l.id_usuario = loc.id_localizacion;

--Vistas de eventos con su localizacion
CREATE VIEW eventos_localizacion AS
SELECT e.id_evento, e.id_grupo, e.nombre, e.proposito, e.fecha_inicio, e.fecha_finalizacion, loc.id_localizacion, loc.latitud, loc.longitud
FROM Evento e
LEFT JOIN Localizacion loc ON e.id_localizacion = loc.id_localizacion;


--Vista de intercambios de libros con informacion de los usuarios
CREATE VIEW intercambios_usuarios AS
SELECT i.id_inter, i.id_chat, i.libro_inter1, u1.nombre AS nombre_usuario1, i.libro_inter2, u2.nombre AS nombre_usuario2, i.fechaCreacion, i.fechaEntrega, i.calificacion, i.estado
FROM Intercambio i
INNER JOIN Usuario u1 ON i.usuario1 = u1.idu
INNER JOIN Usuario u2 ON i.usuario2 = u2.idu;


--Vista de eventos activos
CREATE VIEW eventos_activos AS
SELECT id_evento, nombre, fecha_inicio, fecha_finalizacion
FROM Evento
WHERE fecha_finalizacion >= SYSDATE;

--Vista de intercambios pendientes
CREATE VIEW intercambios_pendientes AS
SELECT id_inter, id_chat, usuario1, usuario2, fechaCreacion, fechaEntrega
FROM Intercambio
WHERE estado = 'Pendiente';

--Vista que muestra los libros disponibles para intercambio en un evento
CREATE VIEW libros_disponibles AS
SELECT l.ISBN, l.titulo, l.autor, l.sinopsis, l.editorial, e.nombre as evento
FROM Libro l
INNER JOIN Intercambio i ON l.id_usuario = i.usuario1
INNER JOIN Evento e ON i.id_chat = e.id_chat
WHERE l.estado = 'disponible' AND i.estado = 'activo'


/*XIndicesVistas*/
DROP VIEW usuarios_plus;
DROP VIEW usuarios_free;
DROP VIEW libros_localizacion;
DROP VIEW eventos_localizacion;
DROP VIEW intercambios_usuarios;
DROP VIEW eventos_activos;
DROP VIEW intercambios_pendientes;
DROP VIEW libros_disponibles;






