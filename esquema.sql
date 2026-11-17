-- DROP SEQUENCE public.bolsa_id_seq;

CREATE SEQUENCE public.bolsa_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.carrito_id_seq;

CREATE SEQUENCE public.carrito_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.donacion_id_seq;

CREATE SEQUENCE public.donacion_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.linea_carrito_id_seq;

CREATE SEQUENCE public.linea_carrito_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.pedido_id_seq;

CREATE SEQUENCE public.pedido_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.usuario_id_seq;

CREATE SEQUENCE public.usuario_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.valoracion_id_seq;

CREATE SEQUENCE public.valoracion_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.usuario definition

-- Drop table

-- DROP TABLE public.usuario;

CREATE TABLE public.usuario (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	nombre varchar(100) NOT NULL,
	correo varchar(100) NOT NULL,
	clave_acceso varchar(60) NOT NULL,
	rol varchar(20) NOT NULL,
	estado_cuenta varchar(25) DEFAULT 'ACTIVA'::character varying NOT NULL,
	CONSTRAINT usuario_correo_key UNIQUE (correo),
	CONSTRAINT usuario_pkey PRIMARY KEY (id)
);


-- public.cliente definition

-- Drop table

-- DROP TABLE public.cliente;

CREATE TABLE public.cliente (
	usuario_id int4 NOT NULL,
	foto_perfil varchar(255) NULL,
	direccion varchar(255) NOT NULL,
	saldo numeric(10, 2) DEFAULT 0 NOT NULL,
	CONSTRAINT cliente_pkey PRIMARY KEY (usuario_id),
	CONSTRAINT cliente_saldo_check CHECK ((saldo >= (0)::numeric)),
	CONSTRAINT cliente_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id)
);


-- public.donante definition

-- Drop table

-- DROP TABLE public.donante;

CREATE TABLE public.donante (
	usuario_id int4 NOT NULL,
	fecha_nacimiento date NOT NULL,
	grupo_sanguineo varchar(10) NOT NULL,
	fumador bool DEFAULT false NOT NULL,
	deportista bool DEFAULT false NOT NULL,
	vegetariano bool DEFAULT false NOT NULL,
	direccion varchar(255) NOT NULL,
	fecha_activacion date NULL,
	CONSTRAINT donante_pkey PRIMARY KEY (usuario_id),
	CONSTRAINT donante_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id)
);


-- public.transportista definition

-- Drop table

-- DROP TABLE public.transportista;

CREATE TABLE public.transportista (
	usuario_id int4 NOT NULL,
	CONSTRAINT transportista_pkey PRIMARY KEY (usuario_id),
	CONSTRAINT transportista_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id)
);


-- public.carrito definition

-- Drop table

-- DROP TABLE public.carrito;

CREATE TABLE public.carrito (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	cliente_id int4 NOT NULL,
	fecha_modificacion date DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT carrito_cliente_id_key UNIQUE (cliente_id),
	CONSTRAINT carrito_pkey PRIMARY KEY (id),
	CONSTRAINT carrito_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(usuario_id)
);


-- public.donacion definition

-- Drop table

-- DROP TABLE public.donacion;

CREATE TABLE public.donacion (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	donante_id int4 NOT NULL,
	transportista_id int4 NULL,
	estado varchar(25) DEFAULT 'PENDIENTE_ASIGNACION'::character varying NOT NULL,
	cantidad_bolsas int4 NOT NULL,
	fecha_registro date DEFAULT CURRENT_DATE NOT NULL,
	fecha_validacion date NULL,
	motivo_rechazo varchar(200) NULL,
	direccion_recogida varchar(255) NOT NULL,
	CONSTRAINT donacion_cantidad_bolsas_check CHECK ((cantidad_bolsas >= 1)),
	CONSTRAINT donacion_pkey PRIMARY KEY (id),
	CONSTRAINT donacion_donante_id_fkey FOREIGN KEY (donante_id) REFERENCES public.donante(usuario_id),
	CONSTRAINT donacion_transportista_id_fkey FOREIGN KEY (transportista_id) REFERENCES public.transportista(usuario_id)
);


-- public.linea_carrito definition

-- Drop table

-- DROP TABLE public.linea_carrito;

CREATE TABLE public.linea_carrito (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	carrito_id int4 NOT NULL,
	donacion_id int4 NOT NULL,
	cantidad int4 NOT NULL,
	fecha_anadido date DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT linea_carrito_cantidad_check CHECK ((cantidad >= 1)),
	CONSTRAINT linea_carrito_pkey PRIMARY KEY (id),
	CONSTRAINT linea_carrito_carrito_id_fkey FOREIGN KEY (carrito_id) REFERENCES public.carrito(id),
	CONSTRAINT linea_carrito_donacion_id_fkey FOREIGN KEY (donacion_id) REFERENCES public.donacion(id)
);


-- public.pedido definition

-- Drop table

-- DROP TABLE public.pedido;

CREATE TABLE public.pedido (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	cliente_id int4 NOT NULL,
	transportista_id int4 NULL,
	estado varchar(20) DEFAULT 'PENDIENTE_ENTREGA'::character varying NOT NULL,
	fecha_pedido date DEFAULT CURRENT_DATE NOT NULL,
	fecha_entrega date NULL,
	direccion_entrega varchar(255) NOT NULL,
	CONSTRAINT pedido_pkey PRIMARY KEY (id),
	CONSTRAINT pedido_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(usuario_id),
	CONSTRAINT pedido_transportista_id_fkey FOREIGN KEY (transportista_id) REFERENCES public.transportista(usuario_id)
);


-- public.valoracion definition

-- Drop table

-- DROP TABLE public.valoracion;

CREATE TABLE public.valoracion (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	tipo varchar(10) NOT NULL,
	pedido_id int4 NOT NULL,
	donacion_id int4 NULL,
	puntuacion int4 NOT NULL,
	comentario varchar(500) NULL,
	fecha date DEFAULT CURRENT_DATE NOT NULL,
	CONSTRAINT valoracion_pkey PRIMARY KEY (id),
	CONSTRAINT valoracion_puntuacion_check CHECK (((puntuacion >= 1) AND (puntuacion <= 5))),
	CONSTRAINT valoracion_donacion_id_fkey FOREIGN KEY (donacion_id) REFERENCES public.donacion(id),
	CONSTRAINT valoracion_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(id)
);


-- public.bolsa definition

-- Drop table

-- DROP TABLE public.bolsa;

CREATE TABLE public.bolsa (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	donacion_id int4 NOT NULL,
	estado varchar(15) DEFAULT 'DISPONIBLE'::character varying NOT NULL,
	pedido_id int4 NULL,
	precio_compra numeric(10, 2) NULL,
	fecha_compra date NULL,
	CONSTRAINT bolsa_pkey PRIMARY KEY (id),
	CONSTRAINT bolsa_donacion_id_fkey FOREIGN KEY (donacion_id) REFERENCES public.donacion(id),
	CONSTRAINT bolsa_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(id)
);