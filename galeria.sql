CREATE TABLE artistas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  periodo_atuacao VARCHAR(255),
  nacionalidade VARCHAR(255)
);

CREATE TABLE obras (
  id INT AUTO_INCREMENT PRIMARY KEY,
  artista_id INT NOT NULL,
  nome VARCHAR(255) NOT NULL,
  ano INT,
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

CREATE TABLE galeria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  artista_id INT NOT NULL,
  excursao VARCHAR(255),
  horario VARCHAR(255),
  dia VARCHAR(255),
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);

CREATE TABLE funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  horario VARCHAR(255),
  artista_id INT,
  FOREIGN KEY (artista_id) REFERENCES artistas(id)
);
