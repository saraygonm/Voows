/*CODIGO SQL PROYECTO VOOWS*/

/*Tablas*/
CREATE TABLE Planes(
    idp NUMBER(6) NOT NULL,
    estado VARCHAR2(5),
    fecha_inicio DATE
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
    miembros VARCHAR2(50),
    organizador_grupo VARCHAR2(50) NOT NULL 
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
    libro_inter1 NUMBER(10) NOT NULL,
    usuario1 NUMBER(10) NOT NULL,
    libro_inter2 NUMBER(10) NOT NULL,
    usuario2 NUMBER(10) NOT NULL,
    fechaCreacion DATE,
    fechaEntrega DATE NULL,
    calificacion NUMBER(1) NULL,
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
CREATE SEQUENCE secuencia_noti
  START WITH 100
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;

CREATE OR REPLACE TRIGGER TR_Notificacion_Estado_inicial
BEFORE INSERT ON Notificacion
FOR EACH ROW
DECLARE
  estadoDeNoti VARCHAR2(20);
BEGIN
    SELECT estado INTO estadoDeNoti FROM intercambio WHERE id_inter = :NEW.id_inter;
    If :NEW.estado = null OR :NEW.fecha = null OR :NEW.fecha=null THEN
        :NEW.estado := estadoDeNoti;
        :NEW.fecha := SYSDATE;
        :NEW.codigo_noti:=secuencia_noti.NEXTVAL;
    END IF;
END; 
/

/*EL*/
/*Solo se puede eliminar las notificaciones en "Oculto"*/
ALTER TABLE Notificacion DROP CONSTRAINT FK_Notificacion;
ALTER TABLE Notificacion ADD CONSTRAINT FK_Notificacion FOREIGN KEY (id_inter) REFERENCES Intercambio(id_inter) ON DELETE CASCADE;

/*Mantener libros*/

/*Ad*/

/*los libros  deben tener todos los datos, el comentario es opcional.*/
CREATE OR REPLACE TRIGGER TR_Libro_inicial
BEFORE INSERT ON Libro
FOR EACH ROW
BEGIN
    If :NEW.autor = null OR :NEW.sinopsis = null OR :NEW.editorial = null OR :NEW.fecha_impresion = null THEN
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
    If :NEW.estado = null THEN
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
DECLARE
    estadoLibro VARCHAR2(20);
BEGIN 
    SELECT estado INTO estadoLibro FROM Intercambio WHERE libro_inter1 LIKE :OLD.ISBN OR libro_inter2 LIKE :OLD.ISBN;
    IF :OLD.estado = 'A' AND :NEW.estado = 'C'  THEN
        IF estadoLibro!='Solicitado' OR estadoLibro!='En proceso' THEN
            RAISE_APPLICATION_ERROR(-20003,'Solo se pasar a cerrado si esta en un proceso de intercambio');
        END IF;
    END IF;
    IF :OLD.estado = 'C' AND :NEW.estado = 'A'  THEN
        IF estadoLibro!='Cancelado' THEN
            RAISE_APPLICATION_ERROR(-20003,'El libro esta en un proceso');
        END IF;
    END IF;
END;
/

/*Solo se pueden eliminar libros que nunca tuvieron un proceso de intercambio*/
CREATE OR REPLACE TRIGGER TR_Libro_Eliminar_Libro
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    idIntercambio VARCHAR2(20);
BEGIN
  SELECT id_inter INTO idIntercambio FROM Intercambio WHERE libro_inter1 LIKE :OLD.ISBN OR libro_inter2 LIKE :OLD.ISBN;
  IF idIntercambio != null THEN
    RAISE_APPLICATION_ERROR(-20003,'Solo se puede eliminar libros que nunca tuvieron algun proceso de intercambio');
  END IF;
END;
/

/*Mantener intercambios*/

/*Ad*/
CREATE SEQUENCE secuencia_intercambio
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/

/*los usuarios deben ser diferentes*/
CREATE OR REPLACE TRIGGER TR_Intercambio_Usuario_dif
BEFORE INSERT ON Intercambio
FOR EACH ROW
BEGIN
  IF :NEW.usuario1 LIKE :NEW.usuario2 THEN
    RAISE_APPLICATION_ERROR(-20003,'Son los mismos usuarios');
  END IF;
END;
/

/*los Libros solicitados deben estar disponibles y deben pertenecer a un usuario*/
CREATE OR REPLACE TRIGGER TR_Intercambio_Libro_Disponible
BEFORE INSERT ON Intercambio
FOR EACH ROW
DECLARE
    disp1 VARCHAR2(10);
    disp2 VARCHAR(10);   
BEGIN 
    SELECT estado INTO disp1 FROM Libro WHERE ISBN = :NEW.libro_inter1 AND estado = 'A' AND id_usuario = :NEW.usuario1;
    SELECT estado INTO disp2 FROM Libro WHERE ISBN = :NEW.libro_inter2 AND estado = 'A'AND id_usuario = :NEW.usuario2;
    IF disp1 != 'true' OR disp2!='true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE');
    END IF;
END;
/

/*El id del intercambio se genera automaticamente y el numero de calificacion es null.*/
CREATE OR REPLACE TRIGGER TR_Intercambio_Insert
BEFORE INSERT ON Intercambio
FOR EACH ROW
BEGIN
  IF :NEW.calificacion != null THEN
    RAISE_APPLICATION_ERROR(-20003,'Califiacion no debe tener valor');
  END IF;
  IF :NEW.fechaEntrega!=null THEN
    RAISE_APPLICATION_ERROR(-20003,'Fecha de entrega no debe tener valor');
  END IF;
  IF :NEW.id_inter = null OR :NEW.estado = null OR :NEW.fechaCreacion = null THEN
    :new.id_inter := secuencia_intercambio.NEXTVAL;
    :new.estado := 'Solicitado';
    :new.fechaCreacion := SYSDATE();
  END IF;
END;
/

/*Mo*/

/*El estado se puede modificar de "Solicitado" a  "Cancelado" y de "En proceso" a "Entregado".
  -El estado puede pasar a "Oculto" una vez el estado este en "Cancelado" o "Entregado".*/
CREATE OR REPLACE TRIGGER TR_Intercambio_ModEstado
BEFORE UPDATE ON Intercambio
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
/*Sólo se pueden modificar la calificacion una vez el intercambio sea entregado junto con su fecha de entrega.*/
CREATE OR REPLACE TRIGGER TR_Intercambio_Calificacion
BEFORE UPDATE ON Intercambio
FOR EACH ROW
BEGIN
  IF :OLD.estado != 'Entregado' THEN
    RAISE_APPLICATION_ERROR(-20002, 'No se puede dar clifiacion o dar la fecha de entrega si el intercambio no esta entregado');
  END IF;
END;
/
/*El*/
/*-Solo se puede eliminar los intercambios con notificaciones ocultos*/
CREATE OR REPLACE TRIGGER TR_Intercambio_Eliminar
BEFORE DELETE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'Oculto' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar una notificacion que no este en oculto');
    END IF;
END;
/
/*Crear un cascade en por si eliminan libros*/

/*Mantener usuario*/

/*Ad/

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

/*CRUDE*/
--implementacion del paquete correspondiente al CRUD Intercambio
create or replace PACKAGE PC_Intercambio AS
PROCEDURE adicionar_Inter(in_libro_inter1 IN NUMBER, in_usuario1 IN NUMBER, in_libro_inter2 IN NUMBER, in_usuario2 IN NUMBER, in_calificacion IN NUMBER, in_estado IN VARCHAR);
PROCEDURE modificar_Inter(in_id_inter IN NUMBER, in_id_chat IN NUMBER,in_libro_inter1 IN NUMBER, in_usuario1 IN NUMBER, in_libro_inter2 IN NUMBER, in_usuario2 IN NUMBER, in_fechaCreacion IN DATE, in_fechaEntrega IN DATE, in_calificacion IN NUMBER, in_estado IN VARCHAR);
PROCEDURE eliminar_Inter(in_id_inter IN NUMBER,  in_id_chat IN NUMBER );
PROCEDURE consulta_Inter_Estado(in_estado IN VARCHAR);
END;
/

/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_Intercambio AS
--Procedimiento para adicionar un intercambio
  PROCEDURE adicionar_Inter(
    in_libro_inter1 IN NUMBER, 
    in_usuario1 IN NUMBER, 
    in_libro_inter2 IN NUMBER, 
    in_usuario2 IN NUMBER, 
    in_calificacion IN NUMBER, 
    in_estado IN VARCHAR
    ) IS
  BEGIN
    INSERT INTO Intercambio VALUES (5467892984,1267489874,1234568901,1235679873,4,in_estado);
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
  -- Procedimiento para modificar un intercambio
  PROCEDURE modificar_Inter(
    in_id_inter IN NUMBER,
    in_id_chat IN NUMBER,
    in_libro_inter1 IN NUMBER,
    in_usuario1 IN NUMBER,
    in_libro_inter2 IN NUMBER,
    in_usuario2 IN NUMBER,
    in_fechaCreacion IN DATE,
    in_fechaEntrega IN DATE,
    in_calificacion IN NUMBER,
    in_estado IN VARCHAR2
  ) IS
  BEGIN
    UPDATE Intercambio
    SET
      id_chat = in_id_chat,
      libro_inter1 = in_libro_inter1,
      usuario1 = in_usuario1,
      libro_inter2 = in_libro_inter2,
      usuario2 = in_usuario2,
      fechaCreacion = in_fechaCreacion,
      fechaEntrega = in_fechaEntrega,
      calificacion = in_calificacion,
      estado = in_estado
    WHERE id_inter = in_id_inter;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
--Procedimiento para eliminar un intercambio
  PROCEDURE eliminar_Combo(in_id_inter IN NUMBER,  in_id_chat IN NUMBER ) IS
  BEGIN
    DELETE FROM Intercambio WHERE id_inter = in_id_inter AND id_chat = in_id_chat;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo eliminar la tupla porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

--Procedimiento para consultar un intercambio
  PROCEDURE consulta_Inter_Estado(in_estado IN VARCHAR) IS
  suma NUMBER;
BEGIN
  SELECT COUNT(*) INTO suma FROM Intercambio WHERE estado = in_estado;
  DBMS_OUTPUT.PUT_LINE('Cantidad de filas: ' || suma);
END;

END PC_Intercambio;
/

---------------------------------------------------------------------------------------------------------------------------------------

/*CRUDE*/
--implementacion del paquete correspondiente al CRUD Libros
create or replace PACKAGE PC_Libro AS

PROCEDURE adicionar_Libro(li_titulo IN VARCHAR, li_autor IN VARCHAR, li_sinopsis IN VARCHAR, li_editorial IN VARCHAR, li_comentario IN VARCHAR, li_fecha_impresion IN DATE, li_estado IN VARCHAR);
PROCEDURE modificar_Libro(li_id_usuario IN NUMBER, li_ISBN IN NUMBER, li_titulo IN VARCHAR, li_autor IN VARCHAR, li_sinopsis IN VARCHAR, li_editorial IN VARCHAR, li_comentario IN VARCHAR, li_fecha_impresion IN DATE, li_estado IN VARCHAR);
PROCEDURE eliminar_Libro(li_id_usuario IN NUMBER, li_ISBN IN NUMBER);
PROCEDURE consulta_Libro_Estado(li_estado IN VARCHAR);
END;
/

/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_Libro AS
--Procedimiento para adicionar un Libro
PROCEDURE adicionar_Libro(
    li_titulo IN VARCHAR,
    li_autor  IN VARCHAR, 
    li_sinopsis IN VARCHAR, 
    li_editorial IN VARCHAR, 
    li_comentario IN VARCHAR, 
    li_fecha_impresion IN DATE, 
    li_estado IN VARCHAR
    ) IS
  BEGIN
    INSERT INTO Libro VALUES (li_titulo,li_autor,li_sinopsis,li_editorial,li_comentario,li_fecha_impresion,li_estado);
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;
  
  -- Procedimiento para modificar un Libro
  PROCEDURE modificar_Libro(
    li_id_usuario IN NUMBER, 
    li_ISBN IN NUMBER, 
    li_titulo IN VARCHAR, 
    li_autor IN VARCHAR, 
    li_sinopsis IN VARCHAR, 
    li_editorial IN VARCHAR, 
    li_comentario IN VARCHAR, 
    li_fecha_impresion IN DATE, 
    li_estado IN VARCHAR
  ) IS
  BEGIN
    UPDATE Libro
    SET 
      titulo = li_titulo,
      autor = li_autor,
      sinopsis = li_sinopsis,
      editorial = li_editorial,
      comentario = li_comentario,
      fecha_impresion = li_fecha_impresion,
      estado = li_estado
    WHERE id_usuario = li_id_usuario AND ISBN = li_ISBN;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

--Procedimiento para eliminar un Libro
  PROCEDURE eliminar_Libro(li_id_usuario IN NUMBER, li_ISBN IN NUMBER) IS
  BEGIN
    DELETE FROM Libro WHERE id_usuario = li_id_usuario AND ISBN = li_ISBN ;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo eliminar la tupla porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

--Procedimiento para consultar un  Libro
  PROCEDURE consulta_libro_Estado(in_estado IN VARCHAR) IS
  suma NUMBER;
BEGIN
  SELECT COUNT(*) INTO suma FROM Libro WHERE estado = li_estado;
  DBMS_OUTPUT.PUT_LINE('Cantidad de filas: ' || suma);
END;

END PC_Libro;
/

---------------------------------------------------------------------------------------------------------------------------------------

/*CRUDE*/
--implementacion del paquete correspondiente al CRUD Eventos
create or replace PACKAGE PC_Evento AS
PROCEDURE adicionar_Evento(ev_id_grupo IN VARCHAR,ev_id_localizacion IN NUMBER, ev_nombre IN VARCHAR, ev_proposito IN VARCHAR, ev_fecha_inicio IN DATE, ev_fecha_finalizacion IN DATE, ev_asisten IN VARCHAR, ev_interesados IN VARCHAR);
PROCEDURE modificar_Evento(ev_id_evento IN NUMBER, ev_id_grupo IN VARCHAR,ev_id_localizacion IN NUMBER, ev_nombre IN VARCHAR, ev_proposito IN VARCHAR, ev_fecha_inicio IN DATE, ev_fecha_finalizacion IN DATE, ev_asisten IN VARCHAR, ev_interesados IN VARCHAR);
PROCEDURE eliminar_Evento(ev_id_evento IN NUMBER);
PROCEDURE consulta_Evento_Nombre(ev_nombre IN VARCHAR);
END;
/

/*CRUDI*/
CREATE OR REPLACE PACKAGE BODY PC_Usuario AS
--Procedimiento para adicionar un Evento
PROCEDURE adicionar_Evento(
    ev_id_grupo IN VARCHAR,
    ev_id_localizacion IN NUMBER, 
    ev_nombre IN VARCHAR, 
    ev_proposito IN VARCHAR, 
    ev_fecha_inicio IN DATE, 
    ev_fecha_finalizacion IN DATE, 
    ev_asisten IN VARCHAR, 
    ev_interesados IN VARCHAR
    ) IS
  BEGIN
    INSERT INTO Evento VALUES (ev_id_grupo,234567,ev_nombre,ev_proposito,ev_fecha_inicio,ev_fecha_finalizacion,ev_asisten, ev_interesados);
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

-- Procedimiento para modificar un evento
  PROCEDURE modificar_Evento(
    ev_id_evento IN NUMBER, 
    ev_id_grupo IN VARCHAR,
    ev_id_localizacion IN NUMBER, 
    ev_nombre IN VARCHAR, 
    ev_proposito IN VARCHAR, 
    ev_fecha_inicio IN DATE, 
    ev_fecha_finalizacion IN DATE, 
    ev_asisten IN VARCHAR, 
    ev_interesados IN VARCHAR
    ) IS
  BEGIN
    UPDATE Evento
    SET 
      id_grupo = ev_id_grupo,
      id_localizacion = ev_id_localizacion,
      nombre = ev_nombre,
      proposito = ev_proposito,
      fecha_inicio = ev_fecha_inicio,
      fecha_finalizacion = ev_fecha_finalizacion,
      asisten = ev_asisten,
      interesados = ev_interesados
      estado = us_estado
    WHERE id_evento = ev_id_evento;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;  

--Procedimiento para consultar un Evento
  PROCEDURE consulta_Evento_Nombre(ev_nombre IN VARCHAR) IS
  suma NUMBER;
BEGIN
  SELECT COUNT(*) INTO suma FROM Evento WHERE nombre = ev_nombre;
  DBMS_OUTPUT.PUT_LINE('Cantidad de filas: ' || suma);
END;

END PC_Evento;
/   

/*XCRUD*/
DROP PACKAGE PC_Intercambio;
DROP PACKAGE PC_Libro;
DROP PACKAGE PC_Usuario;
DROP PACKAGE PC_Evento;

/*Falta CRUD OK y CRUDNoOK*/

/*ActoresE*/
--CREATE ROLE PA_GERENTE;
CREATE ROLE PA_JUNTAA;
--CREATE ROLE PA_ORGANIZADOR;
--CREATE ROLE PA_SERVIDOR;
CREATE ROLE PA_USUARIOO;


/*ActoresI*/
/
CREATE OR REPLACE PACKAGE PC_USUARIO AS
    PROCEDURE adicionar_Usuario(us_id_free IN NUMBER, us_pluss IN NUMBER,us_localizacion IN NUMBER, us_organizador_grupo IN VARCHAR,  us_correo IN VARCHAR, us_contrasenia IN VARCHAR, us_fecha_conexion IN DATE, us_nombre IN VARCHAR, us_estado IN VARCHAR);
END PC_USUARIO;
/
CREATE OR REPLACE PACKAGE PC_USUARIO_JUNTA AS
    PROCEDURE adicionar_Usuario(us_id_free IN NUMBER, us_pluss IN NUMBER,us_localizacion IN NUMBER, us_organizador_grupo IN VARCHAR,  us_correo IN VARCHAR, us_contrasenia IN VARCHAR, us_fecha_conexion IN DATE, us_nombre IN VARCHAR, us_estado IN VARCHAR);
    PROCEDURE modificar_Usuario(us_idu IN NUMBER, us_id_free IN NUMBER, us_pluss IN NUMBER, us_localizacion IN NUMBER, us_organizador_grupo IN VARCHAR,  us_correo IN VARCHAR, us_contrasenia IN VARCHAR, us_fecha_conexion IN DATE, us_nombre IN VARCHAR, us_estado IN VARCHAR);
    PROCEDURE eliminar_Usuario(us_idu IN NUMBER);
/

--Procedimiento para adicionar un usuario
PROCEDURE adicionar_Usuario(
    us_id_free IN NUMBER, 
    us_pluss IN NUMBER,
    us_localizacion IN NUMBER, 
    us_organizador_grupo IN VARCHAR,  
    us_correo IN VARCHAR, 
    us_contrasenia IN VARCHAR, 
    us_fecha_conexion IN DATE, 
    us_nombre IN VARCHAR, 
    us_estado IN VARCHAR
    ) IS
  BEGIN
    INSERT INTO Usuario VALUES (123456,23456,456789,us_organizador_grupo, us_correo, us_contrasenia, us_fecha_conexion, us_nombre, us_estado);
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

-- Procedimiento para modificar un Usuario
  PROCEDURE modificar_Usuario(
    us_idu IN NUMBER,
    us_id_free IN NUMBER, 
    us_pluss IN NUMBER, 
    us_localizacion IN NUMBER, 
    us_organizador_grupo IN VARCHAR,  
    us_correo IN VARCHAR, 
    us_contrasenia IN VARCHAR, 
    us_fecha_conexion IN DATE, 
    us_nombre IN VARCHAR, 
    us_estado IN VARCHAR
   
  ) IS
  BEGIN
    UPDATE Usuario
    SET 
      id_free = us_id_free,
      id_pluss = us_pluss,
      id_localizacion = us_localizacion,
      organizador_grupo = us_organizador_grupo,
      correo = us_correo,
      contrasenia = us_contrasenia,
      fecha_conexion = us_fecha_conexion,
      nombre = us_nombre,
      estado = us_estado
    WHERE idu = us_idu;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo modificar la tupla, porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

--Procedimiento para eliminar un usuario
  PROCEDURE eliminar_Usuario(us_idu IN NUMBER) IS
  BEGIN
    DELETE FROM Usuario WHERE idu = us_idu;
    IF(SQL%ROWCOUNT = 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'No se pudo eliminar la tupla porque no existe');
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
  END;

--Procedimiento para consultar un Usuario
  PROCEDURE consulta_usuario_Estado(in_estado IN VARCHAR) IS
  suma NUMBER;
BEGIN
  SELECT COUNT(*) INTO suma FROM Usuario WHERE estado = us_estado;
  DBMS_OUTPUT.PUT_LINE('Cantidad de filas: ' || suma);
END;

END PC_USUARIO_JUNTA;
/
CREATE OR REPLACE PACKAGE BODY PC_USUARIO AS
    PROCEDURE adicionar_Usuario(us_id_free IN NUMBER, us_pluss IN NUMBER,us_localizacion IN NUMBER, us_organizador_grupo IN VARCHAR,  us_correo IN VARCHAR, us_contrasenia IN VARCHAR, us_fecha_conexion IN DATE, us_nombre IN VARCHAR, us_estado IN VARCHAR);
        BEGIN
        INSERT INTO usuario VALUES(123456,23456,456789,us_organizador_grupo, us_correo, us_contrasenia, us_fecha_conexion, us_nombre, us_estado);
        IF(SQL%ROWCOUNT = 0) THEN
            RAISE_APPLICATION_ERROR(-20001,'No se pudo insetar la tupla');
        END IF;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20999,SQLERRM);
    END;
END PC_USUARIO;
/






