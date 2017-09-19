--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-09-19 21:07:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 12387)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 1 (class 3079 OID 16394)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- TOC entry 3 (class 3079 OID 16403)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 202 (class 1259 OID 17884)
-- Name: fovpolygons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fovpolygons (
    id character varying NOT NULL,
    camera_location character varying NOT NULL,
    heading double precision NOT NULL,
    viewable_angle double precision DEFAULT 60.00 NOT NULL,
    visible_distance double precision DEFAULT 250.00 NOT NULL,
    geometry geometry NOT NULL,
    "time" bigint
);


ALTER TABLE fovpolygons OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17925)
-- Name: fovpolygons_90; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fovpolygons_90 (
    id character varying NOT NULL,
    camera_location character varying,
    heading numeric,
    viewable_angle numeric,
    visible_distance numeric,
    "time" bigint,
    geometry geometry
);


ALTER TABLE fovpolygons_90 OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17892)
-- Name: points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE points (
    id character varying NOT NULL,
    video character varying NOT NULL,
    location integer,
    heading double precision,
    accuracy integer,
    date date,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    geometry geometry NOT NULL
);


ALTER TABLE points OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 18006)
-- Name: seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17898)
-- Name: videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE videos (
    id character varying NOT NULL,
    file character varying NOT NULL,
    os character varying,
    duration bigint,
    min_height integer,
    min_width integer,
    initial_location geometry,
    orientation integer,
    starttime character varying,
    gps_accuracy integer,
    geomagnetic_declination double precision,
    number integer
);


ALTER TABLE videos OWNER TO postgres;

--
-- TOC entry 3401 (class 2606 OID 17905)
-- Name: fovpolygons PK_fovpolygons; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fovpolygons
    ADD CONSTRAINT "PK_fovpolygons" PRIMARY KEY (id);


--
-- TOC entry 3404 (class 2606 OID 17907)
-- Name: points PK_points; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY points
    ADD CONSTRAINT "PK_points" PRIMARY KEY (id);


--
-- TOC entry 3407 (class 2606 OID 17909)
-- Name: videos PK_videos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT "PK_videos" PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 17932)
-- Name: fovpolygons_90 fovpolygons_90_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fovpolygons_90
    ADD CONSTRAINT fovpolygons_90_pkey PRIMARY KEY (id);


--
-- TOC entry 3402 (class 1259 OID 17920)
-- Name: fovpolygons_gix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fovpolygons_gix ON fovpolygons USING gist (geometry);


--
-- TOC entry 3405 (class 1259 OID 17921)
-- Name: points_gix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX points_gix ON points USING gist (geometry);


--
-- TOC entry 3408 (class 1259 OID 17922)
-- Name: videos_gix; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX videos_gix ON videos USING gist (initial_location);


--
-- TOC entry 3413 (class 2606 OID 17933)
-- Name: fovpolygons_90 FK_fov_cameralocation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fovpolygons_90
    ADD CONSTRAINT "FK_fov_cameralocation" FOREIGN KEY (camera_location) REFERENCES points(id);


--
-- TOC entry 3411 (class 2606 OID 17910)
-- Name: fovpolygons FK_fovpolygons_points; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fovpolygons
    ADD CONSTRAINT "FK_fovpolygons_points" FOREIGN KEY (camera_location) REFERENCES points(id);


--
-- TOC entry 3412 (class 2606 OID 17915)
-- Name: points FK_points_videos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY points
    ADD CONSTRAINT "FK_points_videos" FOREIGN KEY (video) REFERENCES videos(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2017-09-19 21:07:12

--
-- PostgreSQL database dump complete
--

