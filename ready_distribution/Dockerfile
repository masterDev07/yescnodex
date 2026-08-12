# Gunakan base image Python yang sesuai
FROM python:3.12-slim

# Tambahkan konfigurasi proxy untuk lingkungan internal kontainer
ENV http_proxy http://192.168.43.1:44355
ENV https_proxy http://192.168.43.1:44355


RUN apt-get update && apt-get install -y \
    tk \
    tk-dev \
    python3-tk \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

# 2. PENTING: Beritahu Python Docker di mana letak libtk8.6.so berada
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/usr/local/lib

# Tentukan direktori kerja di dalam kontainer
WORKDIR /app



# Salin file requirements.txt terlebih dahulu (untuk optimasi cache)
COPY requirements.txt .

# Install dependensi Python
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# 2. Buat user baru bernama 'onah' (non-root)
RUN useradd -m onah

# 3. Salin file proyek dan ubah kepemilikannya menjadi milik 'onah'
COPY --chown=onah:onah . .



# Salin seluruh isi proyek ke dalam kontainer
COPY . .



USER onah

# GANTI BARIS INI: Langsung eksekusi file Python
CMD ["python3", "run.py"]
