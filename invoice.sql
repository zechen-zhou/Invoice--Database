-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 9.5
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public.invoice_t | type: TABLE --
-- DROP TABLE IF EXISTS public.invoice_t CASCADE;
CREATE TABLE public.invoice_t(
	invoice_number char(6) NOT NULL,
	customer_id char(6),
	date date NOT NULL,
	company_name character varying(30) NOT NULL,
	company_phone character varying(15) NOT NULL,
	company_fax character varying(15) NOT NULL,
	company_email character varying(30) NOT NULL,
	company_address character varying(30) NOT NULL,
	company_city character varying(15) NOT NULL,
	company_province char(2) NOT NULL,
	company_postcode char(6) NOT NULL,
	CONSTRAINT "PK_invoice_number" PRIMARY KEY (invoice_number)

);
-- ddl-end --
ALTER TABLE public.invoice_t OWNER TO postgres;
-- ddl-end --

-- object: public.serves_terms_t | type: TABLE --
-- DROP TABLE IF EXISTS public.serves_terms_t CASCADE;
CREATE TABLE public.serves_terms_t(
	"invoice-number" char(6) NOT NULL,
	item_code character varying(5) NOT NULL,
	salesperson character varying(10) NOT NULL,
	job character varying(10) NOT NULL,
	shipping_method character varying(10) NOT NULL,
	shipping_terms integer NOT NULL,
	delivery_date date NOT NULL,
	payment_terms integer NOT NULL,
	duedate date NOT NULL,
	CONSTRAINT "PK_serves_terms_t" PRIMARY KEY ("invoice-number",item_code)

);
-- ddl-end --
ALTER TABLE public.serves_terms_t OWNER TO postgres;
-- ddl-end --

-- object: public.invoice_line_t | type: TABLE --
-- DROP TABLE IF EXISTS public.invoice_line_t CASCADE;
CREATE TABLE public.invoice_line_t(
	invoice_number char(6) NOT NULL,
	invoice_line integer NOT NULL,
	item_code character varying(5) NOT NULL,
	"QTY" integer NOT NULL,
	line_total decimal(5,2) NOT NULL,
	CONSTRAINT "PK_invoice_line_t" PRIMARY KEY (invoice_number,invoice_line)

);
-- ddl-end --
ALTER TABLE public.invoice_line_t OWNER TO postgres;
-- ddl-end --

-- object: public.product_t | type: TABLE --
-- DROP TABLE IF EXISTS public.product_t CASCADE;
CREATE TABLE public.product_t(
	item_code character varying(5) NOT NULL,
	description character varying(40) NOT NULL,
	unit_price decimal(5,2) NOT NULL,
	discount integer,
	CONSTRAINT "PK_product_t" PRIMARY KEY (item_code)

);
-- ddl-end --
ALTER TABLE public.product_t OWNER TO postgres;
-- ddl-end --

-- object: public.customer_t | type: TABLE --
-- DROP TABLE IF EXISTS public.customer_t CASCADE;
CREATE TABLE public.customer_t(
	customer_id char(6) NOT NULL,
	customer_name character varying(30) NOT NULL,
	customer_phone character varying(15) NOT NULL,
	customer_company character varying(30) NOT NULL,
	customer_address character varying(30) NOT NULL,
	customer_city character varying(15) NOT NULL,
	customer_province char(2) NOT NULL,
	customer_postcode char(6) NOT NULL,
	CONSTRAINT "PK_customer_id" PRIMARY KEY (customer_id)

);
-- ddl-end --
ALTER TABLE public.customer_t OWNER TO postgres;
-- ddl-end --

-- object: public.payment_t | type: TABLE --
-- DROP TABLE IF EXISTS public.payment_t CASCADE;
CREATE TABLE public.payment_t(
	invoice_number char(6) NOT NULL,
	customer_id char(6) NOT NULL,
	total_discount decimal(5,2),
	substotal decimal(5,2) NOT NULL,
	"HST (13%)" decimal(5,2) NOT NULL,
	total decimal(5,2) NOT NULL,
	CONSTRAINT payment_t_pk PRIMARY KEY (invoice_number,customer_id)

);
-- ddl-end --
ALTER TABLE public.payment_t OWNER TO postgres;
-- ddl-end --

-- object: "FK_customer_id" | type: CONSTRAINT --
-- ALTER TABLE public.invoice_t DROP CONSTRAINT IF EXISTS "FK_customer_id" CASCADE;
ALTER TABLE public.invoice_t ADD CONSTRAINT "FK_customer_id" FOREIGN KEY (customer_id)
REFERENCES public.customer_t (customer_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_invoice_number" | type: CONSTRAINT --
-- ALTER TABLE public.serves_terms_t DROP CONSTRAINT IF EXISTS "FK_invoice_number" CASCADE;
ALTER TABLE public.serves_terms_t ADD CONSTRAINT "FK_invoice_number" FOREIGN KEY ("invoice-number")
REFERENCES public.invoice_t (invoice_number) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK1_invoice_number" | type: CONSTRAINT --
-- ALTER TABLE public.invoice_line_t DROP CONSTRAINT IF EXISTS "FK1_invoice_number" CASCADE;
ALTER TABLE public.invoice_line_t ADD CONSTRAINT "FK1_invoice_number" FOREIGN KEY (invoice_number)
REFERENCES public.invoice_t (invoice_number) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK2_item_code" | type: CONSTRAINT --
-- ALTER TABLE public.invoice_line_t DROP CONSTRAINT IF EXISTS "FK2_item_code" CASCADE;
ALTER TABLE public.invoice_line_t ADD CONSTRAINT "FK2_item_code" FOREIGN KEY (item_code)
REFERENCES public.product_t (item_code) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK1_invoice_number" | type: CONSTRAINT --
-- ALTER TABLE public.payment_t DROP CONSTRAINT IF EXISTS "FK1_invoice_number" CASCADE;
ALTER TABLE public.payment_t ADD CONSTRAINT "FK1_invoice_number" FOREIGN KEY (invoice_number)
REFERENCES public.invoice_t (invoice_number) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK2_customer_id" | type: CONSTRAINT --
-- ALTER TABLE public.payment_t DROP CONSTRAINT IF EXISTS "FK2_customer_id" CASCADE;
ALTER TABLE public.payment_t ADD CONSTRAINT "FK2_customer_id" FOREIGN KEY (customer_id)
REFERENCES public.customer_t (customer_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


