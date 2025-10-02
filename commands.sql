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

INSERT INTO
    users (name, password, email)
VALUES
    ('Ricardo', '123456789', 'ricardo@mail.com');

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

INSERT INTO
    courses (slug, title, description, lessons, hours)
VALUES
    (
        'javascript-basico',
        'JavaScript Básico',
        'Aprenda os fundamentos',
        20,
        5
    );

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

INSERT INTO
    lessons (
        course_id,
        slug,
        title,
        materia,
        materia_slug,
        seconds,
        video,
        description,
        lesson_order,
        free
    )
VALUES
    (
        1,
        'variaveis-let-const',
        'Variáveis: let e const',
        'Fundamentos',
        'fundamentos',
        480,
        'variaveis.mp4',
        'Entenda a diferença entre let, const e var',
        1,
        1
    );

CREATE TABLE
    lessons_completed (
        user_id INTEGER NOT NULL,
        course_id INTEGER NOT NULL,
        lesson_id INTEGER NOT NULL,
        completed TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (user_id, course_id, lesson_id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (course_id) REFERENCES courses (id),
        FOREIGN KEY (lesson_id) REFERENCES lessons (id)
    ) STRICT;

INSERT INTO
    lessons_completed (user_id, course_id, lesson_id)
VALUES
    (1, 1, 1);

CREATE TABLE
    certificates (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        course_id INTEGER NOT NULL,
        completed TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (user_id, course_id),
        FOREIGN KEY (course_id) REFERENCES courses (id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    ) STRICT;

INSERT INTO
    certificates (id, user_id, course_id)
VALUES
    ('8alldDelk0', 1, 1);

------ OPERADORES ------
CREATE TABLE
    "produtos" (
        "id" INTEGER PRIMARY KEY,
        "nome" TEXT NOT NULL,
        "categoria" TEXT,
        "preco" INTEGER NOT NULL,
        "taxa_importacao" INTEGER NOT NULL DEFAULT 0,
        "estoque" INTEGER NOT NULL DEFAULT 0,
        "lancamento" INTEGER DEFAULT 1 CHECK ("lancamento" IN (0, 1)),
        "criado" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
    ) STRICT;

INSERT INTO
    "produtos" (
        "nome",
        "categoria",
        "preco",
        "taxa_importacao",
        "estoque",
        "lancamento",
        "criado"
    )
VALUES
    (
        'Fone Bluetooth',
        'audio',
        19900,
        0,
        150,
        0,
        '2048-01-16 10:12:34'
    ),
    (
        'Teclado Mecânico',
        'periferico',
        34900,
        6500,
        20,
        0,
        '2048-02-02 09:45:10'
    ),
    (
        'Mouse Gamer Pro',
        'periferico',
        24900,
        0,
        120,
        0,
        '2048-02-21 14:05:28'
    ),
    (
        'Monitor 27 4K',
        'monitor',
        219900,
        9000,
        40,
        0,
        '2048-03-06 11:23:57'
    ),
    (
        'Hub USB-C',
        'acessorio',
        9900,
        0,
        200,
        0,
        '2048-03-11 08:47:13'
    ),
    (
        'Webcam 1080p',
        'video',
        17900,
        3500,
        110,
        0,
        '2048-04-01 16:32:40'
    ),
    (
        'SSD NVMe 1TB',
        'armazenamento',
        57900,
        0,
        70,
        0,
        '2048-04-19 13:21:05'
    ),
    (
        'Cadeira Ergonômica',
        null,
        139900,
        12000,
        0,
        0,
        '2048-05-03 09:14:22'
    ),
    (
        'Notebook 14 1TB',
        'notebook',
        429900,
        0,
        30,
        0,
        '2048-05-16 10:55:31'
    ),
    (
        'Ring Light LED',
        null,
        8900,
        0,
        5,
        0,
        '2049-06-02 12:06:09'
    ),
    (
        'Smartwatch',
        null,
        79900,
        8000,
        90,
        0,
        '2049-06-21 15:44:18'
    ),
    (
        'Carregador GaN',
        'energia',
        15900,
        0,
        140,
        0,
        '2049-07-06 11:12:47'
    ),
    (
        'Notebook 16 2TB',
        'notebook',
        529900,
        0,
        37,
        0,
        '2049-05-16 10:55:31'
    ),
    (
        'Power Bank 20000 mAh',
        'energia',
        22900,
        0,
        130,
        1,
        '2049-07-23 17:03:59'
    ),
    (
        'Óculos 3D Pro',
        'acessorio',
        21900,
        0,
        110,
        1,
        '2049-07-26 17:03:59'
    ),
    (
        'Headset ANC Pro',
        'audio',
        99900,
        11000,
        60,
        1,
        '2049-08-11 10:28:36'
    ),
    (
        'Placa-mãe Z790',
        'hardware',
        189900,
        0,
        35,
        1,
        '2049-09-02 09:49:52'
    ),
    (
        'Processador X9-5600',
        'hardware',
        159900,
        9500,
        50,
        0,
        '2049-09-19 14:17:08'
    ),
    (
        'Processador X11-5600',
        'hardware',
        199900,
        9500,
        50,
        0,
        '2049-10-01 14:17:08'
    ),
    (
        'Impressora 3D Mini',
        'impressora',
        249900,
        0,
        20,
        0,
        '2049-10-06 08:38:41'
    ),
    (
        'Alto-falante WiFi Pro',
        'audio',
        34900,
        0,
        100,
        0,
        '2049-11-02 16:25:55'
    ),
    (
        'Câmera de Ação 4K',
        'video',
        89900,
        7000,
        45,
        0,
        '2049-11-21 13:56:12'
    ),
    (
        'Roteador WiFi 6E',
        'rede',
        64900,
        0,
        75,
        0,
        '2049-12-06 11:11:11'
    );

-- operadores --
SELECT
    *
FROM
    "produtos"
WHERE
    "preco" < 50000;

SELECT
    *
FROM
    "produtos"
WHERE
    "lancamento" != 0;

SELECT
    *
FROM
    "produtos"
WHERE
    ("preco" + "taxa_importacao") < 40000;

SELECT
    *
FROM
    "produtos"
WHERE
    "id" = 3;

-- Datas --
SELECT
    *
FROM
    "produtos"
WHERE
    "criado" > '2049';

SELECT
    *
FROM
    "produtos"
WHERE
    "criado" > '2049-08';

SELECT
    "nome",
    "criado"
FROM
    "produtos"
WHERE
    "criado" > '2049-08-03';

-- erro, ele vai ignorar -3. Tem que ser DD
SELECT
    "nome",
    "criado"
FROM
    "produtos"
WHERE
    "criado" > '2049-08-3';

-- Textos --
SELECT
    *
FROM
    "produtos"
WHERE
    "nome" = 'Impressora 3D Mini';

SELECT
    *
FROM
    "produtos"
WHERE
    "nome" = 'ImpressorA 3D Mini';

-- não encontra
SELECT
    *
FROM
    "produtos"
WHERE
    "nome" = 'ImpressorA 3D Mini' COLLATE NOCASE;

-- IS / IS NOT --
SELECT
    *
FROM
    "produtos"
WHERE
    "categoria" IS NULL;

SELECT
    *
FROM
    "produtos"
WHERE
    "categoria" IS NOT NULL;

SELECT
    *
FROM
    "produtos"
WHERE
    "lancamento" IS TRUE;

SELECT
    *
FROM
    "produtos"
WHERE
    "lancamento" IS FALSE;

-- Like --
SELECT
    *
FROM
    produtos
WHERE
    nome LIKE 'impressora 3d mini';

-- NOT LIKE --
SELECT
    *
FROM
    produtos
WHERE
    nome NOT LIKE 'impressora 3d mini';

-- Wildcard --
SELECT
    *
FROM
    produtos
WHERE
    nome LIKE 'notebook%';

SELECT
    *
FROM
    produtos
WHERE
    nome LIKE '%pro';

SELECT
    *
FROM
    produtos
WHERE
    nome LIKE '%3d%';

SELECT
    *
FROM
    produtos
WHERE
    nome LIKE '% _tb';

-- BETWEEN e IN
SELECT
    *
FROM
    produtos
WHERE
    preco BETWEEN 10000 AND 20000;

SELECT
    *
FROM
    produtos
WHERE
    criado BETWEEN '2049-06' AND '2049-08';

SELECT
    *
FROM
    produtos
where
    criado NOT BETWEEN '2049-06' AND '2049-08';

SELECT
    *
FROM
    produtos
WHERE
    categoria IN ('notebook', 'hardware');

SELECT
    *
FROM
    produtos
WHERE
    categoria NOT IN ('notebook', 'hardware');

SELECT
    *
FROM
    produtos
WHERE
    id IN (1, 5, 7);

select
    *
FROM
    produtos
where
    id NOT IN (1, 5, 7);

-- Funções --
SELECT
    COUNT(*)
FROM
    produtos;

SELECT
    COUNT()
FROM
    produtos;

SELECT
    COUNT(categoria)
FROM
    produtos;

-- AS para renomear colunas --
SELECT
    SUM(estoque) as total_estoque
from
    produtos;

SELECT
    SUM(preco * estoque) AS valor_total_estoque
FROM
    produtos;

SELECT
    ROUND(AVG(preco)) AS media_preco
FROM
    produtos;

SELECT
    MIN(preco) AS produto_barato,
    *
from
    produtos;

SELECT
    MAX(preco) AS produto_barato,
    *
from
    produtos;

-- TEXTO --
SELECT
    LENGTH(nome),
    nome
FROM
    produtos;

SELECT
    UPPER(nome)
FROM
    produtos;

SELECT
    LOWER(nome)
FROM
    produtos;

SELECT
    SUBSTR(nome, 1, 5)
FROM
    produtos;

-- pega os 5 primeiros caracteres
SELECT
    TRIM(nome)
FROM
    produtos;

-- FUNÇÕES data e hora
SELECT
    DATE('now');

SELECT
    TIME('now');

SELECT
    TIME('now', '-03:00');

SELECT
    TIME('now', 'localtime');

SELECT
    DATETIME('now', '-03:00');

SELECT
    CURRENT_TIMESTAMP;

SELECT
    STRFTIME('%Y-%m-%d %H:%M', 'now');

-- Cálculo de datas --
SELECT
    DATE('now', '+1 day');

SELECT
    DATE('now', '-1 month');

SELECT
    DATETIME('now', '+1 day', '-6 hours');

SELECT
    DATE('2049-06-16', '+7 days');

SELECT
    TIME('12:00', '+90 minutes');

SELECT
    *
FROM
    produtos
WHERE
    criado BETWEEN DATE('2049-01-01') AND DATE('2049-01-01', '+6 month');

CREATE TABLE
    livros (
        id INTEGER PRIMARY KEY,
        nome TEXT NOT NULL,
        criado TEXT NOT NULL DEFAULT (STRFTIME('%Y-%m-%d', 'now'))
    ) STRICT;

INSERT INTO
    livros (nome)
VALUES
    (TRIM(' APRENDENDO SQL  ')),
    (TRIM('Avançando em SQL   '));

SELECT
    nome,
    LENGTH(nome) AS tamanho_nome
FROM
    livros
WHERE
    tamanho_nome > 15;

-- ORDER BY --
SELECT
    *
FROM
    produtos
ORDER BY
    preco ASC;

SELECT
    *
FROM
    produtos
ORDER BY
    preco DESC;

SELECT
    *
FROM
    produtos
ORDER BY
    categoria ASC,
    preco ASC;

SELECT
    *
FROM
    produtos
ORDER BY
    criado DESC;

-- GROUP BY --
SELECT
    categoria,
    COUNT(*) AS total
FROM
    produtos
GROUP BY
    categoria;

SELECT
    categoria,
    AVG(preco) AS preco_medio
FROM
    produtos
GROUP BY
    categoria;

SELECT
    categoria,
    COUNT(*) AS total
FROM
    produtos
GROUP BY
    categoria
ORDER BY
    total DESC;

-- HAVING --
SELECT
    categoria,
    COUNT(*) AS total
FROM
    produtos
GROUP BY
    categoria
HAVING
    total > 1;

SELECT
    categoria,
    AVG(preco) AS preco_medio
FROM
    produtos
GROUP BY
    categoria
HAVING
    preco_medio > 70000;

-- SUBQUERY --
SELECT * FROM produtos WHERE preco > (SELECT AVG(preco) FROM produtos);
SELECT * FROM lessons WHERE course_id = (SELECT id FROM courses WHERE slug = 'javascript-basico');

-- WITH AS --
WITH preco_medio AS (
    SELECT AVG(preco) AS media FROM produtos
)
SELECT * FROM produtos WHERE preco > (SELECT media FROM preco_medio); 
