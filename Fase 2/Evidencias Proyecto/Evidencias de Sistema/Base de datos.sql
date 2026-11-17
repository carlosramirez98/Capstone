--
-- PostgreSQL database dump
--

\restrict z1SXhbs69LeKj7lrWceEnBfuCPQCw8926j5JSt3m8ZE0HSmdN2p1zxX3UmchxW5

-- Dumped from database version 18.7 (a21afb5)
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-17 04:13:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 24576)
-- Name: adjudicacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adjudicacion (
    id_adjudicacion bigint NOT NULL,
    id_producto bigint NOT NULL,
    id_comprador bigint NOT NULL,
    id_mensaje bigint,
    tipo character varying(20) DEFAULT 'automatica'::character varying NOT NULL,
    estado character varying(30) DEFAULT 'pendiente'::character varying NOT NULL,
    fecha_hora timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT adjudicacion_estado_check CHECK (((estado)::text = ANY (ARRAY[('pendiente'::character varying)::text, ('aceptada'::character varying)::text, ('cancelada'::character varying)::text, ('vencida'::character varying)::text]))),
    CONSTRAINT adjudicacion_tipo_check CHECK (((tipo)::text = ANY (ARRAY[('automatica'::character varying)::text, ('manual'::character varying)::text])))
);


--
-- TOC entry 220 (class 1259 OID 24590)
-- Name: adjudicacion_id_adjudicacion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.adjudicacion ALTER COLUMN id_adjudicacion ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adjudicacion_id_adjudicacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 65554)
-- Name: alertas_prendas_aceptadas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alertas_prendas_aceptadas (
    id_alerta bigint NOT NULL,
    id_usuario bigint NOT NULL,
    aceptada_en timestamp with time zone DEFAULT now() NOT NULL
);
ALTER TABLE ONLY public.alertas_prendas_aceptadas ALTER COLUMN id_alerta SET (pg_attver=34188136);
ALTER TABLE ONLY public.alertas_prendas_aceptadas ALTER COLUMN id_usuario SET (pg_attver=34188136);
ALTER TABLE ONLY public.alertas_prendas_aceptadas ALTER COLUMN aceptada_en SET (pg_attver=34188136);


--
-- TOC entry 240 (class 1259 OID 65538)
-- Name: alertas_prendas_liberadas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alertas_prendas_liberadas (
    id_alerta bigint NOT NULL,
    id_pedido bigint NOT NULL,
    id_producto bigint NOT NULL,
    codigo character varying(100) NOT NULL,
    descripcion text,
    resultado character varying(20) NOT NULL,
    creada_en timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT alertas_prendas_liberadas_resultado_check CHECK (((resultado)::text = ANY ((ARRAY['disponible'::character varying, 'reasignada'::character varying])::text[])))
);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN id_alerta SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN id_pedido SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN id_producto SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN codigo SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN descripcion SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN resultado SET (pg_attver=34159192);
ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN creada_en SET (pg_attver=34159192);


--
-- TOC entry 239 (class 1259 OID 65537)
-- Name: alertas_prendas_liberadas_id_alerta_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alertas_prendas_liberadas_id_alerta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 239
-- Name: alertas_prendas_liberadas_id_alerta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alertas_prendas_liberadas_id_alerta_seq OWNED BY public.alertas_prendas_liberadas.id_alerta;


--
-- TOC entry 221 (class 1259 OID 24591)
-- Name: comprador; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comprador (
    id_comprador bigint NOT NULL,
    plataforma character varying(30) DEFAULT 'tiktok'::character varying NOT NULL,
    username character varying(150) NOT NULL,
    nickname character varying(150),
    nombre character varying(150),
    telefono character varying(30),
    correo character varying(150),
    fecha_registro timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 24602)
-- Name: comprador_id_comprador_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.comprador ALTER COLUMN id_comprador ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comprador_id_comprador_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 24603)
-- Name: detalle_pedido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detalle_pedido (
    id_detalle bigint NOT NULL,
    id_pedido bigint NOT NULL,
    id_producto bigint NOT NULL,
    precio_unitario integer NOT NULL,
    CONSTRAINT detalle_pedido_precio_unitario_check CHECK ((precio_unitario > 0))
);


--
-- TOC entry 224 (class 1259 OID 24611)
-- Name: detalle_pedido_id_detalle_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.detalle_pedido ALTER COLUMN id_detalle ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.detalle_pedido_id_detalle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 24612)
-- Name: lista_espera; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lista_espera (
    id_lista_espera bigint NOT NULL,
    id_producto bigint NOT NULL,
    id_comprador bigint NOT NULL,
    id_mensaje bigint,
    posicion integer NOT NULL,
    estado character varying(30) DEFAULT 'esperando'::character varying NOT NULL,
    fecha_hora timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT lista_espera_estado_check CHECK (((estado)::text = ANY (ARRAY[('esperando'::character varying)::text, ('promovido'::character varying)::text, ('cancelado'::character varying)::text]))),
    CONSTRAINT lista_espera_posicion_check CHECK ((posicion > 0))
);


--
-- TOC entry 226 (class 1259 OID 24625)
-- Name: lista_espera_id_lista_espera_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.lista_espera ALTER COLUMN id_lista_espera ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lista_espera_id_lista_espera_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 24626)
-- Name: live; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.live (
    id_live bigint NOT NULL,
    id_usuario bigint NOT NULL,
    titulo character varying(150),
    cuenta_tiktok character varying(100),
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    estado character varying(30) DEFAULT 'preparacion'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT live_estado_check CHECK (((estado)::text = ANY (ARRAY[('preparacion'::character varying)::text, ('en_curso'::character varying)::text, ('finalizado'::character varying)::text, ('cancelado'::character varying)::text])))
);


--
-- TOC entry 228 (class 1259 OID 24636)
-- Name: live_id_live_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.live ALTER COLUMN id_live ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.live_id_live_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 24637)
-- Name: mensaje_chat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mensaje_chat (
    id_mensaje bigint NOT NULL,
    id_live bigint NOT NULL,
    id_comprador bigint,
    plataforma character varying(30) DEFAULT 'tiktok'::character varying NOT NULL,
    username character varying(150) NOT NULL,
    nickname character varying(150),
    contenido text NOT NULL,
    fecha_hora timestamp with time zone DEFAULT now() NOT NULL,
    orden_recepcion bigint NOT NULL,
    codigo_detectado character varying(30),
    intencion_compra boolean DEFAULT false NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 24653)
-- Name: mensaje_chat_id_mensaje_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.mensaje_chat ALTER COLUMN id_mensaje ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.mensaje_chat_id_mensaje_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 49153)
-- Name: pago_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pago_flow (
    id_pago_flow bigint NOT NULL,
    id_pedido bigint NOT NULL,
    orden_comercio character varying(100) NOT NULL,
    flow_order bigint,
    token_flow text,
    url_pago text,
    correo_pagador character varying(254) NOT NULL,
    monto_clp bigint NOT NULL,
    estado character varying(20) DEFAULT 'creando'::character varying NOT NULL,
    creado_en timestamp with time zone DEFAULT now() NOT NULL,
    actualizado_en timestamp with time zone DEFAULT now() NOT NULL,
    confirmado_en timestamp with time zone,
    CONSTRAINT pago_flow_estado_check CHECK (((estado)::text = ANY ((ARRAY['creando'::character varying, 'pendiente'::character varying, 'pagado'::character varying, 'rechazado'::character varying, 'anulado'::character varying, 'expirado'::character varying, 'error'::character varying])::text[]))),
    CONSTRAINT pago_flow_monto_clp_check CHECK ((monto_clp > 0))
);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN id_pago_flow SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN id_pedido SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN orden_comercio SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN flow_order SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN token_flow SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN url_pago SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN correo_pagador SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN monto_clp SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN estado SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN creado_en SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN actualizado_en SET (pg_attver=31723568);
ALTER TABLE ONLY public.pago_flow ALTER COLUMN confirmado_en SET (pg_attver=31723568);


--
-- TOC entry 237 (class 1259 OID 49152)
-- Name: pago_flow_id_pago_flow_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.pago_flow ALTER COLUMN id_pago_flow ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.pago_flow_id_pago_flow_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 24654)
-- Name: pedido; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pedido (
    id_pedido bigint NOT NULL,
    id_comprador bigint NOT NULL,
    id_live bigint NOT NULL,
    total integer DEFAULT 0 NOT NULL,
    estado_pago character varying(30) DEFAULT 'pendiente_pago'::character varying NOT NULL,
    estado_preparacion character varying(30) DEFAULT 'por_preparar'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    fecha_pago timestamp with time zone,
    token_acceso character varying(150),
    metodo_pago character varying(30),
    referencia_pago character varying(150),
    token_carrito character varying(43),
    plazo_pago_hasta timestamp with time zone,
    pago_expirado_en timestamp with time zone,
    CONSTRAINT pedido_estado_pago_check CHECK (((estado_pago)::text = ANY (ARRAY[('pendiente_pago'::character varying)::text, ('pagado'::character varying)::text]))),
    CONSTRAINT pedido_estado_preparacion_check CHECK (((estado_preparacion)::text = ANY (ARRAY[('por_preparar'::character varying)::text, ('preparado'::character varying)::text]))),
    CONSTRAINT pedido_total_check CHECK ((total >= 0))
);
ALTER TABLE ONLY public.pedido ALTER COLUMN plazo_pago_hasta SET (pg_attver=33547584);
ALTER TABLE ONLY public.pedido ALTER COLUMN pago_expirado_en SET (pg_attver=33548040);


--
-- TOC entry 232 (class 1259 OID 24671)
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.pedido ALTER COLUMN id_pedido ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pedido_id_pedido_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 24672)
-- Name: producto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.producto (
    id_producto bigint NOT NULL,
    id_live bigint NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion character varying(255),
    precio integer DEFAULT 5000 NOT NULL,
    imagen_url text,
    estado character varying(30) DEFAULT 'disponible'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT producto_estado_check CHECK (((estado)::text = ANY (ARRAY[('disponible'::character varying)::text, ('pendiente'::character varying)::text, ('reservado'::character varying)::text, ('vendido'::character varying)::text, ('liberado'::character varying)::text]))),
    CONSTRAINT producto_precio_check CHECK ((precio > 0))
);


--
-- TOC entry 234 (class 1259 OID 24688)
-- Name: producto_id_producto_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.producto ALTER COLUMN id_producto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.producto_id_producto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 24689)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id_usuario bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(150) NOT NULL,
    password_hash text NOT NULL,
    rol character varying(30) DEFAULT 'vendedor'::character varying NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT usuario_rol_check CHECK (((rol)::text = ANY (ARRAY[('vendedor'::character varying)::text, ('administrador'::character varying)::text])))
);


--
-- TOC entry 236 (class 1259 OID 24705)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.usuario ALTER COLUMN id_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3350 (class 2604 OID 65541)
-- Name: alertas_prendas_liberadas id_alerta; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas_prendas_liberadas ALTER COLUMN id_alerta SET DEFAULT nextval('public.alertas_prendas_liberadas_id_alerta_seq'::regclass);


--
-- TOC entry 3369 (class 2606 OID 24707)
-- Name: adjudicacion adjudicacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjudicacion
    ADD CONSTRAINT adjudicacion_pkey PRIMARY KEY (id_adjudicacion);


--
-- TOC entry 3427 (class 2606 OID 65562)
-- Name: alertas_prendas_aceptadas alertas_prendas_aceptadas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas_prendas_aceptadas
    ADD CONSTRAINT alertas_prendas_aceptadas_pkey PRIMARY KEY (id_alerta, id_usuario);


--
-- TOC entry 3425 (class 2606 OID 65553)
-- Name: alertas_prendas_liberadas alertas_prendas_liberadas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas_prendas_liberadas
    ADD CONSTRAINT alertas_prendas_liberadas_pkey PRIMARY KEY (id_alerta);


--
-- TOC entry 3373 (class 2606 OID 24709)
-- Name: comprador comprador_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comprador
    ADD CONSTRAINT comprador_pkey PRIMARY KEY (id_comprador);


--
-- TOC entry 3377 (class 2606 OID 24711)
-- Name: detalle_pedido detalle_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT detalle_pedido_pkey PRIMARY KEY (id_detalle);


--
-- TOC entry 3383 (class 2606 OID 24713)
-- Name: lista_espera lista_espera_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT lista_espera_pkey PRIMARY KEY (id_lista_espera);


--
-- TOC entry 3387 (class 2606 OID 24715)
-- Name: live live_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.live
    ADD CONSTRAINT live_pkey PRIMARY KEY (id_live);


--
-- TOC entry 3391 (class 2606 OID 24717)
-- Name: mensaje_chat mensaje_chat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT mensaje_chat_pkey PRIMARY KEY (id_mensaje);


--
-- TOC entry 3416 (class 2606 OID 49176)
-- Name: pago_flow pago_flow_flow_order_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pago_flow
    ADD CONSTRAINT pago_flow_flow_order_key UNIQUE (flow_order);


--
-- TOC entry 3418 (class 2606 OID 49174)
-- Name: pago_flow pago_flow_orden_comercio_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pago_flow
    ADD CONSTRAINT pago_flow_orden_comercio_key UNIQUE (orden_comercio);


--
-- TOC entry 3420 (class 2606 OID 49172)
-- Name: pago_flow pago_flow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pago_flow
    ADD CONSTRAINT pago_flow_pkey PRIMARY KEY (id_pago_flow);


--
-- TOC entry 3422 (class 2606 OID 49178)
-- Name: pago_flow pago_flow_token_flow_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pago_flow
    ADD CONSTRAINT pago_flow_token_flow_key UNIQUE (token_flow);


--
-- TOC entry 3400 (class 2606 OID 24719)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 3402 (class 2606 OID 24721)
-- Name: pedido pedido_token_acceso_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_token_acceso_key UNIQUE (token_acceso);


--
-- TOC entry 3407 (class 2606 OID 24723)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (id_producto);


--
-- TOC entry 3375 (class 2606 OID 24725)
-- Name: comprador uq_comprador_plataforma_username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comprador
    ADD CONSTRAINT uq_comprador_plataforma_username UNIQUE (plataforma, username);


--
-- TOC entry 3380 (class 2606 OID 24727)
-- Name: detalle_pedido uq_detalle_producto; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT uq_detalle_producto UNIQUE (id_producto);


--
-- TOC entry 3385 (class 2606 OID 24729)
-- Name: lista_espera uq_lista_producto_comprador; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT uq_lista_producto_comprador UNIQUE (id_producto, id_comprador);


--
-- TOC entry 3393 (class 2606 OID 24731)
-- Name: mensaje_chat uq_mensaje_orden_live; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT uq_mensaje_orden_live UNIQUE (id_live, orden_recepcion);


--
-- TOC entry 3409 (class 2606 OID 24735)
-- Name: producto uq_producto_codigo_live; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT uq_producto_codigo_live UNIQUE (id_live, codigo);


--
-- TOC entry 3411 (class 2606 OID 24737)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 3413 (class 2606 OID 24739)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3370 (class 1259 OID 24740)
-- Name: idx_adjudicacion_comprador; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_adjudicacion_comprador ON public.adjudicacion USING btree (id_comprador);


--
-- TOC entry 3371 (class 1259 OID 24741)
-- Name: idx_adjudicacion_producto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_adjudicacion_producto ON public.adjudicacion USING btree (id_producto);


--
-- TOC entry 3378 (class 1259 OID 24742)
-- Name: idx_detalle_pedido; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_detalle_pedido ON public.detalle_pedido USING btree (id_pedido);


--
-- TOC entry 3381 (class 1259 OID 24743)
-- Name: idx_lista_producto; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lista_producto ON public.lista_espera USING btree (id_producto);


--
-- TOC entry 3388 (class 1259 OID 24744)
-- Name: idx_mensaje_codigo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mensaje_codigo ON public.mensaje_chat USING btree (codigo_detectado);


--
-- TOC entry 3389 (class 1259 OID 24745)
-- Name: idx_mensaje_live; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_mensaje_live ON public.mensaje_chat USING btree (id_live);


--
-- TOC entry 3414 (class 1259 OID 49185)
-- Name: idx_pago_flow_pedido; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pago_flow_pedido ON public.pago_flow USING btree (id_pedido, creado_en DESC);


--
-- TOC entry 3394 (class 1259 OID 24746)
-- Name: idx_pedido_comprador; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pedido_comprador ON public.pedido USING btree (id_comprador);


--
-- TOC entry 3395 (class 1259 OID 24747)
-- Name: idx_pedido_estado_pago; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pedido_estado_pago ON public.pedido USING btree (estado_pago);


--
-- TOC entry 3396 (class 1259 OID 24748)
-- Name: idx_pedido_live; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pedido_live ON public.pedido USING btree (id_live);


--
-- TOC entry 3397 (class 1259 OID 65536)
-- Name: idx_pedido_plazo_pago; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pedido_plazo_pago ON public.pedido USING btree (plazo_pago_hasta) WHERE (((estado_pago)::text = 'pendiente_pago'::text) AND (pago_expirado_en IS NULL));


--
-- TOC entry 3398 (class 1259 OID 24749)
-- Name: idx_pedido_preparacion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pedido_preparacion ON public.pedido USING btree (estado_preparacion);


--
-- TOC entry 3405 (class 1259 OID 24750)
-- Name: idx_producto_live; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_producto_live ON public.producto USING btree (id_live);


--
-- TOC entry 3403 (class 1259 OID 24751)
-- Name: pedido_token_carrito_unico; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pedido_token_carrito_unico ON public.pedido USING btree (token_carrito) WHERE (token_carrito IS NOT NULL);


--
-- TOC entry 3423 (class 1259 OID 49184)
-- Name: uq_pago_flow_intento_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_pago_flow_intento_activo ON public.pago_flow USING btree (id_pedido) WHERE ((estado)::text = ANY ((ARRAY['creando'::character varying, 'pendiente'::character varying])::text[]));


--
-- TOC entry 3404 (class 1259 OID 57344)
-- Name: uq_pedido_pendiente_live_comprador; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_pedido_pendiente_live_comprador ON public.pedido USING btree (id_live, id_comprador) WHERE ((estado_pago)::text = 'pendiente_pago'::text);


--
-- TOC entry 3443 (class 2606 OID 65563)
-- Name: alertas_prendas_aceptadas alertas_prendas_aceptadas_id_alerta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alertas_prendas_aceptadas
    ADD CONSTRAINT alertas_prendas_aceptadas_id_alerta_fkey FOREIGN KEY (id_alerta) REFERENCES public.alertas_prendas_liberadas(id_alerta) ON DELETE CASCADE;


--
-- TOC entry 3428 (class 2606 OID 24752)
-- Name: adjudicacion fk_adjudicacion_comprador; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjudicacion
    ADD CONSTRAINT fk_adjudicacion_comprador FOREIGN KEY (id_comprador) REFERENCES public.comprador(id_comprador);


--
-- TOC entry 3429 (class 2606 OID 24757)
-- Name: adjudicacion fk_adjudicacion_mensaje; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjudicacion
    ADD CONSTRAINT fk_adjudicacion_mensaje FOREIGN KEY (id_mensaje) REFERENCES public.mensaje_chat(id_mensaje);


--
-- TOC entry 3430 (class 2606 OID 24762)
-- Name: adjudicacion fk_adjudicacion_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjudicacion
    ADD CONSTRAINT fk_adjudicacion_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 3431 (class 2606 OID 24767)
-- Name: detalle_pedido fk_detalle_pedido; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido);


--
-- TOC entry 3432 (class 2606 OID 24772)
-- Name: detalle_pedido fk_detalle_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detalle_pedido
    ADD CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 3433 (class 2606 OID 24777)
-- Name: lista_espera fk_lista_comprador; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT fk_lista_comprador FOREIGN KEY (id_comprador) REFERENCES public.comprador(id_comprador);


--
-- TOC entry 3434 (class 2606 OID 24782)
-- Name: lista_espera fk_lista_mensaje; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT fk_lista_mensaje FOREIGN KEY (id_mensaje) REFERENCES public.mensaje_chat(id_mensaje);


--
-- TOC entry 3435 (class 2606 OID 24787)
-- Name: lista_espera fk_lista_producto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lista_espera
    ADD CONSTRAINT fk_lista_producto FOREIGN KEY (id_producto) REFERENCES public.producto(id_producto);


--
-- TOC entry 3436 (class 2606 OID 24792)
-- Name: live fk_live_usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.live
    ADD CONSTRAINT fk_live_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 3437 (class 2606 OID 24797)
-- Name: mensaje_chat fk_mensaje_comprador; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT fk_mensaje_comprador FOREIGN KEY (id_comprador) REFERENCES public.comprador(id_comprador);


--
-- TOC entry 3438 (class 2606 OID 24802)
-- Name: mensaje_chat fk_mensaje_live; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mensaje_chat
    ADD CONSTRAINT fk_mensaje_live FOREIGN KEY (id_live) REFERENCES public.live(id_live);


--
-- TOC entry 3439 (class 2606 OID 24807)
-- Name: pedido fk_pedido_comprador; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_comprador FOREIGN KEY (id_comprador) REFERENCES public.comprador(id_comprador);


--
-- TOC entry 3440 (class 2606 OID 24812)
-- Name: pedido fk_pedido_live; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_pedido_live FOREIGN KEY (id_live) REFERENCES public.live(id_live);


--
-- TOC entry 3441 (class 2606 OID 24817)
-- Name: producto fk_producto_live; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT fk_producto_live FOREIGN KEY (id_live) REFERENCES public.live(id_live);


--
-- TOC entry 3442 (class 2606 OID 49179)
-- Name: pago_flow pago_flow_id_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pago_flow
    ADD CONSTRAINT pago_flow_id_pedido_fkey FOREIGN KEY (id_pedido) REFERENCES public.pedido(id_pedido) ON DELETE RESTRICT;


-- Completed on 2026-11-17 04:13:13

--
-- PostgreSQL database dump complete
--

\unrestrict z1SXhbs69LeKj7lrWceEnBfuCPQCw8926j5JSt3m8ZE0HSmdN2p1zxX3UmchxW5

