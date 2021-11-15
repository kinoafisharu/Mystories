--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

DROP DATABASE story;
DROP ROLE story_client;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE story ENCODING = 'UTF8';


CREATE ROLE story_client LOGIN SUPERUSER PASSWORD '123';
CREATE DATABASE story;

\connect story

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE story IS 'story connection database';


--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: str_articles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.str_articles (
    id integer NOT NULL,
    type integer NOT NULL,
    name text NOT NULL,
    text text NOT NULL,
    date timestamp without time zone NOT NULL,
    user1 integer NOT NULL,
    flag_del integer DEFAULT 0 NOT NULL,
    count integer DEFAULT 0 NOT NULL,
    view integer NOT NULL,
    plus integer NOT NULL,
    minus integer NOT NULL,
    money integer NOT NULL,
    flags character varying(6) NOT NULL,
    date_r timestamp without time zone NOT NULL
);


ALTER TABLE public.str_articles OWNER TO story_client;

--
-- Data for Name: str_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--


COPY public.str_articles (id, type, name, text, date, user1, flag_del, count, view, plus, minus, money, flags, date_r) FROM 'C:{X-PATH-X}/sql_scripts/3305.dat';

--
-- PostgreSQL database dump complete
--