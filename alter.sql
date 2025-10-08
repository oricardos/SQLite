-- database: ./db.sqlite
CREATE TABLE users2 (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role TEXT DEFAULT 'user',
    created INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
) STRICT;

ALTER TABLE users2 RENAME COLUMN "e-mail" TO email;
ALTER TABLE users2 DROP COLUMN role;
ALTER TABLE users2 ADD ads INTEGER;
ALTER TABLE users2 RENAME TO users_old;

SELECT * FROM sqlite_schema;