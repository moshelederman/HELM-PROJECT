# my-project
from flask import Flask, render_template, jsonify
import os
import mysql.connector
from dotenv import load_dotenv
from prometheus_client import start_http_server, Summary, Counter, Gauge, generate_latest, CONTENT_TYPE_LATEST

FLASK_DEBUG = 1

load_dotenv()

app = Flask(__name__)

db_config = {
    'host': os.getenv('MYSQL_HOST'),
    'user': os.getenv('MYSQL_USER'),
    'password': os.getenv('MYSQL_PASSWORD'),
    'database': os.getenv('MYSQL_DATABASE')
}

# Start Prometheus metrics server
start_http_server(9090)

# Create Prometheus metrics
DATABASE_ERRORS = Counter('database_errors_total', 'Total number of database errors')
NUM_VISITORS = Gauge('num_visitors', 'number of visitors')

@app.route('/')
def display_images():
    try:
        cnx = mysql.connector.connect(**db_config)
        cursor = cnx.cursor()

        cursor.execute("UPDATE visitors SET visit_count = visit_count + 1 WHERE id = 1")
        cnx.commit()

        cursor.execute("SELECT visit_count FROM visitors WHERE id = 1")
        visit_count = cursor.fetchone()[0]

        cursor.execute("SELECT image_url FROM images ORDER BY RAND() LIMIT 1")
        result = cursor.fetchone()

        image_url = result[0] if result else None

        # Update Prometheus metrics
        NUM_VISITORS.set(visit_count)

        cursor.close()
        cnx.close()
        
        return render_template('index.html', image_url=image_url, visit_count=visit_count)

    except mysql.connector.Error as err:
        DATABASE_ERRORS.inc()
        return jsonify({"error": f"Database error: {err}"}), 500

    except Exception as e:
        return jsonify({"error": f"Unexpected error: {e}"}), 500

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/project')
def project():
    return render_template('project.html')

@app.route('/lederman')
def lederman():
    return render_template('lederman.html')

@app.route('/metrics')
def metrics():
    return generate_latest(), 200, {'Content-Type': CONTENT_TYPE_LATEST}

@app.route('/shiduchim')
def shiduchim():
    return render_template('shiduchim.html')

if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))
    app.run(host="0.0.0.0", port=port) # nosec