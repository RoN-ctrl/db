-- Database: learnDB

DROP DATABASE IF EXISTS "learnDB";

CREATE DATABASE "learnDB"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Table: public.students

DROP TABLE IF EXISTS public.students;

CREATE TABLE IF NOT EXISTS public.students
(
    student_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    surname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    date_of_birth date,
    phone_number integer,
    primary_skill character varying(255) COLLATE pg_catalog."default",
    created_datetime timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_datetime timestamp without time zone,
    CONSTRAINT students_pkey PRIMARY KEY (student_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.students
    OWNER to postgres;

-- Index: index_date_of_birth

DROP INDEX IF EXISTS public.index_date_of_birth;

CREATE INDEX IF NOT EXISTS index_date_of_birth
    ON public.students USING hash
    (date_of_birth)
    TABLESPACE pg_default;

-- Index: index_name

DROP INDEX IF EXISTS public.index_name;

CREATE INDEX IF NOT EXISTS index_name
    ON public.students USING btree
    (name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
	
DROP TRIGGER IF EXISTS trigger_updated_datetime ON public.students;
DROP FUNCTION IF EXISTS public.function_current_datetime();

-- FUNCTION: public.function_current_datetime()

CREATE OR REPLACE FUNCTION public.function_current_datetime()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
    UPDATE students SET updated_datetime=CURRENT_TIMESTAMP WHERE student_id=NEW.student_id;
    RETURN NEW;
END;
$BODY$;

ALTER FUNCTION public.function_current_datetime()
    OWNER TO postgres;

-- Trigger: trigger_updated_datetime

CREATE TRIGGER trigger_updated_datetime
    AFTER UPDATE 
    ON public.students
    FOR EACH ROW
    WHEN (pg_trigger_depth() < 1)
    EXECUTE FUNCTION public.function_current_datetime();
	
-- Table: public.subjects

DROP TABLE IF EXISTS public.subjects;

CREATE TABLE IF NOT EXISTS public.subjects
(
    subject_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    subject_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    tutor character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT subjects_pkey PRIMARY KEY (subject_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.subjects
    OWNER to postgres;
	
-- Table: public.exam_results

DROP TABLE IF EXISTS public.exam_results;

CREATE TABLE IF NOT EXISTS public.exam_results
(
    result_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    student_id integer NOT NULL,
    subject_id integer NOT NULL,
    result integer NOT NULL DEFAULT 1,
    CONSTRAINT exam_results_pkey PRIMARY KEY (result_id),
    CONSTRAINT fk_student_id FOREIGN KEY (student_id)
        REFERENCES public.students (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_subject_id FOREIGN KEY (subject_id)
        REFERENCES public.subjects (subject_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.exam_results
    OWNER to postgres;