import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

print("DB_NAME:", os.getenv("DB_NAME"))
print("DB_USER:", os.getenv("DB_USER"))
print("DB_HOST:", os.getenv("DB_HOST"))
print("DB_PORT:", os.getenv("DB_PORT"))

try:
    conn = psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST"),
        port=os.getenv("DB_PORT")
    )

    print("✅ Conectado ao banco com sucesso!")
    conn.close()

except Exception as e:
    print(f"❌ Erro ao conectar ao banco: {e}")
