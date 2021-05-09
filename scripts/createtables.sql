CREATE TABLE codigo_http (
    id           NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    codigo       NUMBER NOT NULL,
    descripcion  VARCHAR2(50) NOT NULL
);

ALTER TABLE codigo_http ADD CONSTRAINT codigo_http_pk PRIMARY KEY ( codigo );

CREATE TABLE chat (
    id_emisor    NUMBER NOT NULL,
    id_receptor  NUMBER NOT NULL,
    id           NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 )
);

ALTER TABLE chat ADD CONSTRAINT chat_pk PRIMARY KEY ( id );

CREATE TABLE equipo (
    id       NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    nombre   VARCHAR2(30 BYTE),
    deporte  VARCHAR2(30 BYTE)
);

ALTER TABLE equipo ADD CONSTRAINT equipo_pk PRIMARY KEY ( id );

CREATE TABLE estado_usuario (
    id            NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    id_usuario    NUMBER NOT NULL,
    id_membresia  NUMBER NOT NULL,
    id_temporada  NUMBER NOT NULL
);

ALTER TABLE estado_usuario ADD CONSTRAINT estado_usuario_pk PRIMARY KEY ( id );

CREATE TABLE evento (
    id                    NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    id_jornada            NUMBER NOT NULL,
    id_equipo_local       NUMBER NOT NULL,
    id_equipo_visitante   NUMBER NOT NULL,
    deporte               VARCHAR2(30),
    puntuacion_local      NUMBER,
    puntuacion_visitante  NUMBER,
    estado                VARCHAR2(15 BYTE)
);

ALTER TABLE evento ADD CONSTRAINT evento_pk PRIMARY KEY ( id );

CREATE TABLE jornada (
    id            NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    id_temporada  NUMBER NOT NULL,
    fecha_inicio  DATE,
    fecha_final   DATE,
    estado        VARCHAR2(15 BYTE)
);

ALTER TABLE jornada ADD CONSTRAINT jornada_pk PRIMARY KEY ( id );

CREATE TABLE membresia (
    id      NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    nombre  VARCHAR2(30 BYTE),
    precio  NUMBER,
    alfa    NUMBER
);

ALTER TABLE membresia ADD CONSTRAINT membresia_pk PRIMARY KEY ( id );

CREATE TABLE mensaje (
    id           NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    id_chat      NUMBER NOT NULL,
    emisor       NUMBER,
    contenido    VARCHAR2(300 BYTE),
    fecha_envio  TIMESTAMP
);

ALTER TABLE mensaje ADD CONSTRAINT mensaje_pk PRIMARY KEY ( id );

CREATE TABLE prediccion (
    id                    NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    id_evento             NUMBER NOT NULL,
    id_usuario            NUMBER NOT NULL,
    puntuacion_local      NUMBER,
    puntuacion_visitante  NUMBER,
    fecha_prediccion      TIMESTAMP
);

ALTER TABLE prediccion ADD CONSTRAINT prediccion_pk PRIMARY KEY ( id );

CREATE TABLE temporada (
    id            NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    fecha_inicio  DATE,
    fecha_final   DATE,
    estado        VARCHAR2(15 BYTE)
);

ALTER TABLE temporada ADD CONSTRAINT temporada_pk PRIMARY KEY ( id );

CREATE TABLE usuario (
    id                NUMBER
        GENERATED BY DEFAULT ON NULL AS IDENTITY ( START WITH 1 INCREMENT BY 1 ),
    username          VARCHAR2(30 BYTE),
    correo            VARCHAR2(50 BYTE),
    nombre            VARCHAR2(30),
    apellido          VARCHAR2(30),
    contraseña        VARCHAR2(30),
    saldo             NUMBER,
    fecha_nacimiento  DATE,
    fecha_registro    DATE,
    foto              BLOB
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id );

CREATE UNIQUE INDEX username_i ON
    usuario (
        username
    );
    
CREATE UNIQUE INDEX correo_i ON
    usuario (
        correo
    );

ALTER TABLE chat
    ADD CONSTRAINT chat_usuario_emisor_fk FOREIGN KEY ( id_emisor )
        REFERENCES usuario ( id );

ALTER TABLE chat
    ADD CONSTRAINT chat_usuario_receptor_fk FOREIGN KEY ( id_receptor )
        REFERENCES usuario ( id );

ALTER TABLE evento
    ADD CONSTRAINT evento_equipo_fk FOREIGN KEY ( id_equipo_local )
        REFERENCES equipo ( id );

ALTER TABLE evento
    ADD CONSTRAINT evento_equipo_fkv2 FOREIGN KEY ( id_equipo_visitante )
        REFERENCES equipo ( id );

ALTER TABLE evento
    ADD CONSTRAINT evento_jornada_fk FOREIGN KEY ( id_jornada )
        REFERENCES jornada ( id );

ALTER TABLE jornada
    ADD CONSTRAINT jornada_temporada_fk FOREIGN KEY ( id_temporada )
        REFERENCES temporada ( id );

ALTER TABLE mensaje
    ADD CONSTRAINT mensaje_chat_fk FOREIGN KEY ( id_chat )
        REFERENCES chat ( id );

ALTER TABLE prediccion
    ADD CONSTRAINT prediccion_evento_fk FOREIGN KEY ( id_evento )
        REFERENCES evento ( id );

ALTER TABLE prediccion
    ADD CONSTRAINT prediccion_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id );

ALTER TABLE estado_usuario
    ADD CONSTRAINT puntaje_usuario_membresia_fk FOREIGN KEY ( id_membresia )
        REFERENCES membresia ( id );

ALTER TABLE estado_usuario
    ADD CONSTRAINT recompensa_temporada_fk FOREIGN KEY ( id_temporada )
        REFERENCES temporada ( id );

ALTER TABLE estado_usuario
    ADD CONSTRAINT recompensa_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES usuario ( id );

-- INSERTS
INSERT INTO usuario VALUES (
    NULL,
    'admin',
    'admin@quiniela.mia.com',
    'pablo',
    'cabrera',
    'adminadmin',
    1000,
    TO_DATE('2001/01/26', 'yyyy/mm/dd'),
    TO_DATE('2021/05/01', 'yyyy/mm/dd'),
    utl_raw.cast_to_raw('')
);

INSERT INTO membresia VALUES (
    NULL,
    'bronze',
    150,
    1
);

INSERT INTO membresia VALUES (
    NULL,
    'silver',
    450,
    2
);

INSERT INTO membresia VALUES (
    NULL,
    'gold',
    900,
    3
);

COMMIT WORK;