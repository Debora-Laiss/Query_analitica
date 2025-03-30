--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Debian 16.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: operadoras_ativas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operadoras_ativas (
    registro_ans text NOT NULL,
    cnpj text NOT NULL,
    razao_social text,
    nome_fantasia text,
    modalidade text,
    logradouro text,
    numero text,
    complemento text,
    bairro text,
    cidade text,
    uf text,
    cep text,
    ddd text,
    telefone text,
    fax text,
    endereco_eletronico text,
    representante text,
    cargo_representante text,
    regiao_de_comercializacao text,
    data_registro_ans text
);


ALTER TABLE public.operadoras_ativas OWNER TO postgres;

--
-- Name: operadoras_ativas operadoras_ativas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operadoras_ativas
    ADD CONSTRAINT operadoras_ativas_pkey PRIMARY KEY (registro_ans);


--
-- PostgreSQL database dump complete
--

