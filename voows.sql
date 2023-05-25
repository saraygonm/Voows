/*CODIGO SQL PROYECTO VOOWS*/

/*Tablas*/
CREATE TABLE Plan_(
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
    nombreUsuario VARCHAR2(16) NOT NULL,
    titulo VARCHAR2(50) NOT NULL,
    autor VARCHAR2(30),
    sinopsis VARCHAR2(280),
    editorial VARCHAR2(30),
    comentario VARCHAR2(2000) NULL,
    fecha_impresion DATE,
    estado VARCHAR2(1)
);

CREATE TABLE Archivo(
    codigo NUMBER(6) NOT NULL,
    titulo VARCHAR2(50) NOT NULL,
    nombreUsuario VARCHAR2(16) NOT NULL,
    tipo VARCHAR2(3),
    URRL VARCHAR2(50)
);

CREATE TABLE Genero(  
    genero VARCHAR2(12) NOT NULL,
    titulo VARCHAR2(50),
    nombreUsuario VARCHAR2(16)
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
    nombreUsuario VARCHAR2(16) NOT NULL,
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
    miembros NUMBER(10),
    organizador_grupo VARCHAR2(50) NOT NULL 
);

CREATE TABLE UsuarioXgrupo(
    nombre VARCHAR2(50) NOT NULL,
    nombreUsuario VARCHAR2(16) NOT NULL
);

CREATE TABLE Chat(
    id_chat NUMBER(10) NOT NULL,
    nombre_grupo VARCHAR2(50),
    apodo VARCHAR2(12),
    usuario1 VARCHAR2(16) NOT NULL,
    usuario2 VARCHAR2(16) NOT NULL
);

CREATE TABLE Intercambio(
    id_inter NUMBER(6) NOT NULL,
    id_chat NUMBER(10),
    libro_inter1 VARCHAR2(50) NOT NULL,
    libro_inter2 VARCHAR2(50) NOT NULL,
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
DROP TABLE Publicidad;
DROP TABLE Genero;
DROP TABLE Grupo;
DROP TABLE Libro;
DROP TABLE Usuario;
DROP TABLE Localizacion;
DROP TABLE Plus;
DROP TAblE Free;
DROP TABLE Plan_;


/*Los usuarios en la tabla de intercambios deben ser diferentes*/


/*Atributos*/
ALTER TABLE Plan_ ADD CONSTRAINT CK_Planes_idp CHECK(idp >=0);
ALTER TABLE Plan_ ADD CONSTRAINT CK_Planes_Booleano CHECK(estado = 'True' OR estado = 'False');

ALTER TABLE Plus ADD CONSTRAINT CK_Plus_precio CHECK(precio = '15000' OR precio = '25000' OR precio = '150000');
ALTER TABLE Plus ADD CONSTRAINT CK_Plus_medioPago CHECK(medio_pago = 'C' OR medio_pago = 'D' OR medio_pago = 'T');

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
ALTER TABLE Plan_ ADD CONSTRAINT PK_Planes PRIMARY KEY (idp);
ALTER TABLE Plus ADD CONSTRAINT PK_Plus  PRIMARY KEY (idp_plan);
ALTER TABLE Free ADD CONSTRAINT PK_Free PRIMARY KEY (idp_plan);
ALTER TABLE Publicidad ADD CONSTRAINT PK_Publicidad PRIMARY KEY (idpu);
ALTER TABLE Libro ADD CONSTRAINT PK_Libro PRIMARY KEY (nombreUsuario, titulo);
ALTER TABLE Archivo ADD CONSTRAINT PK_Archivo PRIMARY KEY (codigo,nombreUsuario, titulo);
ALTER TABLE Genero ADD CONSTRAINT PK_Genero  PRIMARY KEY (genero,titulo,nombreUsuario);
ALTER TABLE Localizacion ADD CONSTRAINT PK_Localizacion PRIMARY KEY (id_localizacion);
ALTER TABLE Evento ADD CONSTRAINT PK_Evento PRIMARY KEY (id_evento);
ALTER TABLE Usuario ADD CONSTRAINT PK_Usuario PRIMARY KEY (nombreUsuario);
ALTER TABLE Grupo ADD CONSTRAINT PK_Grupo  PRIMARY KEY (nombre);
ALTER TABLE UsuarioXgrupo ADD CONSTRAINT PK_UsuarioXgrupo PRIMARY KEY (nombre,nombreUsuario);
ALTER TABLE Chat ADD CONSTRAINT PK_Chat PRIMARY KEY (id_chat);
ALTER TABLE Intercambio ADD CONSTRAINT PK_Intercambio PRIMARY KEY (id_inter);
ALTER TABLE Notificacion ADD CONSTRAINT PK_Notificacion PRIMARY KEY (codigo_noti);

/*Unicas*/
ALTER TABLE Usuario ADD CONSTRAINT UK_Usuario_correo UNIQUE (correo);
ALTER TABLE Libro ADD CONSTRAINT UK_Libro_titulo UNIQUE (titulo);


/*Foraneas*/

ALTER TABLE Plus ADD CONSTRAINT FK_Plus FOREIGN KEY (idp_plan) REFERENCES Plan_(idp);

ALTER TABLE Free ADD CONSTRAINT FK_Free FOREIGN KEY (idp_plan) REFERENCES Plan_(idp);

ALTER TABLE Publicidad ADD CONSTRAINT FK_Publicidad FOREIGN KEY (idp_plan) REFERENCES Free(idp_plan);

ALTER TABLE Libro ADD CONSTRAINT FK_Libro FOREIGN KEY (nombreUsuario) REFERENCES Usuario(nombreUsuario);

ALTER TABLE Archivo ADD CONSTRAINT FK_Archivo FOREIGN KEY (nombreUsuario, titulo) REFERENCES Libro(nombreUsuario, titulo);

ALTER TABLE Genero ADD CONSTRAINT FK_Genero  FOREIGN KEY (nombreUsuario, titulo) REFERENCES Libro(nombreUsuario, titulo);

ALTER TABLE Evento ADD CONSTRAINT FK_Evento_grupo FOREIGN KEY (id_grupo) REFERENCES Grupo(nombre);
ALTER TABLE Evento ADD CONSTRAINT FK_Evento_localizacion FOREIGN KEY (id_localizacion) REFERENCES Localizacion(id_localizacion);

ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario FOREIGN KEY (id_free) REFERENCES Free(idp_plan);
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_pluss FOREIGN KEY (id_pluss) REFERENCES Plus(idp_plan);
ALTER TABLE Usuario ADD CONSTRAINT FK_Usuario_localizacion FOREIGN KEY (id_localizacion) REFERENCES Localizacion(id_localizacion);

ALTER TABLE Grupo ADD CONSTRAINT FK_Grupo_Organizador FOREIGN KEY (organizador_grupo) REFERENCES Usuario(nombreUsuario);

ALTER TABLE UsuarioXgrupo ADD CONSTRAINT FK_UsuarioXgrupo_nombre FOREIGN KEY (nombre) REFERENCES Grupo (nombre);
ALTER TABLE UsuarioXgrupo ADD CONSTRAINT FK_UsuarioXgrupo_nombreUsuario FOREIGN KEY (nombreUsuario) REFERENCES Usuario(nombreUsuario);

ALTER TABLE Chat ADD CONSTRAINT FK_Cha_Grupo FOREIGN KEY (nombre_grupo) REFERENCES Grupo(nombre);
ALTER TABLE Chat ADD CONSTRAINT FK_Chat_Usuario1 FOREIGN KEY (usuario1) REFERENCES Usuario(nombreUsuario);
ALTER TABLE Chat ADD CONSTRAINT FK_Chat_Usuario2 FOREIGN KEY (usuario2) REFERENCES Usuario(nombreUsuario);

ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_chat FOREIGN KEY (id_chat) REFERENCES Chat(id_chat);
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_Titulo1 FOREIGN KEY (libro_inter1) REFERENCES Libro(titulo);
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_Titulo2 FOREIGN KEY (libro_inter2) REFERENCES Libro(titulo);

ALTER TABLE Notificacion ADD CONSTRAINT FK_Notificacion FOREIGN KEY (id_inter) REFERENCES Intercambio(id_inter);

/*ELIMINAR TODOS LOS TRIGGER Y SECUENCIAS*/
SELECT 'DROP TRIGGER ' || trigger_name || ';' 
FROM user_triggers;

SELECT 'DROP SEQUENCE ' || sequence_name || ';' AS statement
FROM user_sequences;


--Mantener notificaciones:
--Ad
CREATE SEQUENCE secuencia_noti
  START WITH 100
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/

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
--EL
ALTER TABLE Notificacion DROP CONSTRAINT FK_Notificacion;
ALTER TABLE Notificacion ADD CONSTRAINT FK_Notificacion FOREIGN KEY (id_inter) REFERENCES Intercambio(id_inter) ON DELETE CASCADE;

--Mantener Libros:
--Ad
CREATE OR REPLACE TRIGGER TR_Libro_inicial
BEFORE INSERT ON Libro
FOR EACH ROW
BEGIN
    If :NEW.autor = null OR :NEW.sinopsis = null OR :NEW.editorial = null OR :NEW.fecha_impresion = null THEN
        RAISE_APPLICATION_ERROR(-20002, 'Faltan datos obligatorios');
    END IF;
END; 
/


CREATE OR REPLACE TRIGGER TR_Libro_inicial_estado
BEFORE INSERT ON Libro
FOR EACH ROW
BEGIN
    If :NEW.estado = null THEN
        :NEW.estado := 'A';
    ELSE
        RAISE_APPLICATION_ERROR(-20002, 'El estado inicial debe ser abierto');
    END IF;
END;
/
--Mo

CREATE OR REPLACE TRIGGER TR_Libro_ModificarEstado
BEFORE UPDATE ON Libro
FOR EACH ROW
DECLARE
    estadoLibro VARCHAR2(20);
BEGIN 
    SELECT estado INTO estadoLibro FROM Intercambio WHERE libro_inter1 LIKE :OLD.titulo OR libro_inter2 LIKE :OLD.titulo;
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
--EL
CREATE OR REPLACE TRIGGER TR_Libro_Eliminar_Libro
BEFORE DELETE ON Libro
FOR EACH ROW
DECLARE
    idIntercambio VARCHAR2(20);
BEGIN
  SELECT id_inter INTO idIntercambio FROM Intercambio WHERE libro_inter1 LIKE :OLD.titulo OR libro_inter2 LIKE :OLD.titulo;
  IF idIntercambio != null THEN
    RAISE_APPLICATION_ERROR(-20003,'Solo se puede eliminar libros que nunca tuvieron algun proceso de intercambio');
  END IF;
END;
/

ALTER TABLE Libro DROP CONSTRAINT FK_Libro;

ALTER TABLE Libro
ADD CONSTRAINT FK_Libro
FOREIGN KEY (nombreUsuario)
REFERENCES Usuario(nombreUsuario)
ON DELETE CASCADE;

--Mantener intercambios:
--Ad
CREATE SEQUENCE secuencia_intercambio
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/


CREATE OR REPLACE TRIGGER TR_Intercambio_Libro_Disponible
BEFORE INSERT ON Intercambio
FOR EACH ROW
DECLARE
    usuarioInter1 VARCHAR2(16);
    usuarioInter2 VARCHAR2(16);
    disp1 VARCHAR2(10);
    disp2 VARCHAR(10);   
BEGIN 
    SELECT usuario1,usuario2 INTO usuarioInter1,usuarioInter2 FROM Chat WHERE id_chat=:NEW.id_chat;
    SELECT estado INTO disp1 FROM Libro WHERE titulo = :NEW.libro_inter1 AND estado = 'A' AND nombreUsuario = usuarioInter1;
    SELECT estado INTO disp2 FROM Libro WHERE titulo = :NEW.libro_inter2 AND estado = 'A'AND nombreUsuario = usuarioInter2;
    IF disp1 != 'true' OR disp2!='true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE o Titulo del libro no existe');
    END IF;
END;
/


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

--Mo
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
    IF :OLD.estado ='Cancelado' AND :NEW.estado != 'Oculto' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar');
    END IF;
    IF :OLD.estado ='Entregado' AND :NEW.estado != 'Oculto' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar');
    END IF;
END;
/

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
CREATE OR REPLACE TRIGGER TR_Intercambio_Eliminar
BEFORE DELETE ON Notificacion
FOR EACH ROW
BEGIN
    IF :OLD.estado != 'Oculto' THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar una notificacion que no este en oculto');
    END IF;
END;
/


--Mantener usuario:
--Ad
CREATE OR REPLACE TRIGGER TR_Usuario_Insert
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    -- Verificar que el usuario pertenezca a un plan y tenga una localizacion
    IF :new.id_free IS NULL AND :new.id_pluss IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'El usuario debe pertenecer a un plan.');
    END IF;

    IF :new.id_localizacion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'El usuario debe tener una localización asignada.');
    END IF;
    :new.estado := 'A'; -- El estado del usuario inicia en "A" (Activo)
    :new.fecha_conexion:=SYSDATE;
END;
/

--Mo
CREATE OR REPLACE TRIGGER TR_Usuario_Modificar
BEFORE UPDATE ON Usuario
FOR EACH ROW
BEGIN
    IF :new.id_free IS NOT NULL THEN
        :new.id_pluss := null;
    ELSIF :new.id_pluss IS NOT NULL THEN
        :new.id_free := null;
    END IF;
END;
/ 

--El
CREATE OR REPLACE TRIGGER TR_Usuario_Eliminar
BEFORE  DELETE ON Usuario
FOR EACH ROW
DECLARE
    intercambios_activos NUMBER(1);
    es_organizador NUMBER(1);
BEGIN
    -- Verificar si el usuario es organizador de un grupo
    SELECT COUNT(*) INTO es_organizador
    FROM Grupo
    WHERE organizador_grupo = :old.nombreUsuario;

    IF es_organizador > 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'No se puede eliminar el usuario mientras sea organizador de algún grupo.');
    END IF;

    -- Verificar si el usuario tiene intercambios activos
    SELECT COUNT(*) INTO intercambios_activos
    FROM Chat INNER JOIN Intercambio ON Chat.id_chat=Intercambio.id_chat
    WHERE (Chat.usuario1 = :old.nombreUsuario OR chat.usuario2 = :old.nombreUsuario)
    AND Intercambio.estado IN ('Solicitado', 'En proceso');

    IF intercambios_activos > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'No se puede eliminar el usuario mientras tenga intercambios activos.');
    END IF;
    
END;
/

--Mantener plan:
--Ad
CREATE SEQUENCE secuencia_planes
  START WITH 100
  INCREMENT BY 1
  MAXVALUE 999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/

CREATE OR REPLACE TRIGGER TR_Plan_insert
BEFORE INSERT ON Plan_
FOR EACH ROW
BEGIN
    -- Todos los datos del plan son automaticos
    :new.idp:=secuencia_planes.NEXTVAL;
    :new.estado := 'true';
    :new.fecha_inicio := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER TR_Plan_plus_insert
BEFORE INSERT ON plus
FOR EACH ROW
BEGIN
    -- Verificar que el metodo de pago no sea null
    IF :new.medio_pago IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'El metodo de pago no puede ser null para un plan plus.');
    END IF;

    IF :new.precio=15000 THEN
        :new.cantidad_megustas:=50;
        :new.fecha_de_fin:=ADD_MONTHS(SYSDATE, 1);
    ELSIF :new.precio=25000 THEN
        :new.cantidad_megustas:=150;
        :new.fecha_de_fin:=ADD_MONTHS(SYSDATE, 3);
    ELSIF :new.precio=150000 THEN
        :new.cantidad_megustas:=500;
        :new.fecha_de_fin:=ADD_MONTHS(SYSDATE, 12);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_Plan_free_insert
BEFORE INSERT ON Free
FOR EACH ROW
BEGIN
    :new.cantidad_megustas:=10;
END;
/

--Mo
CREATE OR REPLACE TRIGGER TR_Plan_ModificarEstado
BEFORE UPDATE ON Plan_
FOR EACH ROW
DECLARE
    es_Usado NUMBER(1);
BEGIN
    SELECT COUNT(*) INTO es_Usado FROM Usuario WHERE id_free=:old.idp Or id_pluss=:old.idp;
    IF es_Usado>0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'No se puede eliminar el plan mientras el usuario lo use.');
    END IF;
END;
/
--El
CREATE Or REPLACE TRIGGER TR_Plan_ELiminar
BEFORE DELETE ON Plan_
FOR EACH ROW
BEGIN
    -- Verificar si el plan tiene estado en false antes de permitir su eliminacion
    IF :old.estado LIKE 'false' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se pueden eliminar planes con estado en false.');
    END IF;
END;
/




/*VISTAS*/

--Vista de libros de otro usuario que esten disponibles
CREATE VIEW VistaLibrosDisponibles AS
SELECT l.nombreUsuario, l.titulo, l.autor, l.sinopsis, l.editorial, l.comentario, l.fecha_impresion
FROM Libro l
JOIN Usuario u ON l.nombreUsuario = u.nombreUsuario
WHERE l.estado = 'A';

--Vista de los planes para el usuario
CREATE VIEW Vista_Planes AS
SELECT p.idp, p.estado, p.fecha_inicio, 'Plus' AS tipo_plan, pl.cantidad_megustas, pl.fecha_de_fin, pl.precio, pl.medio_pago
FROM Plan_ p
JOIN Plus pl ON p.idp = pl.idp_plan
UNION ALL
SELECT p.idp, p.estado, p.fecha_inicio, 'Free' AS tipo_plan, f.cantidad_megustas, NULL AS fecha_de_fin, NULL AS precio, NULL AS medio_pago
FROM Plan_ p
JOIN Free f ON p.idp = f.idp_plan;

--Vista de usuarios con planes Plus
CREATE VIEW usuarios_plus AS
SELECT u.nombreUsuario, u.nombre, p.idp, p.estado, p.fecha_inicio, pl.cantidad_megustas, pl.fecha_de_fin, pl.precio, pl.medio_pago
FROM Usuario u
INNER JOIN Plan_ ON u.id_pluss = p.idp
INNER JOIN Plus pl ON p.idp = pl.idp_plan;

--Vista de usuarios con planes Free
CREATE VIEW usuarios_free AS
SELECT u.nombreUsuario, u.nombre, p.idp, p.estado, p.fecha_inicio, f.cantidad_megustas
FROM Usuario u
INNER JOIN Plan_ ON u.id_free = p.idp
INNER JOIN Free f ON p.idp = f.idp_plan;

--Vista de libros con su localizacion
CREATE VIEW VistaLibrosConLocalizacion AS
SELECT l.nombreUsuario, l.titulo, l.autor, l.sinopsis, l.editorial, l.comentario, l.fecha_impresion, l.estado, loc.latitud, loc.longitud
FROM Libro l
JOIN Localizacion loc ON l.nombreUsuario = loc.id_localizacion;

--Vistas de eventos con su localizacion
CREATE VIEW eventos_localizacion AS
SELECT e.id_evento, e.id_grupo, e.nombre, e.proposito, e.fecha_inicio, e.fecha_finalizacion, loc.id_localizacion, loc.latitud, loc.longitud
FROM Evento e
LEFT JOIN Localizacion loc ON e.id_localizacion = loc.id_localizacion;

--Vista de los grupos creados por un usuario 
CREATE VIEW GruposPorUsuario AS
SELECT g.nombre AS nombre_grupo, g.miembros
FROM Grupo g
JOIN Usuario u ON g.organizador_grupo = u.nombreUsuario
ORDER BY g.miembros DESC; --ordenados de menor a mayor segun los miembros

--Vista de intercambios de libros con informacion de los usuarios
CREATE VIEW intercambios_usuarios AS
SELECT i.id_inter, i.id_chat, i.libro_inter1, u1.nombre AS nombre_usuario1, i.libro_inter2, u2.nombre AS nombre_usuario2, i.fechaCreacion, i.fechaEntrega, i.calificacion, i.estado
FROM Intercambio i
INNER JOIN Usuario u1 ON i.usuario1 = u1.nombreUsuario
INNER JOIN Usuario u2 ON i.usuario2 = u2.nombreUsuario;




/*XIndicesVistas*/
DROP VIEW VistaLibrosDisponibles;
DROP VIEW Vista_Planes;
DROP VIEW usuarios_plus;
DROP VIEW usuarios_free;
DROP VIEW VistaLibrosConLocalizacion;
DROP VIEW eventos_localizacion;
DROP VIEW GruposPorUsuario;
DROP VIEW intercambios_usuarios;

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
    PROCEDURE modificar_Usuario(us_nombreUsuario IN NUMBER, us_id_free IN NUMBER, us_pluss IN NUMBER, us_localizacion IN NUMBER, us_organizador_grupo IN VARCHAR,  us_correo IN VARCHAR, us_contrasenia IN VARCHAR, us_fecha_conexion IN DATE, us_nombre IN VARCHAR, us_estado IN VARCHAR);
    PROCEDURE eliminar_Usuario(us_nombreUsuario IN NUMBER);
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
    us_nombreUsuario IN NUMBER,
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
    WHERE nombreUsuario = us_nombreUsuario;
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
  PROCEDURE eliminar_Usuario(us_nombreUsuario IN NUMBER) IS
  BEGIN
    DELETE FROM Usuario WHERE nombreUsuario = us_nombreUsuario;
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

--------------------------------------------------------------------------------------------------------
/*Funciones*/
--Mantener publicidad
CREATE OR REPLACE TRIGGER mantener_publicidad
BEFORE INSERT OR UPDATE OR DELETE ON Publicidad
FOR EACH ROW
DECLARE
    tiene_plan_pluss NUMBER(1);
BEGIN
    IF UPDATING THEN
        -- No se permite la modificacion del ID de la publicidad
        IF :new.idpu <> :old.idpu THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el ID de la publicidad.');
        END IF;
    END IF;

    IF DELETING THEN
        -- Verificar si el usuario tiene el plan pluss
        SELECT COUNT(*) INTO tiene_plan_pluss
        FROM Usuario
        WHERE idp_plan = :old.idp_plan
        AND id_pluss IS NOT NULL;

        IF tiene_plan_pluss = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar la publicidad para usuarios sin el plan pluss.');
        END IF;
    END IF;
END;
/


--Registrar evento
CREATE TRIGGER validar_evento
BEFORE INSERT ON eventos
FOR EACH ROW
BEGIN
    IF NEW.nombre_evento IS NULL OR NEW.proposito IS NULL OR NEW.fecha_inicio IS NULL OR NEW.fecha_fin IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Todos los campos obligatorios deben ser proporcionados.';
    END IF;
    
    IF NEW.fecha_inicio >= NEW.fecha_fin THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de inicio debe ser anterior a la fecha de finalización.';
    END IF;
END;

--Mantener Grupos
CREATE OR REPLACE TRIGGER mantener_grupos
BEFORE INSERT OR UPDATE ON Grupo
FOR EACH ROW
DECLARE
    v_usuario VARCHAR2(50);
BEGIN
    -- Obtener el usuario actual
    SELECT USER INTO v_usuario FROM dual;

    -- Verificar si se esta insertando un nuevo grupo
    IF INSERTING THEN
        :NEW.organizador_grupo := v_usuario;
        :NEW.estado := 'A'; -- estado del grupo como "activo"
    END IF;

    IF UPDATING('miembros') THEN
        :NEW.miembros := :NEW.miembros;
    END IF;
    IF UPDATING('organizador_grupo') THEN
        IF :NEW.organizador_grupo <> v_usuario THEN -- Restringir la actualizacion del organizador al usuario actual
            RAISE_APPLICATION_ERROR(-20001, 'No tienes permiso para cambiar el organizador del grupo.');
        END IF;
    END IF;
END;
/

--Mantener chat
CREATE OR REPLACE TRIGGER mantener_chats
BEFORE INSERT OR UPDATE OR DELETE ON Chat
FOR EACH ROW
DECLARE
    intercambios_en_proceso NUMBER(1);
BEGIN
    IF INSERTING THEN
        -- Verificar que el chat no sea creado solo con un usuario
        IF :new.usuario1 = :new.usuario2 THEN
            RAISE_APPLICATION_ERROR(-20001, 'El chat debe incluir a dos usuarios diferentes.');
        END IF;

        -- Generar el apodo del chat si no se proporciona
        IF :new.apodo IS NULL THEN
            :new.apodo := 'Chat ' || :new.usuario1 || ' ' || :new.usuario2;
        END IF;
    END IF;

    IF UPDATING('apodo') THEN
        -- No se permiten cambios en el apodo del chat
        RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar el apodo del chat.');
    END IF;

    IF DELETING THEN
        -- Verificar si hay intercambios en proceso relacionados con el chat
        SELECT COUNT(*) INTO intercambios_en_proceso
        FROM Intercambio
        WHERE id_chat = :old.id_chat
        AND estado = 'P';

        IF intercambios_en_proceso > 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar el chat mientras haya intercambios en proceso.');
        END IF;
    END IF;
END;
/

--Registrar Localizacion
CREATE OR REPLACE TRIGGER registrar_localizacion
BEFORE INSERT OR UPDATE OR DELETE ON Localizacion
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Generar automaticamente la localizacion usando la ubicacion actual del usuario
        :new.latitud := obtener_latitud();
        :new.longitud := obtener_longitud();
    END IF;

    IF UPDATING('latitud') OR UPDATING('longitud') THEN
        -- No se permite modificar la localizacion
        RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar la localización.');
    END IF;

    IF DELETING THEN
        -- No se permite eliminar la localizacion
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar la localización.');
    END IF;
END;
/

-------------------------------------------------------------------------------------------

--Registrar evento:
--Ad
CREATE SEQUENCE seq_evento START WITH 1 INCREMENT BY 1; -- para definir un id que incremente automaticamente

CREATE OR REPLACE TRIGGER TR_registrar_evento
BEFORE INSERT ON Evento
FOR EACH ROW
BEGIN
    If :NEW.nombre = null OR :NEW.proposito = null OR :NEW.fecha_inicio = null OR :NEW.fecha_finalizacion = null THEN
        RAISE_APPLICATION_ERROR(-20002, 'Faltan datos obligatorios');
    END IF;

	IF INSERTING THEN
		:new.id_evento := seq_evento.NEXTVAL;
	END IF;

	IF UPDATING THEN
        -- No se permite la modificacion del ID de la publicidad
		IF :new.id_evento <> :old.id_evento THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Id del evento.');
        END IF;
        IF :new.id_grupo <> :old.id_grupo THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Id Grupo del evento.');
        END IF;
		IF :new.nombre <> :old.nombre THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Nombre del evento.');
        END IF;
		IF :new.proposito <> :old.proposito THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Proposito del evento.');
        END IF;
		IF :new.asisten <> :old.asisten THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el campo Asisten del evento.');
        END IF;
		IF :new.interesados <> :old.interesados THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el campo Interesados del evento.');
        END IF;
	END IF;

	IF DELETING THEN
		IF getdate() < new.fecha_inicio THEN
			RAISE_APPLICATION_ERROR(-20003, 'No se Se puede eliminar antes de la fecha de inicio.');
		END IF;
	END IF;

END;



--Mantener los grupos:
CREATE OR REPLACE TRIGGER TR_registrar_grupos
BEFORE INSERT ON Grupo
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		DECLARE creador_grupo_usuario NUMBER(1);
		SELECT COUNT(*) INTO creador_grupo_usuario
		FROM usuario
		WHERE nombre = :old.organizador_grupo
		IF creador_grupo_usuario = 0 THEN
			RAISE_APPLICATION_ERROR(-20003, 'Los grupos creados deben ser creados por un usuario.');
		End;
		IF :new.apodo = 0 THEN
			:new.miembros := 1;
		END IF;
	END IF;

	IF UPDATING THEN
		IF :new.organizador_grupo <> :old.organizador_grupo and  :new.miembros <> :old.miembros  THEN
			RAISE_APPLICATION_ERROR(-20003, 'El orgnizador es el unico que puede modificar los miembros.');
		END IF;
		IF :new.nombre <> :old.nombre THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Nombre del grupo.');
        END IF;
        IF :new.estado <> :old.estado THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el Estado del grupo.');
        END IF;
		IF :new.miembros <> :old.miembros THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar los Miembros del evento.');
        END IF;
		IF :new.organizador_grupo <> :old.organizador_grupo THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el organizador del grupo del evento.');
        END IF;
	END IF;

	IF DELETING THEN
		IF :new.organizador_grupo <> :old.organizador_grupo THEN
			RAISE_APPLICATION_ERROR(-20003, 'El orgnizador es el unico que puede elminar el grupo.');
		END IF;
	END IF;
END;





