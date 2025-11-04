// File: script.js

// --- PILIH ENDPOINT API ANDA ---
const API_URL_PHP = 'http://localhost/spk_laptop_php/api/hitung.php';
const API_URL_PYTHON = 'http://127.0.0.1:5000/api/hitung';

// Ganti ini sesuai backend yang Anda jalankan
const API_ENDPOINT = API_URL_PHP; 
// const API_ENDPOINT = API_URL_PYTHON;
// --- ------------------------- ---

document.addEventListener('DOMContentLoaded', () => {
    const formBobot = document.getElementById('form-bobot');
    const hasilRankingDiv = document.getElementById('hasil-ranking');
    const loadingDiv = document.getElementById('loading');
    const placeholderDiv = document.getElementById('hasil-placeholder');

    // --- LOGIKA BARU UNTUK SLIDER ---
    // Daftarkan semua slider dan span-nya
    const sliders = [
        { input: 'bobot_harga', span: 'val_harga' },
        { input: 'bobot_ram', span: 'val_ram' },
        { input: 'bobot_cpu', span: 'val_cpu' },
        { input: 'bobot_gpu', span: 'val_gpu' },
        { input: 'bobot_ssd', span: 'val_ssd' },
        { input: 'bobot_berat', span: 'val_berat' },
    ];

    sliders.forEach(item => {
        const slider = document.getElementById(item.input);
        const span = document.getElementById(item.span);
        
        // Tambahkan event listener 'input' (berubah saat digeser)
        slider.addEventListener('input', () => {
            span.textContent = slider.value;
        });
    });
    // --- AKHIR LOGIKA SLIDER ---


    // --- LOGIKA FETCH API (SAMA SEPERTI SEBELUMNYA) ---
    formBobot.addEventListener('submit', async (e) => {
        e.preventDefault(); 

        // Tampilkan loading & bersihkan hasil lama
        loadingDiv.classList.remove('hidden');
        hasilRankingDiv.innerHTML = ''; // Kosongkan hasil
        if (placeholderDiv) {
            placeholderDiv.classList.add('hidden');
        }

        // 1. Ambil semua nilai bobot dari form (sekarang dari slider)
        const bobot = {
            w_harga: parseFloat(document.getElementById('bobot_harga').value),
            w_ram: parseFloat(document.getElementById('bobot_ram').value),
            w_cpu: parseFloat(document.getElementById('bobot_cpu').value),
            w_gpu: parseFloat(document.getElementById('bobot_gpu').value),
            w_ssd: parseFloat(document.getElementById('bobot_ssd').value),
            w_berat: parseFloat(document.getElementById('bobot_berat').value)
        };

        // Normalisasi bobot (Total bobot = 1)
        const totalBobot = Object.values(bobot).reduce((sum, val) => sum + val, 0);
        
        const bobotNormal = {};
        for (const key in bobot) {
            bobotNormal[key] = bobot[key] / totalBobot;
        }

        try {
            // 2. Kirim data bobot ke API
            const response = await fetch(API_ENDPOINT, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(bobotNormal) 
            });

            loadingDiv.classList.add('hidden'); // Sembunyikan loading

            if (!response.ok) {
                const errorData = await response.json();
                tampilkanError(errorData.message || 'Terjadi kesalahan jaringan.');
                return;
            }

            // 3. Ambil data JSON hasil ranking
            const dataRanking = await response.json();

            // 4. Tampilkan hasil
            tampilkanHasil(dataRanking);

        } catch (error) {
            loadingDiv.classList.add('hidden');
            tampilkanError('Tidak dapat terhubung ke server API. Pastikan server (XAMPP/Flask) sudah berjalan.');
            console.error('Fetch Error:', error);
        }
    });

    function tampilkanHasil(ranking) {
        if (ranking.length === 0) {
            hasilRankingDiv.innerHTML = '<p class="placeholder-content">Tidak ada data laptop untuk diranking.</p>';
            return;
        }

        const ol = document.createElement('ol');
        ranking.forEach(item => {
            const li = document.createElement('li');
            
            const namaSpan = document.createElement('span');
            namaSpan.className = 'nama-laptop';
            namaSpan.textContent = item.nama_laptop;

            const skorSpan = document.createElement('span');
            skorSpan.className = 'skor';
            skorSpan.textContent = parseFloat(item.skor).toFixed(4);

            li.appendChild(namaSpan);
            li.appendChild(skorSpan);
            ol.appendChild(li);
        });

        hasilRankingDiv.appendChild(ol);
    }

    function tampilkanError(message) {
        hasilRankingDiv.innerHTML = `
            <div class="placeholder-content" style="color: #D8000C; background-color: #FFD2D2; border-radius: 8px; padding: 15px;">
                <i class="fas fa-times-circle" style="color: #D8000C; opacity: 1;"></i>
                <h3 style="color: #D8000C;">Terjadi Kesalahan</h3>
                <p>${message}</p>
            </div>
        `;
    }
});