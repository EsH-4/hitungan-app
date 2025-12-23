## Penjelasan Struktur & Fungsi Project `hitungan_app`

File ini menjelaskan secara singkat fungsi dari tiap bagian utama di dalam project, supaya Anda mudah memahami alur dan titik-titik penting saat mengembangkan.

---

## 1. Entry Point & Setup Utama

### `lib/main.dart`
- **`main()`**  
  - Fungsi awal aplikasi, menjalankan `MyApp`.
- **`MyApp` (StatelessWidget)**  
  - Mendaftarkan semua `Provider` global dengan `MultiProvider`:
    - `ThemeProvider` → mengatur tema terang/gelap aplikasi.
    - `AuthProvider` → mengatur status login admin dan fase loading.
  - Meng-setup `MaterialApp`:
    - `theme` dan `darkTheme` diambil dari `AppTheme` (lihat bagian Config).
    - `home` diarahkan ke `_AuthGate`.
- **`_AuthGate` (StatelessWidget)**  
  - **Tujuan**: mengatur alur awal aplikasi berdasarkan status autentikasi.
  - Jika `AuthProvider.isLoading == true` → tampil `LoadingPage`.
  - Jika belum login (`isAuthenticated == false`) → tampil `LoginPage`.
  - Jika sudah login → masuk ke `HomePage` (halaman utama).

---

## 2. Config & Style

### `lib/config/app_theme.dart`
- **`AppTheme.lightTheme` / `AppTheme.darkTheme` (ThemeData)**  
  - Mengatur tampilan global (Material 3, warna, typography, input, button, FAB, dsb).
  - Light theme memakai `AppColors` dengan background terang.
  - Dark theme memakai warna gelap (`0xFF121212`, `0xFF1E1E1E`) dengan teks terang.

### `lib/config/app_colors.dart`
- Kumpulan konstanta warna:
  - **`primary`, `primaryLight`, `primaryDark`** → warna utama aplikasi.
  - **`background`, `surface`, `cardBackground`** → warna dasar permukaan.
  - **`textPrimary`, `textSecondary`, `textTertiary`, `textDisabled`** → konsistensi warna teks.
  - **`success`, `error`, `border`, dll** → warna status.

### `lib/config/app_dimensions.dart`
- Kumpulan konstanta ukuran:
  - **`paddingS`..`paddingXXL`** → padding standar agar spacing seragam.
  - **`radiusS`..`radiusXL`** → radius sudut card/button.
  - **`iconS`..`iconXL`** → ukuran ikon.

### `lib/styles/app_text_styles.dart`
- Mendefinisikan style teks reusable:
  - **`header1`..`header4`** → judul/big text.
  - **`bodyLarge`, `bodyMedium`, `bodySmall`** → teks konten.
  - **`label*`, `caption`, `buttonMedium`** → label, caption, dan teks button.

### `lib/styles/app_decorations.dart`
- Dekorasi komponen:
  - **`card`** → dekorasi standar kartu (background, radius, shadow).
  - **`avatar`** → dekorasi avatar di header/home.

---

## 3. State Management (Provider)

### `lib/providers/theme_provider.dart`
- **`ThemeProvider` (ChangeNotifier)**  
  - Menyimpan `ThemeMode` (light / dark).
  - **`isDarkMode`** → boolean membantu UI (mis. switch di Profile).
  - **`toggleTheme()`** → mengubah mode terang/gelap dan memanggil `notifyListeners()` agar UI rebuild.

### `lib/providers/auth_provider.dart`
- **`AuthProvider` (ChangeNotifier)**  
  - Mengelola tiga state utama:
    - **Loading awal**: `isLoading` → true saat aplikasi pertama dijalankan (simulasi loading ±2 detik).
    - **Autentikasi admin**:
      - Kredensial tersimpan di constant:
        - Email: `admin@hitungan.com`
        - Password: `admin123`
      - **`login(email, password)`**:
        - Set `isAuthenticating = true` → tombol login jadi disabled + tampil spinner.
        - Cek email/password:
          - Jika cocok → `isAuthenticated = true`.
          - Jika salah → set `errorMessage` untuk ditampilkan di UI.
        - `notifyListeners()` untuk memicu rebuild `_AuthGate` dan `LoginPage`.
    - **Logout**:
      - **`logout()`** → set `isAuthenticated = false`, sehingga `_AuthGate` kembali menampilkan `LoginPage`.

---

## 4. Halaman Utama & Flow

### `lib/pages/home_page.dart`
- **`HomePage` (StatefulWidget)**  
  - **Tujuan**: dashboard utama untuk melihat ringkasan saldo dan riwayat transaksi.
  - State utama:
    - `transactions` → list `Transaction`.
    - `totalIncome`, `totalExpense`, `balance` → hasil perhitungan dari `transactions`.
  - Animation:
    - `_animationController` + `_fadeAnimation` → animasi fade pada beberapa widget (mis. `BalanceCard`).
  - Fungsi penting:
    - **`_loadSampleData()`** → mengisi contoh data transaksi (dummy).
    - **`_calculateTotals()`** → hitung total pemasukan, pengeluaran, dan saldo.
    - **`_addTransaction(Transaction)`** → menambah transaksi ke awal list, lalu hitung ulang total.
    - **`_deleteTransaction(String id)`** → menghapus transaksi berdasarkan `id` dan hitung ulang total.
    - **`_showAddTransactionModal()`** → buka modal tambah transaksi (bottom sheet).
    - **`_showCategoryHistoryModal()`** → buka modal riwayat transaksi per kategori.
    - **`_showProfileModal()`** → buka modal profil/pengaturan (termasuk switch tema & logout).
  - Layout utama:
    - Header dengan sapaan, tombol tambah transaksi, dan avatar yang membuka `ProfileModal`.
    - `BalanceCard` → menampilkan saldo, total income, dan expense.
    - `CategoryGrid` → shortcut kategori dan aksi cepat (misalnya tambah transaksi).
    - Daftar `TransactionCard` di dalam container `AppDecorations.card`.

### `lib/pages/loading_page.dart`
- **`LoadingPage` (StatelessWidget)**  
  - Ditampilkan saat `AuthProvider.isLoading == true`.
  - Menampilkan logo/ikon, nama aplikasi, teks “Menyiapkan data…”, dan `CircularProgressIndicator`.
  - Dipakai sebagai splash/loading awal aplikasi sebelum user masuk ke login.

### `lib/pages/login_page.dart`
- **`LoginPage` (StatefulWidget)**  
  - **Tujuan**: form login untuk admin sebelum masuk ke `HomePage`.
  - Komponen:
    - Form dengan:
      - TextField email (default `admin@hitungan.com` untuk memudahkan testing).
      - TextField password dengan toggle show/hide.
    - Validasi sederhana (email harus berformat @, password min 6 karakter).
    - Pesan error jika kredensial salah (diambil dari `AuthProvider.errorMessage`).
    - Tombol “Masuk sebagai Admin” yang:
      - Menampilkan loading spinner saat `auth.isAuthenticating == true`.
      - Memanggil `AuthProvider.login(...)`.
  - Setelah login berhasil, `_AuthGate` otomatis mengganti tampilan ke `HomePage`.

---

## 5. Model Data

### `lib/models/transaction.dart`
- **`Transaction` (class)**  
  - Mewakili satu transaksi keuangan dengan field seperti:
    - `id` (String unik)
    - `title` (judul transaksi)
    - `amount` (nominal)
    - `date` (tanggal)
    - `type` (enum `TransactionType.income` / `TransactionType.expense`)
    - `category` (kategori seperti Gaji, Belanja, dsb.)
    - `description` (opsional).
  - Dipakai di seluruh widget yang berhubungan dengan transaksi (`HomePage`, `TransactionCard`, `CategoryHistoryModal`, dll).

---

## 6. Widget-Widget Utama

### `lib/widgets/balance_card.dart`
- **`BalanceCard` (StatelessWidget)**  
  - Menampilkan:
    - **Saldo (`balance`)**
    - **Total pemasukan (`income`)**
    - **Total pengeluaran (`expense`)**
  - Bisa menerima animasi (mis. `fadeAnimation`) dari `HomePage` untuk tampilan yang lebih halus.

### `lib/widgets/transaction_card.dart`
- **`TransactionCard` (StatelessWidget)**  
  - Menampilkan satu transaksi dalam list:
    - Judul transaksi.
    - Tanggal.
    - Nominal (plus/minus dan warna beda untuk income/expense).
  - Memiliki aksi hapus (menggunakan callback `onDelete(String id)` yang dikirim dari `HomePage`).

### `lib/widgets/add_transaction_modal.dart`
- **`AddTransactionModal` (StatefulWidget, Bottom Sheet)**  
  - Form untuk menambah transaksi baru:
    - Pilih tipe: **Pengeluaran / Pemasukan** (tombol toggle dengan style berbeda).
    - Input judul transaksi, jumlah (dengan prefix `Rp`), kategori (Dropdown), tanggal (DatePicker), dan deskripsi opsional.
  - Validasi dasar:
    - Judul & jumlah wajib diisi, jumlah harus angka valid.
  - Saat submit:
    - Membuat objek `Transaction` baru (dengan `id` berdasar timestamp).
    - Memanggil callback `onAddTransaction(Transaction)` ke `HomePage`.
    - Menutup modal (`Navigator.pop`).
  - Sudah disesuaikan agar tampilan mengikuti tema (dark/light) dan animasi muncul lebih smooth.

### `lib/widgets/category_history_modal.dart`
- **`CategoryHistoryModal` (StatefulWidget, Bottom Sheet)**  
  - Menampilkan **history transaksi** dengan fitur:
    - Filter kategori (chip horizontal).
    - Filter tipe: Semua / Pemasukan / Pengeluaran.
    - Ringkasan jumlah transaksi + total nominal di bagian atas.
  - Menyimpan list lokal `_localTransactions`:
    - Supaya ketika menghapus, item langsung hilang dari daftar **tanpa perlu refresh**.
  - Penghapusan dengan **konfirmasi dua langkah**:
    - Dialog 1: “Konfirmasi 1/2 – yakin ingin menghapus?”
    - Dialog 2: “Konfirmasi 2/2 – tindakan ini tidak bisa dibatalkan.”
    - Jika user setuju dua-duanya, `_handleDelete` akan:
      - Menghapus dari `_localTransactions`.
      - Memanggil `onDeleteTransaction(transaction)` ke `HomePage` untuk sinkronisasi data global.

### `lib/widgets/category_grid.dart`
- **`CategoryGrid` (StatelessWidget)**  
  - Menampilkan grid kategori (Belanja, Gaji, dsb.) dengan ikon dan warna.
  - Bisa memanggil callback seperti `onAddTransaction` (bergantung implementasi) untuk aksi cepat dari kategori tertentu.

### `lib/widgets/profile_modal.dart`
- **`ProfileModal` (StatefulWidget, Bottom Sheet)**  
  - Berisi:
    - Informasi user (Admin, email, status Premium).
    - Tombol/setting:
      - **Toggle Tema**: switch yang memanggil `ThemeProvider.toggleTheme()`.
      - **Export Data** (placeholder, belum diimplementasi → menampilkan SnackBar info).
      - **Tentang Aplikasi** → membuka dialog `AlertDialog` dengan `showGeneralDialog` + animasi fade/scale.
    - Tombol **Logout**:
      - Menutup modal.
      - Memanggil `AuthProvider.logout()` → kembali ke `LoginPage` lewat `_AuthGate`.
  - Konten body dibungkus `SingleChildScrollView` + `Expanded` agar:
    - Bisa di-scroll jika tinggi layar kecil.
    - Menghindari error overflow di bagian bawah.

### `lib/widgets/responsive_widgets.dart`
- Kumpulan widget/helper untuk **responsivitas**, misalnya:
  - Mengatur layout berbeda di layar kecil vs besar.
  - Membungkus widget supaya tetap nyaman dipakai di mobile, tablet, maupun desktop.

---

## 7. Utils

### `lib/utils/responsive_utils.dart`
- Fungsi bantuan terkait responsivitas:
  - Misalnya cek breakpoint (mobile / tablet / desktop) berdasarkan lebar layar.
  - Membantu menentukan padding, grid count, atau layout berbeda sesuai ukuran device.

---

## 8. Alur Utama Aplikasi (Ringkas)

1. **Aplikasi dimulai** → `main()` menjalankan `MyApp`.
2. `AuthProvider` mulai inisialisasi (simulasi loading ±2 detik) → `_AuthGate` menampilkan `LoadingPage`.
3. Setelah loading selesai:
   - Jika belum login → `_AuthGate` menampilkan `LoginPage`.
   - User memasukkan email & password admin → `AuthProvider.login()`:
     - Jika sukses → `_AuthGate` menampilkan `HomePage`.
4. Di `HomePage`, user bisa:
   - Menambah transaksi lewat `AddTransactionModal`.
   - Melihat & menghapus history lewat `CategoryHistoryModal` (dengan konfirmasi dua kali).
   - Mengatur tema & logout dari `ProfileModal`.
5. Saat logout:
   - `AuthProvider.logout()` dipanggil → `_AuthGate` kembali ke `LoginPage`.

---

Jika nanti Anda menambahkan fitur baru (misalnya export data, multi-user, atau integrasi backend), file ini bisa diperbarui sebagai dokumentasi singkat agar struktur tetap mudah dipahami. 


