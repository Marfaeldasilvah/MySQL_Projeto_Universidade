/* DADOS DOS ARTISTAS */

CREATE TABLE IF NOT EXISTS artistas(
id INT auto_increment primary key,
artista varchar(255) not null,
PeriodoAtuacao varchar(255) not null,
Nacionalidade varchar(255) not null
);

insert  into artistas (artista, PeriodoAtuacao, Nacionalidade)
values ('Vincent van Gogh', '1853-1890', 'Neerlandês'),
		('Pablo Picasso', '1881-1973', 'Espanhol'),
        ('AnitaMalfatti', '1889-1964', 'Brasileira');

/* DADOS DA PROGRAMAÇÃO GALERIA */

CREATE TABLE IF NOT EXISTS galeria(
  id INT AUTO_INCREMENT PRIMARY KEY,
  excursoes VARCHAR(255) NOT NULL,
  horarios VARCHAR(255) NOT NULL,
  Dias varchar(255) not null
);

insert  into galeria (excursoes, horarios, Dias)
values ('Vincent van Gogh', '09:00-12:00', 'Sexta-Feira'),
		('Pablo Picasso', '14:00-16:00', 'Sábado'),
        ('Anita Malfatti', '17:00-19:00', 'Domingo');
  
/* DADOS DA PROGRAMAÇÃO FUNCIONARIOS */

CREATE TABLE IF NOT EXISTS funcionarios(
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  horarios VARCHAR(255) NOT NULL,
  especialidade VARCHAR(255) NOT NULL
);

insert  into funcionarios (nome, horarios, especialidade)
values ('Ana Carolina', '09:00 às 10:30', 'Vicent Van Gogh'),
		('Bruno Mendes', '10:30 às 12:00', 'Vicent Van Gogh'),
        ('Carla Dias', '14:00 às 16:00', 'Pablo Picasso'),
        ('David Silva', '17:00 às 19:00', 'Anita Malfatti');

/* OBRAs DE VAN GOGH */

CREATE TABLE IF NOT EXISTS VanGogh(
id INT auto_increment primary key,
Arte varchar(255) not null,
ObraData varchar(255) not null
);

insert  into VanGogh (Arte, ObraData)
values ('A Noite Estrelada', '1889'),
		('Auto-Retrato', '1889'),
        ('O Quarto de Van Gogh em Arles', '1888'),
        ('Noite Estrelada Sobre o Ródano', '1888'),
        ('A Vinha Encarnada', '1888');
        
/* OBRAs DE PabloPicasso */
        
CREATE TABLE IF NOT EXISTS PabloPicasso(
id INT auto_increment primary key,
Arte varchar(255) not null,
ObraData varchar(255) not null
);

insert  into PabloPicasso (Arte, ObraData)
values ('Guernica', '1937'),
		('Vieux guitariste aveugle', '1903'),
        ('Mulher no Espelho', '1932'),
        ('Le Rêve', '1932'),
        ('Retrato de Dora Maar', '1937');
        
/* OBRAs de AnitaMalfatti */
        
CREATE TABLE IF NOT EXISTS AnitaMalfatti(
id INT auto_increment primary key,
Arte varchar(255) not null,
ObraData varchar(255) not null
);

insert  into AnitaMalfatti (Arte, ObraData)
values ('O homem amarelo', '1917'),
		('Mario de Andrade I', '1922'),
        ('Samba', '1945'),
        ('A Boba', '1916'),
        ('A Onda', '1917');




