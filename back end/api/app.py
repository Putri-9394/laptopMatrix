# File: app.py
from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error

# Inisialisasi Aplikasi Flask
app = Flask(__name__)
# Izinkan CORS (Cross-Origin Resource Sharing) agar bisa diakses frontend
CORS(app)

# Konfigurasi Database
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '', # Sesuaikan dengan password root MySQL Anda
    'database': 'db_spk_laptop'
}

def get_db_connection():
    """Membuat koneksi ke database."""
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        return conn
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

@app.route('/api/hitung', methods=['POST'])
def hitung_saw():
    # 1. Ambil data JSON yang dikirim oleh Frontend
    data = request.json

    # Validasi sederhana
    required_keys = ['w_harga', 'w_ram', 'w_cpu', 'w_gpu', 'w_ssd', 'w_berat']
    if not all(key in data for key in required_keys):
        return jsonify({"message": "Data bobot tidak lengkap."}), 400

    # 2. Simpan bobot
    bobot = {
        'harga': float(data['w_harga']),
        'ram': float(data['w_ram']),
        'cpu': float(data['w_cpu']),
        'gpu': float(data['w_gpu']),
        'ssd': float(data['w_ssd']),
        'berat': float(data['w_berat']),
    }

    conn = get_db_connection()
    if conn is None:
        return jsonify({"message": "Koneksi database gagal."}), 500

    try:
        cursor = conn.cursor(dictionary=True) # dictionary=True agar hasil query sbg dict

        # 3. Ambil data laptop
        cursor.execute("SELECT * FROM laptops")
        laptops = cursor.fetchall()

        if not laptops:
            return jsonify({"message": "Data laptop kosong."}), 404

        # 4. Cari Nilai Min/Max
        cursor.execute("""
            SELECT
                MIN(harga) AS min_harga,
                MAX(ram) AS max_ram,
                MAX(skor_cpu) AS max_cpu,
                MAX(skor_gpu) AS max_gpu,
                MAX(ssd) AS max_ssd,
                MIN(berat) AS min_berat
            FROM laptops
        """)
        min_max = cursor.fetchone()

        # 5. Proses Normalisasi (R) dan Perhitungan Skor (V)
        hasil_saw = []
        for laptop in laptops:
            # Normalisasi
            r_harga = min_max['min_harga'] / laptop['harga']
            r_ram = laptop['ram'] / min_max['max_ram']
            r_cpu = laptop['skor_cpu'] / min_max['max_cpu']
            r_gpu = laptop['skor_gpu'] / min_max['max_gpu']
            r_ssd = laptop['ssd'] / min_max['max_ssd']
            r_berat = min_max['min_berat'] / float(laptop['berat']) # Konversi decimal ke float

            # Perhitungan Skor V
            skor_v = (
                (bobot['harga'] * r_harga) +
                (bobot['ram'] * r_ram) +
                (bobot['cpu'] * r_cpu) +
                (bobot['gpu'] * r_gpu) +
                (bobot['ssd'] * r_ssd) +
                (bobot['berat'] * r_berat)
            )

            hasil_saw.append({
                'nama_laptop': laptop['nama_laptop'],
                'skor': round(skor_v, 4) # Bulatkan 4 angka di belakang koma
            })

        # 6. Urutkan hasil
        hasil_terurut = sorted(hasil_saw, key=lambda x: x['skor'], reverse=True)

        # 7. Kembalikan hasil sebagai JSON
        return jsonify(hasil_terurut), 200

    except Error as e:
        return jsonify({"message": f"Terjadi kesalahan server: {e}"}), 500
    finally:
        if conn and conn.is_connected():
            cursor.close()
            conn.close()

# Menjalankan server development Flask
if __name__ == '__main__':
    app.run(debug=True, port=5000) # <-- INI BENAR