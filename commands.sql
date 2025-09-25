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

SELECT * FROM compras WHERE client_id = 2;
