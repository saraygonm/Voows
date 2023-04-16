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
    comentario VARCHAR2(2000),
    fecha_impresion DATE,
    estado VARCHAR2(1)
);

CREATE TABLE Archivo(
    codigo NUMBER(6) NOT NULL,
    ISBN_libros NUMBER(10) NOT NULL,
    id_usuario NUMBER(10) NOT NULL,
    tipo VARCHAR2(3),
    URL VARCHAR2(50)
);

CREATE TABLE Categoria(
    nombre VARCHAR2(2)NOT NULL,
    ISBN_libros NUMBER(10),
    id_usuario NUMBER(10),
    genero VARCHAR2(2) /*creo que este atributo no deberia estar*/
   
);

CREATE TABLE Genero(
    genero VARCHAR2(2)NOT NULL,
    nombre VARCHAR2(2)NOT NULL
);

CREATE TABLE Localizacion(
    id_localizacion NUMBER(6) NOT NULL,
    latitud NUMBER(8,8), /*real(10)*/
    longitud NUMBER(8,8)
);

CREATE TABLE Evento(
    id_evento NUMBER(6) NOT NULL,
    id_grupo VARCHAR2(50),
    id_localizacion NUMBER(6) NULL,
    nombre VARCHAR2(100),
    proposito VARCHAR2(280),
    fecha_inicio DATE,
    fecha_finalizacion DATE, /*anteriormente se coloco fecha_de_fin*/
    asisten VARCHAR2(50),
    interesados VARCHAR2(50)
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
    numero_intercabios NUMBER(10),
    fechaCreacion DATE,
    fechaEntrega DATE,
    calificacion NUMBER(1)
);

CREATE TABLE Notificacion(
    codigo_noti NUMBER(6),
    id_inter NUMBER(6),
    estado VARCHAR2(20),
    descripcion VARCHAR2(50),
    fecha DATE
    
);

/*xTablas*/
DROP TABLE Planes;
DROP TABLE Plus;
DROP TAblE Free;
DROP TABLE Publicidad;
DROP TABLE Libro;
DROP TABLE Archivo;
DROP TABLE Categoria;
DROP TABLE Genero;
DROP TABLE Localizacion;
DROP TABLE Evento;
DROP TABLE Usuario;
DROP TABLE Grupo;
DROP TABLE UsuarioXgrupo;
DROP TABLE Chat;
DROP TABLE Intercambio;
DROP TABLE Notificacion;

/*Atributos*/
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_idp CHECK(idp >=0);
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_Booleano CHECK(estado = 'True' OR estado = 'False');
ALTER TABLE Planes ADD CONSTRAINT CK_Planes_Booleano2 CHECK(publicidad = 'True' OR publicidad = 'False');


ALTER TABLE Plus ADD CONSTRAINT CK_Plus_precio CHECK(precio = '15000' OR precio = '25000' OR precio = '150000');
ALTER TABLE Plus ADD CONSTRAINT CK_Plus_pago CHECK(medio_pago = 'C' OR medio_pago = 'D' OR medio_pago = 'T');

ALTER TABLE Libro ADD CONSTRAINT CK_Libro_ISBN CHECK (ISBN >=0);
ALTER TABLE Libro ADD CONSTRAINT CK_Libro_estado CHECK (estado = 'A' OR estado = 'C' );

ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_codigo CHECK (codigo >= 0); /*consecutivo?*/
ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_tipo CHECK (tipo = '%jpg' OR tipo ='%gif' OR tipo='%bmp' OR tipo = '%png')
ALTER TABLE Archivo ADD CONSTRAINT CK_Archivo_TURL CHECK(URL like '%https://%' and URL like '%pdf');


ALTER TABLE Categoria ADD CONSTRAINT CK_Categoria_nombre CHECK(nombre = 'A' OR nombre = 'M' OR nombre = 'C' OR nombre ='D'
OR nombre = 'E' OR nombre = 'F' OR nombre ='TE' OR nombre ='RE' OR nombre ='T' OR nombre ='F' OR nombre ='R' OR nombre ='M'
OR nombre ='S' OR nombre ='H' OR nombre ='FI' OR nombre = 'ER' OR nombre ='O');

ALTER TABLE Categoria ADD CONSTRAINT CK_Categoria_genero CHECK(genero = 'N' OR genero = 'L' OR genero = 'D' OR genero ='C'
OR genero = 'CO' OR genero = 'T' OR genero ='P');
/*NO SE AGREGO TABLE GENERO*/

ALTER TABLE Localizacion ADD CONSTRAINT CK_Localizacion_id CHECK(id_localizacion >= 0);

ALTER TABLE Evento ADD CONSTRAINT CK_Evento_id CHECK( id_evento >= 1000000);

ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_id CHECK (idu >= 0); /*consecutivo?*/
ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_correo CHECK (INSTR(correo, '@') > 0 AND INSTR(correo, '.') > 0);
ALTER TABLE Usuario ADD CONSTRAINT CK_Usuario_estado CHECK(estado = 'A' OR estado = 'C');

ALTER TABLE Grupo ADD CONSTRAINT CK_Grupo_estado CHECK (estado = 'A' OR estado = 'C');

ALTER TABLE Chat ADD CONSTRAINT CK_Chat_id CHECK (id_chat >= 1000);

ALTER TABLE Intercambio ADD CONSTRAINT CK_Intercambio_id CHECK (id_inter >= 0 );
ALTER TABLE Intercambio ADD CONSTRAINT CK_Intercambio_califica CHECK(calificacion >=1 AND calificacion <=5);

ALTER TABLE Notificacion ADD CONSTRAINT CK_Notificacion_codigo CHECK (codigo_noti >=0); /*consecutivo?*/
ALTER TABLE Notificacion ADD CONSTRAINT CK_Notificacion_estado CHECK (estado = 'Solicitado' OR estado = 'En proceso' OR estado ='Entregado' OR estado = 'Cancelado' OR estado= 'Oculto');




/*Primarias*/
ALTER TABLE Planes ADD CONSTRAINT PK_Planes PRIMARY KEY (idp);
ALTER TABLE Plus ADD CONSTRAINT PK_Plus  PRIMARY KEY (idp_plan);
ALTER TABLE Free ADD CONSTRAINT PK_Free PRIMARY KEY (idp_plan);
ALTER TABLE Publicidad ADD CONSTRAINT PK_Publicidad PRIMARY KEY (idpu);
ALTER TABLE Libro ADD CONSTRAINT PK_Libro PRIMARY KEY (id_usuario, ISBN);
ALTER TABLE Archivo ADD CONSTRAINT PK_Archivo PRIMARY KEY (codigo,id_usuario, ISBN_libros);
ALTER TABLE Categoria ADD CONSTRAINT PK_Categoria PRIMARY KEY (nombre);
ALTER TABLE Genero ADD CONSTRAINT PK_Genero  PRIMARY KEY (genero,nombre);
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
ALTER TABLE Categoria ADD CONSTRAINT FK_Categoria FOREIGN KEY (id_usuario, ISBN_libros) REFERENCES Libro(id_usuario, ISBN);
ALTER TABLE Genero ADD CONSTRAINT FK_Genero  FOREIGN KEY (nombre) REFERENCES Categoria(nombre);

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
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN1 FOREIGN KEY (libro_inter1), usuario1 REFERENCES Libro(ISBN, id_usuario);
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN2 FOREIGN KEY (libro_inter2, usuario2) REFERENCES Libro(ISBN, id_usuario);
ALTER TABLE Notificacion ADD CONSTRAINT FK_Notificacion FOREIGN KEY (id_inter) REFERENCES Intercambio(id_inter);


/*Ad*/

/* el estado inicial de una notificacion es oculto*/
CREATE OR REPLACE TRIGGER TR_Estado_inicial
BEFORE INSERT ON Intercambio
FOR EACH ROW
BEGIN
    :NEW.estado := 'Oculto';
END;

/*los libros incluídos deben pertenecer al usuario*/

/*los Libros solicitados deben estar disponibles*/
CREATE OR REPLACE TRIGGER TR_Libro_dip
BEFORE INSERT ON Intercambio
FOR EACH ROW
DECLARE
    disp VARCHAR2;   
BEGIN 
    SELECT estado INTO disp FROM Libro AS lib
    JOIN Notificacion AS noti ON Lib.codigo_noti = noti.codigo_noti
    JOIN Intercambio AS Inter ON Lib.id.inter = inter.id.inter
    WHERE numero = :NEW.numero AND estado = 'true';
    IF disp != 'true' THEN
        RAISE_APPLICATION_ERROR(-20003,'No esta DISPONIBLE');
    END IF;
END;*/

/*Mo*/

/*El estado se puede modificar de oculta a abierta y de abierta a cancelada*/
CREATE OR REPLACE TRIGGER TR_ModificarEstado
BEFORE UPDATE ON Intercambio
FOR EACH ROW
BEGIN 
    IF :OLD.estado = 'O' AND :NEW.estado != 'A' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado abierto');
    ELSIF :OLD.estado = 'A' AND :NEW.estado != 'C' THEN
        RAISE_APPLICATION_ERROR(-20003,'Solo se puede pasar a estado oculto');
    END IF;
END;

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

/*El*/
   /*-Solo se puede eliminar los intercambios con notificaciones ocultos*/

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_chat;
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_chat FOREIGN KEY (id_chat) 
REFERENCES Chat(id_chat)ON DELETE CASCADE;

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_ISBN;
ALTER TABLE Intercambio ADD CONSTRAINT FK_Intercambio_ISBN FOREIGN KEY (libro_inter1, usuario1) 
REFERENCES Libro(ISBN, id_usuario) ON DELETE CASCADE;

ALTER TABLE Intercambio DROP CONSTRAINT FK_Intercambio_idu;
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








