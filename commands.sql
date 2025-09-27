-- database: ./db.sqlite
-- criar tabela com os dados das colunas
CREATE TABLE
    cursos (
        id INTEGER NOT NULL,
        nome TEXT NOT NULL,
        aulas INTEGER
    );

-- excluir tabela
DROP TABLE cursos;

-- mostrar informações da tabela
PRAGMA TABLE_INFO ('cursos');

-- inserir registros na tabela
INSERT INTO
    cursos (id, nome, aulas)
VALUES
    (1, 'React', 40),
    (2, 'C# e .NET', 35),
    (3, 'HTML', 50);

-- deleta TODAS as linhas da tabela
DELETE FROM cursos;

-- deletas as linhas mas com condição
DELETE FROM cursos
WHERE
    id = 2;

-- selecionar todos os dados da tabela
SELECT
    *
FROM
    cursos;

-- seleciona os dados a partir das colunas escolhidas
SELECT
    "nome"
FROM
    cursos;

-- seleciona mas com condição 
SELECT
    *
FROM
    cursos
WHERE
    "aulas" > 35;

-- combinando condições
SELECT
    *
FROM
    cursos
WHERE
    "aulas" > 35
    AND "id" < 3;

-- update
UPDATE cursos
SET
    "nome" = 'HTML & CSS'
WHERE
    "nome" = 'HTML';

-------------- EXERCÍCIO 1 ----------------------
CREATE TABLE
    produtos (
        id INTEGER NOT NULL,
        nome TEXT NOT NULL,
        preco INTEGER NOT NULL
    );

CREATE TABLE
    clientes (
        id INTEGER NOT NULL,
        nome TEXT NOT NULL,
        email TEXT NOT NULL
    );

CREATE TABLE
    compras (
        id INTEGER NOT NULL,
        client_id INTEGER NOT NULL,
        produto_id INTEGER NOT NULL,
        data TEXT NOT NULL
    );

INSERT INTO
    produtos (id, nome, preco)
VALUES
    (1, 'Notebook', 1000),
    (2, 'Smartphone', 500),
    (3, 'Tablet', 300);

INSERT INTO
    clientes (id, nome, email)
VALUES
    (1, 'Maria', 'maria@email.com'),
    (2, 'José', 'jose@email.com');

INSERT INTO
    compras (id, client_id, produto_id, data)
VALUES
    (1, 2, 1, '2025-09-24'),
    (2, 1, 2, '2025-09-24'),
    (3, 2, 3, '2025-09-24');

SELECT
    *
FROM
    produtos;

SELECT
    "nome"
FROM
    produtos
WHERE
    "preco" > 400;

SELECT
    *
FROM
    compras
WHERE
    client_id = 2;

-- SEÇÃO 3 SCHEMA
CREATE TABLE
    produtos (
        "id" INT,
        "descontinuado" TINYINT,
        "nome" VARCHAR(100),
        "preco" DECIMAL(10, 2),
        "descricao" TEXT,
        "data_criacao" DATETIME
    );

INSERT INTO
    produtos (
        id,
        descontinuado,
        nome,
        preco,
        descricao,
        data_criacao
    )
VALUES
    (
        1,
        1,
        'Tablet',
        288.90,
        'Tablet Xiaomi',
        '25-09-2025'
    );

-- verificacao de tipo
SELECT
    id,
    typeof(data_criacao)
FROM
    produtos;

-- strict mode
CREATE TABLE
    cursos (id INTEGER, nome Text, preco INTEGER) STRICT;

INSERT INTO
    cursos (id, nome, preco)
VALUES
    (1, 'Televisão', 1000);

DROP TABLE cursos;

-- primary key (PK)
CREATE TABLE
    cursos (id INTEGER PRIMARY KEY, nome TEXT) STRICT;

INSERT INTO
    cursos (nome, preco)
VALUES
    ('API com .NET', 2000);

-- Foreing Key (FK)
PRAGMA foreign_keys;

CREATE TABLE
    aulas (
        id INTEGER PRIMARY KEY,
        curso_id INTEGER,
        nome TEXT,
        FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE ON UPDATE CASCADE
    ) STRICT;

INSERT INTO
    cursos (nome)
VALUES
    ('C#');

INSERT INTO
    aulas (curso_id, nome)
VALUES
    (1, 'Iniciando');

-- restrições
DROP TABLE usuario;

CREATE TABLE
    usuario (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        email TEXT NOT NULL COLLATE NOCASE UNIQUE,
        tipo TEXT NOT NULL DEFAULT 'usuario' CHECK (tipo IN ('usuario', 'admin')),
        vitalicio INTEGER DEFAULT 0 CHECK (vitalicio IN (0, 1)),
        criado TEXT DEFAULT CURRENT_TIMESTAMP
    ) STRICT;

CREATE TABLE
    certificados (
        id INTEGER PRIMARY KEY,
        usuario_id INTEGER NOT NULL,
        curso_id INTEGER NOT NULL,
        UNIQUE (usuario_id, curso_id)
    ) STRICT;

INSERT INTO
    usuario (nome, email, tipo, vitalicio)
VALUES
    ('Ricardo', 'rsicsardoss@mail.com', 'usuario', 0);

INSERT INTO
    certificados (usuario_id, curso_id)
VALUES
    (1, 1);

-- Default (ver tabela anterior)
-- MODELAGEM DE DADOS (ver Readme)
-------------- EXERCÍCIO 2 ----------------------
CREATE TABLE
    users (
        id INTEGER PRIMARY KEY, --x NOT NULL
        name TEXT NOT NULL,
        password TEXT NOT NULL,
        email TEXT NOT NULL COLLATE NOCASE UNIQUE, --COLLATE NOCASE UNIQUE
        created TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP -- NOT NULL
    ) STRICT;

CREATE TABLE
    courses (
        id INTEGER PRIMARY KEY, --xNOT NULL
        slug TEXT NOT NULL COLLATE NOCASE UNIQUE, --COLLATE NOCASE
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        lessons INTEGER NOT NULL,
        hours INTEGER NOT NULL,
        created TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) STRICT;

CREATE TABLE
    lessons (
        id INTEGER PRIMARY KEY, --x NOT NULL
        course_id INTEGER NOT NULL,
        slug TEXT NOT NULL COLLATE NOCASE, --COLLATE NOCASE  xUNIQUE
        title TEXT NOT NULL,
        materia TEXT NOT NULL,
        materia_slug TEXT NOT NULL,
        seconds INTEGER NOT NULL,
        video TEXT NOT NULL,
        description TEXT NOT NULL,
        lesson_order INTEGER NOT NULL,
        free INTEGER NOT NULL DEFAULT 0 CHECK (free IN (0, 1)),
        created TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (course_id) REFERENCES courses (id), --
        UNIQUE (course_id, slug) --
    ) STRICT;

CREATE TABLE lessons_completed (
  user_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  lesson_id INTEGER NOT NULL,
  completed TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, course_id, lesson_id),
  FOREIGN KEY (lesson_id) REFERENCES lessons (id),
  FOREIGN KEY (course_id) REFERENCES courses (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) STRICT;

CREATE TABLE certificates (
  id TEXT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  completed TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (user_id, course_id),
  FOREIGN KEY (course_id) REFERENCES courses (id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) STRICT;