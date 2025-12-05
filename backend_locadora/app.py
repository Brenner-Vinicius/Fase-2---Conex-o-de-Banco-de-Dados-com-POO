from flask import Flask
from flask_cors import CORS

from src.routes.clientes import clientes_bp
from src.routes.equipamentos import equipamentos_bp
from src.routes.locacoes import locacoes_bp
from src.routes.pagamentos import pagamentos_bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(clientes_bp)
app.register_blueprint(equipamentos_bp)
app.register_blueprint(locacoes_bp)
app.register_blueprint(pagamentos_bp)


@app.route("/")
def home():
    return {"mensagem": "API Locadora funcionando com sucesso 🚀"}


if __name__ == "__main__":
    app.run(debug=True)
