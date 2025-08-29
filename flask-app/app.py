import os
import time
from flask import Flask
import psycopg2

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "my-postgres")
DB_USER = os.getenv("DB_USER", "admin")
DB_PASSWORD = os.getenv("DB_PASSWORD", "admin123")
DB_NAME = os.getenv("DB_NAME", "mydb")

def get_conn():
    return psycopg2.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        dbname=DB_NAME
    )

@app.route('/')
def index():
    # Simple persistence demo: a counter stored in PostgreSQL.
    try:
        conn = get_conn()
        conn.autocommit = True
        cur = conn.cursor()
        # Create table and seed single row if needed
        cur.execute("""
            CREATE TABLE IF NOT EXISTS visits (
                id INT PRIMARY KEY,
                count INT NOT NULL
            );
        """)
        cur.execute("""
            INSERT INTO visits (id, count) VALUES (1, 0)
            ON CONFLICT (id) DO NOTHING;
        """)
        # Increment the counter
        cur.execute("UPDATE visits SET count = count + 1 WHERE id = 1;")
        # Read current value
        cur.execute("SELECT count FROM visits WHERE id = 1;")
        count = cur.fetchone()[0]
        cur.close()
        conn.close()
        return f"Hello from Flask! You've visited this page {count} times. (Data persists via Docker named volume)"
    except Exception as e:
        return f"Database connection error: {e}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
