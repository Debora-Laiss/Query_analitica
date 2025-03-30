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
-- Name: dados_financeiros; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dados_financeiros (
    id text NOT NULL,
    data date,
    reg_ans character varying(20),
    cd_conta_contabil character varying(50),
    descricao text,
    vl_saldo_inicial numeric(15,2),
    vl_saldo_final numeric(15,2)
);


ALTER TABLE public.dados_financeiros OWNER TO postgres;

--
-- Name: dados_financeiros_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dados_financeiros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dados_financeiros_id_seq OWNER TO postgres;

--
-- Name: dados_financeiros_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dados_financeiros_id_seq OWNED BY public.dados_financeiros.id;


--
-- Name: dados_financeiros id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dados_financeiros ALTER COLUMN id SET DEFAULT nextval('public.dados_financeiros_id_seq'::regclass);


--
-- Name: dados_financeiros dados_financeiros_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dados_financeiros
    ADD CONSTRAINT dados_financeiros_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

