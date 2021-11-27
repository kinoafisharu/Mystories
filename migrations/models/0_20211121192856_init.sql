-- upgrade --
CREATE TABLE IF NOT EXISTS "categories_of_story" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(50) NOT NULL,
    "published" BOOL NOT NULL  DEFAULT True,
    "description" TEXT NOT NULL,
    "parent_id" INT REFERENCES "categories_of_story" ("id") ON DELETE CASCADE
);
COMMENT ON TABLE "categories_of_story" IS 'Категории историй ';
CREATE TABLE IF NOT EXISTS "tags" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(50)  UNIQUE
);
COMMENT ON TABLE "tags" IS 'Модель тэгов ';
CREATE TABLE IF NOT EXISTS "users" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "nickname" VARCHAR(40) NOT NULL,
    "email" VARCHAR(100) NOT NULL UNIQUE,
    "password_hash" VARCHAR(1000) NOT NULL,
    "first_name" VARCHAR(100) NOT NULL,
    "last_name" VARCHAR(100),
    "birthdate" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "is_active" BOOL NOT NULL  DEFAULT True,
    "created_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "modified_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "avatar" VARCHAR(100),
    CONSTRAINT "uid_users_nicknam_191aa9" UNIQUE ("nickname", "email")
);
CREATE INDEX IF NOT EXISTS "idx_users_nicknam_b32a63" ON "users" ("nickname");
COMMENT ON TABLE "users" IS 'Модель пользователя';
CREATE TABLE IF NOT EXISTS "posts" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "title" VARCHAR(500) NOT NULL,
    "mini_text" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "create_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "publish_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "image" VARCHAR(500),
    "is_published" BOOL NOT NULL  DEFAULT True,
    "author_id" INT NOT NULL REFERENCES "users" ("id") ON DELETE CASCADE,
    "category_id" INT REFERENCES "categories_of_story" ("id") ON DELETE SET NULL
);
COMMENT ON TABLE "posts" IS 'Модель историй ';
CREATE TABLE IF NOT EXISTS "comments" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "text" TEXT NOT NULL,
    "create_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "update_at" TIMESTAMPTZ NOT NULL  DEFAULT CURRENT_TIMESTAMP,
    "is_published" BOOL NOT NULL  DEFAULT True,
    "is_deleted" BOOL NOT NULL  DEFAULT False,
    "parent_id" INT REFERENCES "comments" ("id") ON DELETE SET NULL,
    "post_id" INT NOT NULL REFERENCES "posts" ("id") ON DELETE CASCADE,
    "user_id" INT NOT NULL REFERENCES "users" ("id") ON DELETE CASCADE
);
COMMENT ON TABLE "comments" IS 'Comment class ';
CREATE TABLE IF NOT EXISTS "aerich" (
    "id" SERIAL NOT NULL PRIMARY KEY,
    "version" VARCHAR(255) NOT NULL,
    "app" VARCHAR(20) NOT NULL,
    "content" JSONB NOT NULL
);
CREATE TABLE IF NOT EXISTS "post_tag" (
    "posts_id" INT NOT NULL REFERENCES "posts" ("id") ON DELETE CASCADE,
    "tag_id" INT NOT NULL REFERENCES "tags" ("id") ON DELETE CASCADE
);
