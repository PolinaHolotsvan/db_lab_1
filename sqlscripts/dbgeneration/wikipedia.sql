CREATE TABLE "login_data_external"
(
    "login_data_external_id"  UUID PRIMARY KEY,
    "external_provider"       varchar,
    "external_provider_token" varchar
);


CREATE TABLE "user"
(
    "user_id"                UUID PRIMARY KEY,
    "name"                   varchar,
    "username"               varchar,
    "login_data_external_id" UUID,
    "login_data_id"          UUID,
    FOREIGN KEY ("login_data_external_id") REFERENCES "login_data_external" ("login_data_external_id")
);

CREATE TABLE "login_data"
(
    "login_data_id"           UUID PRIMARY KEY,
    "email"                   varchar,
    "password"                varchar,
    "email_validation_status" boolean
);

CREATE TABLE "visitor"
(
    "visitor_id" UUID PRIMARY KEY
);

CREATE TABLE "admin"
(
    "admin_id" UUID PRIMARY KEY
);

CREATE TABLE "admin_article"
(
    "admin_article_id" UUID PRIMARY KEY,
    "admin_id"         UUID,
    "article_id"       integer
);

CREATE TABLE "article"
(
    "article_id" integer PRIMARY KEY,
    "name"       varchar,
    "text"       varchar
);

CREATE TABLE "article_change_history"
(
    "change_id"   integer PRIMARY KEY,
    "article_id"  integer,
    "change_time" timestamp
);

CREATE TABLE "comment"
(
    "comment_id"  UUID PRIMARY KEY,
    "user_id"     UUID,
    "article_id"  integer,
    "parent_id"   UUID,
    "description" varchar,
    FOREIGN KEY ("parent_id") REFERENCES "comment" ("comment_id")
);

CREATE TABLE "term_change_history"
(
    "change_id"   integer PRIMARY KEY,
    "term_id"     integer,
    "change_time" timestamp
);

CREATE TABLE "term"
(
    "term_id"     integer PRIMARY KEY,
    "name"        varchar,
    "description" varchar
);

CREATE TABLE "order"
(
    "order_id" integer PRIMARY KEY,
    "term_id"  integer
);

CREATE TABLE "family"
(
    "family_id" integer PRIMARY KEY,
    "term_id"   integer,
    "order_id"  integer
);

CREATE TABLE "genus"
(
    "genus_id"  integer PRIMARY KEY,
    "term_id"   integer,
    "family_id" integer
);

CREATE TABLE "species"
(
    "species_id" integer PRIMARY KEY,
    "term_id"    integer,
    "genus_id"   integer
);

COMMENT ON COLUMN "comment"."parent_id" IS 'Case of reply';

ALTER TABLE "visitor"
    ADD FOREIGN KEY ("visitor_id") REFERENCES "user" ("user_id");

ALTER TABLE "admin"
    ADD FOREIGN KEY ("admin_id") REFERENCES "user" ("user_id");

ALTER TABLE "admin_article"
    ADD FOREIGN KEY ("admin_id") REFERENCES "admin" ("admin_id");

ALTER TABLE "admin_article"
    ADD FOREIGN KEY ("article_id") REFERENCES "article" ("article_id");

ALTER TABLE "species"
    ADD FOREIGN KEY ("genus_id") REFERENCES "genus" ("genus_id");

ALTER TABLE "genus"
    ADD FOREIGN KEY ("family_id") REFERENCES "family" ("family_id");

ALTER TABLE "family"
    ADD FOREIGN KEY ("order_id") REFERENCES "order" ("order_id");

ALTER TABLE "user"
    ADD FOREIGN KEY ("login_data_id") REFERENCES "login_data" ("login_data_id");

ALTER TABLE "comment"
    ADD FOREIGN KEY ("user_id") REFERENCES "user" ("user_id");

ALTER TABLE "comment"
    ADD FOREIGN KEY ("article_id") REFERENCES "article" ("article_id");

ALTER TABLE "article_change_history"
    ADD FOREIGN KEY ("article_id") REFERENCES "article" ("article_id");

ALTER TABLE "term_change_history"
    ADD FOREIGN KEY ("term_id") REFERENCES "term" ("term_id");

ALTER TABLE "species"
    ADD FOREIGN KEY ("term_id") REFERENCES "term" ("term_id");

ALTER TABLE "genus"
    ADD FOREIGN KEY ("term_id") REFERENCES "term" ("term_id");

ALTER TABLE "family"
    ADD FOREIGN KEY ("term_id") REFERENCES "term" ("term_id");

ALTER TABLE "order"
    ADD FOREIGN KEY ("term_id") REFERENCES "term" ("term_id");
