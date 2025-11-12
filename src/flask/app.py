from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = (
    "mariadb+mariadbconnector://rPlakama:jaquksww@localhost/Galeria"
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)


@app.route("/")
def index(name=None):
    obras = Obras.query.all()
    return render_template("index.html", obras=obras)


@app.route("/artistas")
def artistas():
    artistas = Artista.query.all()
    return render_template("artistas.html", artistas=artistas)


@app.route("/add", methods=["GET", "POST"])
def add_art():
    if request.method == "GET":
        artistas = Artista.query.all()
        return render_template("add_art.html", artistas=artistas)
    if request.method == "POST":
        nova_obra = None

        try:
            # 1. Pegar os dados do formulário
            nome_obra = request.form.get("nome")
            ano_obra = request.form.get("ano")
            link_obra = request.form.get("link_image")
            artista_id_obra = request.form.get("artista_id")

            # Checa se os campos obrigatórios não estão vazios
            if not nome_obra or not link_obra or not artista_id_obra:
                return (
                    "Erro: Nome da Obra, Link da Imagem e Artista são obrigatórios.",
                    400,
                )

            # Converte os números. Permite que 'ano' seja vazio
            ano_int = int(ano_obra) if ano_obra else None
            artista_id_int = int(artista_id_obra)
            # 2. Criar o novo objeto Obras
            nova_obra = Obras(
                nome=nome_obra,
                ano=ano_int,
                link_image=link_obra,
                artista_id=artista_id_int,
            )

            # 3. Adicionar e salvar no banco
            db.session.add(nova_obra)
            db.session.commit()

            # 4. Redirecionar de volta para a página inicial
            return redirect(url_for("index"))

        except ValueError:
            # Erro específico se a conversão int() falhar (ex: digitou "abc" no ano)
            db.session.rollback()
            return "Erro: O 'Ano' ou 'ID do Artista' parece ser inválido.", 400

        except Exception as e:
            # Pega qualquer outro erro (ex: falha de conexão com o banco)
            db.session.rollback()  # Desfaz qualquer mudança pendente

            # Este 'except' agora é seguro e não causará o UnboundLocalError
            return f"Um erro inesperado ocorreu: {e}", 500


class Artista(db.Model):
    __tablename__ = "artistas"
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(255), nullable=False)
    periodo_atuacao = db.Column(db.String(255))
    nacionalidade = db.Column(db.String(255))


class Obras(db.Model):
    __tablename__ = "obras"
    id = db.Column(db.Integer, primary_key=True)
    artista_id = db.Column(db.Integer, db.ForeignKey("artistas.id"), nullable=False)
    nome = db.Column(db.String(255), nullable=False)
    link_image = db.Column(db.String(255), nullable=False)
    ano = db.Column(db.Integer)
