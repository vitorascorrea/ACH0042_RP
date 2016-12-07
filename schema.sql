CREATE TABLE authors
(
  author_code character(10) NOT NULL,
  author_name character varying(60) NOT NULL,
  lobby_index integer,
  google_h_index integer,
  prod_bag character varying(50),
  CONSTRAINT authors_pkey PRIMARY KEY (author_code)
)

CREATE TABLE co_authors
(
  main_author_code character(10),
  co_author_code character(10) NOT NULL,
  co_author_name character varying(60) NOT NULL,
  num_articles integer NOT NULL,
  CONSTRAINT co_authors_main_author_code_fkey FOREIGN KEY (main_author_code)
      REFERENCES authors (author_code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
