CREATE DATABASE IF NOT EXISTS Galeria;
USE Galeria;

CREATE TABLE IF NOT EXISTS artistas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  anos_de_atuacao VARCHAR(255),
  nacionalidade VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS obras (
  id INT AUTO_INCREMENT PRIMARY KEY,
  artista_id INT NOT NULL,
  nome VARCHAR(255) NOT NULL,
  ano INT,
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

CREATE TABLE IF NOT EXISTS galeria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  artista_id INT NOT NULL,
  excursao VARCHAR(255),
  horario VARCHAR(255),
  dia VARCHAR(255),
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

CREATE TABLE IF NOT EXISTS funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  horario VARCHAR(255),
  artista_id INT,
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);
