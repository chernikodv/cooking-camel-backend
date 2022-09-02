-- noinspection SqlCurrentSchemaInspectionForFile

-- -----------------------------------------------------
-- Schema cooking_camel_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS cooking_camel_schema;

SET search_path TO cooking_camel_schema;

CREATE TABLE IF NOT EXISTS "cooking_camel_schema".Users (
    username TEXT PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    type INTEGER NOT NULL CHECK (type in (0, 1)),
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "cooking_camel_schema".Recipes (
    recipe_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    title TEXT NOT NULL UNIQUE,
    source TEXT NOT NULL,
    link TEXT NOT NULL,
    detail_ingredients TEXT NOT NULL,
    detail_steps TEXT NOT NULL,
    owner_user_id TEXT REFERENCES Users(username)
);

CREATE TABLE IF NOT EXISTS "cooking_camel_schema".Favorites (
    username TEXT REFERENCES Users(username),
    recipe_id INTEGER REFERENCES Recipes(recipe_id),
    PRIMARY KEY(username, recipe_id)
);

CREATE TABLE IF NOT EXISTS "cooking_camel_schema".Ingredients (
    ingredient_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS "cooking_camel_schema".RecipeIngredients (
    recipe_id INTEGER REFERENCES Recipes(recipe_id),
    ingredient_id INTEGER REFERENCES Ingredients(ingredient_id),
    PRIMARY KEY(recipe_id, ingredient_id)
);

COMMIT;