import os
import psycopg2
from dotenv import load_dotenv

load_dotenv()

def get_db_connection():
    try:
        conn = psycopg2.connect(
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD"),
            host=os.getenv("DB_HOST"),
            port=os.getenv("DB_PORT")
        )
        return conn
    except Exception as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None


def execute_query(query, params=None, fetch=True, commit=False):
    conn = get_db_connection()

    if not conn:
        return "Erro de conexão com banco"

    try:
        with conn.cursor() as cur:
            cur.execute(query, params)

            if commit:
                conn.commit()

            if fetch and cur.description:
                columns = [col.name for col in cur.description]
                return [dict(zip(columns, row)) for row in cur.fetchall()]

            return None

    except Exception as e:
        conn.rollback()
        return str(e)

    finally:
        conn.close()
