import os
import sys

# Suntik "alamat absolut" folder saat ini ke dalam sistem pencarian Python
jalur_sekarang = os.path.dirname(os.path.abspath(__file__))
if jalur_sekarang not in sys.path:
    sys.path.insert(0, jalur_sekarang)



from models.catatan_model import CatatanModel
from controllers.editor_controller import EditorController,ProsesAI
from config.db_init import *


try:
    # 1. Impor modul biner hasil kompilasi
    import new_cornell

    # 2. Panggil kelas utama aplikasi CustomTkinter
    model = CatatanModel(nama_db=DB_NAME)
    if hasattr(new_cornell, 'AplikasiCornellSqlite'):
        # Membuat instance dari kelas aplikasi
        app = new_cornell.AplikasiCornellSqlite()

        controller = EditorController(model, app)
        app.set_controller(controller)
        controller.proseslicense.check_saved_license()


        # Menjalankan event loop utama CustomTkinter
        app.mainloop()

    else:
        print("Eror: Kelas 'AplikasiCornellSqlite' tidak ditemukan di dalam modul.")

except ImportError as e:
    print(f"Gagal memuat modul .so: {e}")
except Exception as e:
    print(f"Terjadi kendala saat menjalankan aplikasi: {e}")
