#!/bin/bash

# ================================================================================
# SKRIP BASH INTERAKTIF: MEMBERSIHKAN FILE DENGAN KONFIRMASI (a/p/c)
# ================================================================================

# 1. Kunci posisi folder utama
JUANG_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
cd "$JUANG_DIR"

# 2. Definisikan daftar file berharga (Whitelist)
WHITELIST_FILES="^\./bersihkan_proyek\.sh$|\
^\./a\.cpython-312-x86_64-linux-gnu\.so$|\
^\./config/__init__\.py$|\
^\./config/db_init\.cpython-312-x86_64-linux-gnu\.so$|\
^\./config/global_config\.json$|\
^\./config/language\.json$|\
^\./controllers/__init__\.py$|\
^\./controllers/editor_controller\.cpython-312-x86_64-linux-gnu\.so$|\
^\./controllers/fileConf\.cpython-312-x86_64-linux-gnu\.so$|\
^\./requirements\.txt$|\
^\./run\.py$|\
^\./models/__init__\.py$|\
^\./models/backup_model\.cpython-312-x86_64-linux-gnu\.so$|\
^\./models/catatan_model\.cpython-312-x86_64-linux-gnu\.so$|\
^\./models/config_model\.cpython-312-x86_64-linux-gnu\.so$|\
^\./models/license_model\.cpython-312-x86_64-linux-gnu\.so$|\
^\./new_cornell\.cpython-312-x86_64-linux-gnu\.so$|\
^\./static/CHANGELOG\.md$|\
^\./static/README\.md$|\
^\./static/doc_ynd\.pdf$|\
^\./static/docs/how_to_use_yescnodex\.md$|\
^\./static/docs/instalation\.md$|\
^\./static/images/icon\.ico$|\
^\./static/images/icon\.png$|\
^\./static/style\.css$|\
^\./views/__init__\.py$|\
^\./views/action_menu\.cpython-312-x86_64-linux-gnu\.so$|\
^\./views/custom_dialogs\.cpython-312-x86_64-linux-gnu\.so$|\
^\./views/display_icon\.cpython-312-x86_64-linux-gnu\.so$|\
^\./views/license_menu\.cpython-312-x86_64-linux-gnu\.so$|\
^\./bersih\.sh$|\
^\./views/preference_view\.cpython-312-x86_64-linux-gnu\.so$"


WHITELIST_DIRS="^\./media_notes"

# 3. Kumpulkan daftar file sampah yang terdeteksi ke dalam memori RAM (array)
MAP_SAMPAH=()
while read -r file_log; do
    MAP_SAMPAH+=("$file_log")
done < <(find . -type f | grep -E -v "($WHITELIST_FILES|$WHITELIST_DIRS)")

# Cek jika tidak ada sampah sama sekali
if [ ${#MAP_SAMPAH[@]} -eq 0 ]; then
    echo "[+] Folder Anda sudah bersih sesuai struktur target!"
    exit 0
fi

# 4. Tampilkan Menu Pilihan Interaktif ke User
echo "===================================================="
echo "      MENU PEMBERSIHAN FILE SAMPAH PROYEK           "
echo "===================================================="
echo "Terdeteksi ${#MAP_SAMPAH[@]} file di luar daftar whitelist."
echo ""
echo "Pilihan Aksi:"
echo " [a] Hapus ALL (Semua file sampah langsung dibersihkan)"
echo " [p] Pilih Sebagian (Konfirmasi per file satu-per-satu)"
echo " [c] Cancel / Keluar Sistem"
echo "===================================================="
read -p "Masukkan pilihan Anda (a/p/c): " PILIHAN

# 5. Eksekusi Logika Berdasarkan Input User (First Principle)
case "$PILIHAN" in
    [aA])
        echo "[+] Memulai pembersihan total..."
        for file in "${MAP_SAMPAH[@]}"; do
            echo "[-] Menghapus: $file"
            rm -f "$file"
        done
        ;;

    [pP])
        echo "[+] Memasuki mode seleksi satu-per-satu..."
        for file in "${MAP_SAMPAH[@]}"; do
            read -p "Hapus file ini? -> '$file' (y/n): " TANYA
            if [[ "$TANYA" =~ ^[yY]$ ]]; then
                echo "[-] Menghapus: $file"
                rm -f "$file"
            else
                echo "[*] Melewati: $file (Diselamatkan)"
            fi
        done
        ;;

    [cC]|*)
        echo "[*] Operasi dibatalkan. Tidak ada file yang dihapus."
        exit 0
        ;;
esac

# 6. Pembersihan Otomatis Folder Kosong
find . -type d -empty -delete
echo "[+] Selesai mengeksekusi instruksi Anda!"
