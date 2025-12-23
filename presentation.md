## Script Presentasi Aplikasi Hitungan

### 1. Pembukaan

> “Selamat pagi/siang, Bapak/Ibu.  
> Pada kesempatan kali ini saya akan mempresentasikan aplikasi **Hitungan**, yaitu aplikasi pengelolaan keuangan sederhana yang saya kembangkan menggunakan **Flutter**.”

> “Tujuan utama aplikasi ini adalah membantu pengguna — khususnya admin perusahaan — untuk **mencatat transaksi pemasukan dan pengeluaran**, melihat **ringkasan saldo**, serta memonitor **riwayat transaksi** dengan tampilan yang rapi dan mudah dipahami.”

---

### 2. Teknologi & Arsitektur Singkat

> “Aplikasi ini dibangun dengan **Flutter** sehingga bisa berjalan di beberapa platform seperti web dan desktop.

> “Struktur utama aplikasinya dimulai dari file `main.dart`, yang menjalankan widget `MyApp`

---

### 3. Alur Aplikasi (Loading → Login → Home)

> “Saat aplikasi pertama kali dijalankan, user tidak langsung masuk ke halaman utama, tetapi melewati **tiga tahap**:
> 1. **Loading Page**  
>    - Halaman ini menampilkan logo dan indikator loading.  
>    - Di belakang layar, `AuthProvider` melakukan inisialisasi sebentar.
> 2. **Login Page**  
>    - Setelah loading selesai, kalau belum login, user diarahkan ke halaman **login admin**.  
>    - Di sini ada form email dan password, dengan validasi sederhana dan indicator loading saat tombol login ditekan.
> 3. **Home Page**  
>    - Kalau login berhasil, user baru diarahkan ke **halaman utama** atau dashboard keuangan.”

> “Logika pemilihan halaman ini dikontrol oleh widget `_AuthGate` di `main.dart`, yang mengecek:
> - Kalau masih loading → tampil `LoadingPage`,  
> - Kalau belum login → tampil `LoginPage`,  
> - Kalau sudah login → tampil `HomePage`.”

---

### 4. Fitur di Home Page (Dashboard)

> “Di **Home Page**, ada beberapa bagian utama:

> - **Header**  
>   - Menampilkan sapaan kepada admin.  
>   - Ada tombol **plus** untuk menambah transaksi baru.  
>   - Ada avatar profil yang kalau ditekan akan membuka **Profile Modal**.”

> - **Kartu Saldo – `BalanceCard`**  
>   - Kartu ini menampilkan ringkasan:
>     - Total pemasukan,  
>     - Total pengeluaran,  
>     - dan **saldo akhir**.  
>   - Nilai-nilai ini dihitung secara otomatis berdasarkan semua transaksi yang tersimpan di memori aplikasi.”

> - **Grid Kategori – `CategoryGrid`**  
>   - Menampilkan beberapa kategori seperti Gaji, Belanja, Transport, dan lain-lain.  
>   - Ini berfungsi sebagai tampilan kategori yang konsisten, sekaligus pintu masuk untuk menambah transaksi ke kategori tertentu.”

> - **Daftar Transaksi – `TransactionCard`**  
>   - Di bagian bawah, ada daftar **transaksi terbaru**.  
>   - Setiap item menampilkan judul, kategori, tanggal, dan nominal.  
>   - Nominal pemasukan dan pengeluaran dibedakan dengan warna dan tanda plus/minus.  
>   - Dari sini admin bisa melihat aktivitas keuangan secara cepat.”

---

### 5. Menambah Transaksi – `AddTransactionModal`

> “Saat tombol plus di header ditekan, akan muncul **modal tambah transaksi** di bagian bawah layar.”

> “Di modal ini, admin bisa:
> - Memilih tipe **Pengeluaran** atau **Pemasukan**,  
> - Mengisi judul transaksi,  
> - Mengisi jumlah nominal (dalam Rupiah),  
> - Memilih kategori,  
> - Memilih tanggal dengan date picker,  
> - Dan menambahkan deskripsi opsional.”

> “Setelah formulir valid dan disubmit:
> - Aplikasi membuat objek `Transaction` baru,  
> - Menambahkannya ke daftar transaksi di `HomePage`,  
> - Menghitung ulang total pemasukan, pengeluaran, dan saldo,  
> - Dan modal akan otomatis tertutup.”

---

### 6. History Transaksi – `CategoryHistoryModal`

> “Di pojok kanan bawah, ada tombol **riwayat** (history).  
> Saat ditekan, muncul **Category History Modal** yang menampilkan:
> - Daftar transaksi yang bisa difilter berdasarkan **kategori**,  
> - Filter tambahan berdasarkan **tipe**: semua, pemasukan saja, atau pengeluaran saja,  
> - Ringkasan jumlah transaksi dan total nilai di bagian atas.”

> “Di sini saya juga menambahkan **fitur konfirmasi dua langkah** saat menghapus:
> - Saat user memilih hapus pada sebuah transaksi, akan muncul **dialog konfirmasi pertama**.  
> - Jika disetujui, muncul **dialog konfirmasi kedua** yang mengingatkan bahwa aksi ini tidak bisa dibatalkan.  
> - Baru setelah dua-duanya disetujui, transaksi benar‑benar dihapus.”

> “Penghapusan ini langsung mempengaruhi:
> - Daftar di modal itu sendiri (hilang seketika tanpa perlu refresh),  
> - Serta daftar transaksi di halaman utama, karena saya tetap memanggil callback kembali ke `HomePage`.”

---

### 7. Profile & Pengaturan – `ProfileModal`

> “Dari avatar di header, admin bisa membuka **Profile Modal** yang berisi:
> - Informasi dasar admin (nama dan email),  
> - Status akun (misalnya ‘Premium User’),  
> - Beberapa pengaturan aplikasi.”

> “Di dalamnya ada 3 setting utama:
> 1. **Tema Aplikasi**  
>    - Switch untuk mengganti antara **mode terang** dan **mode gelap**.  
>    - Perubahan ini memanggil `ThemeProvider.toggleTheme()` dan langsung mengubah tampilan seluruh aplikasi.
> 2. **Export Data**  
>    - Saat ini masih berupa placeholder, namun sudah disiapkan UI dan feedback berupa SnackBar.
> 3. **Tentang Aplikasi**  
>    - Menampilkan dialog informasi versi dan deskripsi singkat aplikasi, dengan animasi fade dan scale.”

> “Di bagian bawah modal profil ada tombol **Logout**:
> - Ketika ditekan, aplikasi:
>   - Menutup modal,  
>   - Memanggil `AuthProvider.logout()`,  
>   - Menampilkan SnackBar ‘Logout berhasil’,  
>   - Dan `_AuthGate` otomatis mengembalikan user ke **halaman login**.”

---

### 8. Penutup

> “Secara keseluruhan, aplikasi Hitungan ini:
> - Memiliki alur yang jelas dari loading, login admin, hingga dashboard keuangan,  
> - Menyediakan fitur tambah dan kelola transaksi dengan tampilan yang rapi,  
> - Menyertakan riwayat transaksi yang bisa difilter, dengan penghapusan yang aman (double confirmation),

> “Ke depan, aplikasi ini masih bisa dikembangkan lebih lanjut, misalnya:
> - Menyimpan data ke database atau backend,  
> - Menambah fitur export laporan ke Excel atau PDF,  
> - Atau menambah multi-user dengan role yang berbeda.”

> “Demikian penjelasan singkat mengenai aplikasi Hitungan yang saya buat.  
> Terima kasih, saya siap menjawab pertanyaan Bapak/Ibu.”


