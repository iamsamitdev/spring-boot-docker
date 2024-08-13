drop table if exists public.book CASCADE;
DROP TABLE IF EXISTS public.author CASCADE;

CREATE TABLE IF NOT EXISTS public.author
(
    id        serial primary key,
    firstname character varying(255) COLLATE pg_catalog."default",
    lastname  character varying(255) COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.book
(
    id          serial primary key,
    description text,
    isbn        character varying(255) COLLATE pg_catalog."default",
    page        integer          NOT NULL,
    price       double precision NOT NULL,
    title       character varying(100) COLLATE pg_catalog."default",
    author_id   integer          not null references public.author (id)
);