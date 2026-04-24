-- 1. LIMPEZA DO AMBIENTE
DROP TABLE IF EXISTS professor_disciplina_periodo;
DROP TABLE IF EXISTS curso_disciplina;
DROP TABLE IF EXISTS disciplina;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS departamento;

-- 2. CRIAÇÃO DAS TABELAS (DDL)

CREATE TABLE departamento (
    pk_departamento SERIAL,
    nome_departamento VARCHAR(100) NOT NULL,
    CONSTRAINT const_pk_departamento PRIMARY KEY (pk_departamento)
);

CREATE TABLE professor (
    pk_professor SERIAL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    data_nascimento DATE,
    salario NUMERIC(10,2),
    fk_departamento INT,
    CONSTRAINT const_pk_professor PRIMARY KEY (pk_professor),
    CONSTRAINT const_unique_email_professor UNIQUE (email),
    CONSTRAINT const_fk_departamento_professor FOREIGN KEY (fk_departamento) 
        REFERENCES departamento(pk_departamento)
);

CREATE TABLE curso (
    pk_curso SERIAL,
    nome_curso VARCHAR(100) NOT NULL,
    fk_departamento INT,
    CONSTRAINT const_pk_curso PRIMARY KEY (pk_curso),
    CONSTRAINT const_fk_departamento_curso FOREIGN KEY (fk_departamento) 
        REFERENCES departamento(pk_departamento)
);

CREATE TABLE disciplina (
    pk_disciplina SERIAL,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INT,
    CONSTRAINT const_pk_disciplina PRIMARY KEY (pk_disciplina)
);

-- RELAÇÃO CURSO X DISCIPLINA
CREATE TABLE curso_disciplina (
    fk_curso INT,
    fk_disciplina INT,
    CONSTRAINT const_pk_curso_disciplina PRIMARY KEY (fk_curso, fk_disciplina),
    CONSTRAINT const_fk_curso_relacao FOREIGN KEY (fk_curso) REFERENCES curso(pk_curso),
    CONSTRAINT const_fk_disciplina_relacao FOREIGN KEY (fk_disciplina) REFERENCES disciplina(pk_disciplina)
);

CREATE TABLE professor_disciplina_periodo (
    pk_prof_disc_per SERIAL,
    fk_professor INT,
    fk_disciplina INT,
    ano INT NOT NULL,
    semestre INT NOT NULL,
    CONSTRAINT const_pk_prof_disc_per PRIMARY KEY (pk_prof_disc_per),
    CONSTRAINT const_fk_professor_periodo FOREIGN KEY (fk_professor) REFERENCES professor(pk_professor),
    CONSTRAINT const_fk_disciplina_periodo FOREIGN KEY (fk_disciplina) REFERENCES disciplina(pk_disciplina),
    CONSTRAINT const_check_semestre_periodo CHECK (semestre IN (1, 2))
);

-- 3. POPULAÇÃO DE DADOS (DML) [cite: 6]

INSERT INTO departamento (nome_departamento) VALUES 
('Informática'), ('Engenharias'), ('Saúde'), ('Humanas'), ('Artes'), 
('Direito'), ('Administração'), ('Matemática'), ('Física'), ('Biologia');

INSERT INTO professor (nome, email, data_nascimento, salario, fk_departamento) VALUES 
('Rosanete Grassiani dos Santos', 'rosanete@univ.edu.br', '1985-05-20', 8500.00, 1),
('Rafael Veiga', 'rafael.veiga@univ.edu.br', '1988-10-15', 7200.00, 1),
('Vinicius Larger', 'vinicius.larger@univ.edu.br', '1990-03-12', 6800.00, 2),
('Ana Souza', 'ana.souza@univ.edu.br', '1975-01-25', 9500.00, 3),
('Carlos Lima', 'carlos.lima@univ.edu.br', '1982-07-30', 5500.00, 4),
('Beatriz Silva', 'beatriz.silva@univ.edu.br', '1992-11-05', 4800.00, 1),
('Marcos Rocha', 'marcos.rocha@univ.edu.br', '1980-04-18', 7100.00, 2),
('Juliana Paes', 'juliana.paes@univ.edu.br', '1987-09-22', 8900.00, 3),
('Ricardo Oliveira', 'ricardo.o@univ.edu.br', '1978-12-12', 6200.00, 4),
('Fernanda Costa', 'fernanda.c@univ.edu.br', '1983-06-08', 5900.00, 5);

INSERT INTO curso (nome_curso, fk_departamento) VALUES 
('Bacharelado em Sistemas de Informação', 1),
('Análise e Desenvolvimento de Sistemas', 1),
('Biomedicina', 3),
('Psicologia', 4),
('Farmácia', 3),
('Engenharia Elétrica', 2),
('Direito', 6),
('Administração', 7),
('Engenharia Civil', 2),
('Design Gráfico', 5);

INSERT INTO disciplina (nome_disciplina, carga_horaria) VALUES 
('Laboratório de Banco de Dados', 80), ('Programação Mobile', 60), 
('Programação Orientada a Objetos', 80), ('Redes de Computadores', 60),
('Cálculo I', 100), ('Anatomia Humana', 120), ('Ética e Cidadania', 40),
('Estrutura de Dados', 80), ('Sistemas Operacionais', 60), ('Psicologia Organizacional', 40);

-- VINCULANDO DISCIPLINAS AOS CURSOS (Exemplos Práticos)
INSERT INTO curso_disciplina (fk_curso, fk_disciplina) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), -- BSI com TI
(2, 1), (2, 2), (2, 3), -- ADS com TI
(3, 6), (5, 6),         -- Anatomia em Biomedicina e Farmácia
(4, 7), (4, 10),        -- Psicologia
(6, 4), (6, 5),         -- Engenharia Elétrica com Redes e Cálculo
(9, 5);                 -- Engenharia Civil com Cálculo

INSERT INTO professor_disciplina_periodo (fk_professor, fk_disciplina, ano, semestre) VALUES 
(1, 1, 2026, 1), (1, 2, 2026, 1), (2, 3, 2026, 1), (3, 4, 2026, 1), 
(4, 6, 2025, 2), (5, 7, 2025, 1), (6, 8, 2026, 1), (7, 5, 2025, 2), 
(8, 6, 2026, 1), (9, 10, 2025, 2);

create table aluno(
	pk_aluno serial,
	nome_completo varchar(100) not null,
	email varchar(100) not null,
	cidade varchar(50),
	data_nascimento date,
	fk_curso int,

	constraint const_pk_aluno primary key(pk_aluno),
	constraint const_unique_email unique(email),
	constraint const_fk_curso foreign key(fk_curso) references curso (pk_curso)
);

alter table aluno add column telefone varchar(11);
alter table aluno rename column telefone to celular;

alter table aluno add adsadsa varchar(11);

alter table aluno drop column adsadsa;

insert into aluno (nome_completo, email, cidade, data_nascimento, fk_curso) VALUES
('Octávio Jhulian', 'fernandopessoa@gmail.com', 'São Paulo', '1973/03/12', 1),
('Mariana da Silva', 'marianinha23@gmail.com', 'Curitiba', '2002/06/13', 2),
('Machado de Assis', 'machadodeassis@gmail', 'Rio de Janeiro', '1995/12/05', 1);

UPDATE aluno
set fk_curso = 3
where pk_aluno = 1;

delete from aluno
where pk_aluno = 2;

select * from professor

select 
	sum(salario) as "Folha Total",
	avg(salario)::numeric(10,2) as "Media Salarial"
from professor;

select 
	min(salario) as "Menor Salario",
	max(salario) as "Maior Salario"
from professor

select distinct fk_departamento
from professor
order by fk_departamento;

select count(distinct fk_departamento) as "Total Dpto com Professores"
from professor;

select professor.nome, departamento.nome_departamento
from professor
inner join departamento on professor.fk_departamento = departamento.pk_departamento
order by departamento.nome_departamento;