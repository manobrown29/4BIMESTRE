/*
1. Exibir lista de alunos e seus cursos
Crie uma view que mostre o nome dos alunos e as disciplinas em que estão matriculados, incluindo o nome do curso.
*/

CREATE VIEW view_alunos_cursos AS
SELECT
    a.nome AS nome_aluno,
    c.nome AS nome_curso,
    d.nome AS nome_disciplina
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
INNER JOIN
    disciplina d ON m.id_disciplina = d.id_disciplina
INNER JOIN
    curso c ON d.id_curso = c.id_curso;
    
/*
2. Exibir total de alunos por disciplina
Crie uma view que mostre o nome das disciplinas e a quantidade de alunos matriculados em cada uma.
*/


CREATE VIEW view_total_alunos_por_disciplina AS
SELECT
    d.nome AS nome_disciplina,
    COUNT(m.id_aluno) AS total_alunos
FROM
    disciplina d
LEFT JOIN
    matricula m ON d.id_disciplina = m.id_disciplina
GROUP BY
    d.nome;
    
/*
3. Exibir alunos e status das suas matrículas
Crie uma view que mostre o nome dos alunos, suas disciplinas e o status da matrícula (Ativo, Concluído, Trancado).
*/

CREATE VIEW view_alunos_status_matriculas AS
SELECT
    a.nome AS nome_aluno,
    d.nome AS nome_disciplina,
    m.status AS status_matricula
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
INNER JOIN
    disciplina d ON m.id_disciplina = d.id_disciplina;
    
/*
4. Exibir professores e suas turmas
Crie uma view que mostre o nome dos professores e as disciplinas que eles lecionam, com os horários das turmas.
*/

CREATE VIEW view_professores_turmas AS
SELECT
    p.nome AS nome_professor,
    d.nome AS nome_disciplina,
    t.horario AS horario_turma
FROM
    professor p
INNER JOIN
    turma t ON p.id_professor = t.id_professor
INNER JOIN
    disciplina d ON t.id_disciplina = d.id_disciplina;

/*
5. Exibir alunos maiores de 20 anos
Crie uma view que exiba o nome e a data de nascimento dos alunos que têm mais de 20 anos.
*/

CREATE VIEW view_alunos_maiores_20 AS
SELECT
    nome,
    data_nascimento
FROM
    aluno
WHERE
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) > 20;


/*
6. Exibir disciplinas e carga horária total por curso
Crie uma view que exiba o nome dos cursos, a quantidade de disciplinas associadas e a carga horária total de cada curso.
*/

CREATE VIEW view_disciplinas_carga_por_curso AS
SELECT
    c.nome AS nome_curso,
    COUNT(d.id_disciplina) AS quantidade_disciplinas,
    SUM(c.carga_horaria) AS carga_horaria_total
FROM
    curso c
LEFT JOIN
    disciplina d ON c.id_curso = d.id_curso
GROUP BY
    c.nome;

/*
7. Exibir professores e suas especialidades
Crie uma view que exiba o nome dos professores e suas especialidades.
*/

CREATE VIEW view_professores_especialidades AS
SELECT
    nome AS nome_professor,
    especialidade
FROM
    professor;

/*
8. Exibir alunos matriculados em mais de uma disciplina
Crie uma view que mostre os alunos que estão matriculados em mais de uma disciplina.
*/

CREATE VIEW view_alunos_multiplas_disciplinas AS
SELECT
    a.nome AS nome_aluno,
    COUNT(m.id_disciplina) AS total_disciplinas
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
GROUP BY
    a.nome
HAVING
    COUNT(m.id_disciplina) > 1;

/*
9. Exibir alunos e o número de disciplinas que concluíram
Crie uma view que exiba o nome dos alunos e o número de disciplinas que eles concluíram.
*/

CREATE VIEW view_alunos_disciplinas_concluidas AS
SELECT
    a.nome AS nome_aluno,
    COUNT(m.id_disciplina) AS disciplinas_concluidas
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
WHERE
    m.status = 'Concluído'
GROUP BY
    a.nome;

/*
10. Exibir todas as turmas de um semestre específico
Crie uma view que exiba todas as turmas que ocorrem em um determinado semestre (ex.: 2024.1).
*/

CREATE VIEW view_turmas_semestre AS
SELECT
    t.id_turma,
    p.nome AS nome_professor,
    d.nome AS nome_disciplina,
    t.semestre,
    t.horario
FROM
    turma t
INNER JOIN
    professor p ON t.id_professor = p.id_professor
INNER JOIN
    disciplina d ON t.id_disciplina = d.id_disciplina
WHERE
    t.semestre = '2024.1';

/*
11. Exibir alunos com matrículas trancadas
Crie uma view que exiba o nome dos alunos que têm matrículas no status "Trancado".
*/

CREATE VIEW view_alunos_trancados AS
SELECT DISTINCT
    a.nome AS nome_aluno
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
WHERE
    m.status = 'Trancado';

/*
12. Exibir disciplinas que não têm alunos matriculados
Crie uma view que exiba as disciplinas que não possuem alunos matriculados.
*/

CREATE VIEW view_disciplinas_sem_matriculas AS
SELECT
    d.nome AS nome_disciplina
FROM
    disciplina d
LEFT JOIN
    matricula m ON d.id_disciplina = m.id_disciplina
WHERE
    m.id_matricula IS NULL;

/*
13. Exibir a quantidade de alunos por status de matrícula
Crie uma view que exiba a quantidade de alunos para cada status de matrícula (Ativo, Concluído, Trancado).
*/

CREATE VIEW view_quantidade_alunos_por_status AS
SELECT
    m.status AS status_matricula,
    COUNT(DISTINCT m.id_aluno) AS quantidade_alunos
FROM
    matricula m
GROUP BY
    m.status;

/*
14. Exibir o total de professores por especialidade
Crie uma view que exiba a quantidade de professores por especialidade (ex.: Engenharia de Software, Ciência da Computação).
*/

CREATE VIEW view_total_professores_por_especialidade AS
SELECT
    especialidade,
    COUNT(id_professor) AS total_professores
FROM
    professor
GROUP BY
    especialidade;

/*
15. Exibir lista de alunos e suas idades
Crie uma view que exiba o nome dos alunos e suas idades com base na data de nascimento.
*/

CREATE VIEW view_alunos_idades AS
SELECT
    nome AS nome_aluno,
    TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE()) AS idade
FROM
    aluno;

/*
16. Exibir alunos e suas últimas matrículas
Crie uma view que exiba o nome dos alunos e a data de suas últimas matrículas.
*/

CREATE VIEW view_alunos_ultimas_matriculas AS
SELECT
    a.nome AS nome_aluno,
    MAX(m.data_matricula) AS ultima_data_matricula
FROM
    aluno a
INNER JOIN
    matricula m ON a.id_aluno = m.id_aluno
GROUP BY
    a.nome;
    
/*
17. Exibir todas as disciplinas de um curso específico
Crie uma view que exiba todas as disciplinas pertencentes a um curso específico, como "Engenharia de Software".
*/

CREATE VIEW view_disciplinas_por_curso AS
SELECT
    d.nome AS nome_disciplina
FROM
    disciplina d
INNER JOIN
    curso c ON d.id_curso = c.id_curso
WHERE
    c.nome = 'Engenharia de Software';

/*
18. Exibir os professores que não têm turmas
Crie uma view que exiba os professores que não estão lecionando em nenhuma turma.
*/

CREATE VIEW view_professores_sem_turmas AS
SELECT
    p.nome AS nome_professor
FROM
    professor p
LEFT JOIN
    turma t ON p.id_professor = t.id_professor
WHERE
    t.id_turma IS NULL;

/*
19. Exibir lista de alunos com CPF e email
Crie uma view que exiba o nome dos alunos, CPF e email.
*/

CREATE VIEW view_alunos_cpf_email AS
SELECT
    nome AS nome_aluno,
    cpf,
    email
FROM
    aluno;

/*
20. Exibir o total de disciplinas por professor
Crie uma view que exiba o nome dos professores e o número de disciplinas que cada um leciona.
*/

CREATE VIEW view_total_disciplinas_por_professor AS
SELECT
    p.nome AS nome_professor,
    COUNT(DISTINCT t.id_disciplina) AS total_disciplinas
FROM
    professor p
INNER JOIN
    turma t ON p.id_professor = t.id_professor
GROUP BY
    p.nome;



	
