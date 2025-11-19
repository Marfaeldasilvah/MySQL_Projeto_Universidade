from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = (
    "mariadb+mariadbconnector://rPlakama:jaquksww@localhost/Galeria"
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)


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
    desc = db.Column(db.Text, nullable=True)
    ano = db.Column(db.Integer)


# urls


@app.route("/")
def index(name=None):
    obras = Obras.query.all()
    return render_template("index.html", obras=obras)


@app.route("/obras")
def obras():
    obras = Obras.query.all()
    return render_template("obras.html", obras=obras)


@app.route("/artistas")
def artistas():
    artistas = Artista.query.all()
    return render_template("artistas.html", artistas=artistas)


# formulário de artista
@app.route("/add_artista", methods=["GET", "POST"])
def add_artista():
    if request.method == "GET":
        lista_artistas = Artista.query.all()
        return render_template("add_artista.html", artistas=lista_artistas)

    if request.method == "POST":
        novo_artista = None
        try:
            nome_artista = request.form.get("nome")
            periodo_artista = request.form.get("periodo_atuacao")
            nacionalidade_artista = request.form.get("nacionalidade")

            if not nome_artista or not periodo_artista or not nacionalidade_artista:
                return (
                    "Erro: Informações: Nome, nacionalidade e período de atuação são obrigatórios.",
                    400,
                )

            # Crie o novo objeto Artista
            novo_artista = Artista(
                nome=nome_artista,
                periodo_atuacao=periodo_artista,
                nacionalidade=nacionalidade_artista,
            )

            # Adicione e salve no banco
            db.session.add(novo_artista)
            db.session.commit()

            # Redirecione para a lista de artistas
            return redirect(url_for("artistas"))

        except Exception as e:
            db.session.rollback()
            return f"Um erro inesperado ocorreu: {e}", 500


# formulário de obra
@app.route("/add", methods=["GET", "POST"])
def add_art():
    if request.method == "GET":
        artistas = Artista.query.all()
        return render_template("add_art.html", artistas=artistas)

    if request.method == "POST":
        nova_obra = None
        try:
            nome_obra = request.form.get("nome")
            ano_obra = request.form.get("ano")
            link_obra = request.form.get("link_image")
            artista_id_obra = request.form.get("artista_id")

            if not nome_obra or not link_obra or not artista_id_obra:
                return (
                    "Erro: Nome da Obra, Link da Imagem e Artista são obrigatórios.",
                    400,
                )

            ano_int = int(ano_obra) if ano_obra else None
            artista_id_int = int(artista_id_obra)

            nova_obra = Obras(
                nome=nome_obra,
                ano=ano_int,
                link_image=link_obra,
                artista_id=artista_id_int,
            )

            db.session.add(nova_obra)
            db.session.commit()

            return redirect(url_for("index"))

        except ValueError:
            db.session.rollback()
            return "Erro: O 'Ano' ou 'ID do Artista' parece ser inválido.", 400

        except Exception as e:
            db.session.rollback()
            return f"Um erro inesperado ocorreu: {e}", 500


if __name__ == "__main__":
    app.run(debug=True)
