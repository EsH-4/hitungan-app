# Fitur History Transaksi Per Kategori

## Deskripsi
Tombol floating action button (FAB) di kanan bawah telah diubah dari fungsi menambah transaksi menjadi menampilkan history transaksi per kategori dengan filter yang lengkap.

## Perubahan yang Dilakukan

### 1. FAB Baru
- **Icon**: Diubah dari `Icons.add` menjadi `Icons.history`
- **Fungsi**: Membuka modal history transaksi per kategori
- **Warna**: Tetap menggunakan warna primary

### 2. Tombol Add Transaction Baru
- **Lokasi**: Di header sebelah kanan (sebelum avatar)
- **Icon**: `Icons.add` dengan background primary
- **Fungsi**: Membuka modal untuk menambah transaksi baru
- **Styling**: Circular button dengan shadow

### 3. Modal History Transaksi
Modal baru dengan fitur lengkap:

#### Filter Kategori
- **Semua**: Menampilkan semua transaksi
- **Belanja**: Filter transaksi belanja
- **Gaji**: Filter transaksi gaji
- **Rumah**: Filter transaksi rumah
- **Transport**: Filter transaksi transport
- **Makanan**: Filter transaksi makanan
- **Kesehatan**: Filter transaksi kesehatan
- **Pendidikan**: Filter transaksi pendidikan
- **Lainnya**: Filter transaksi lainnya

#### Filter Tipe
- **Semua**: Menampilkan pemasukan dan pengeluaran
- **Pemasukan**: Hanya transaksi pemasukan
- **Pengeluaran**: Hanya transaksi pengeluaran

#### Summary Card
- **Total Transaksi**: Jumlah transaksi yang difilter
- **Total Jumlah**: Total nominal transaksi yang difilter

#### List Transaksi
- **Sorting**: Berdasarkan tanggal (terbaru dulu)
- **Card Design**: Setiap transaksi ditampilkan dalam card dengan:
  - Icon kategori dengan warna sesuai
  - Judul transaksi
  - Nama kategori
  - Tanggal transaksi
  - Jumlah dengan format Rupiah
  - Tipe transaksi (Pemasukan/Pengeluaran)
  - Menu aksi (Hapus)

#### Empty State
- Ditampilkan ketika tidak ada transaksi yang sesuai filter
- Icon dan pesan yang informatif

## Cara Penggunaan

### Mengakses History
1. Ketuk tombol history (icon history) di kanan bawah
2. Modal history akan terbuka
3. Gunakan filter kategori dan tipe untuk menyaring transaksi
4. Lihat summary total transaksi dan jumlah

### Menambah Transaksi Baru
1. Ketuk tombol plus (+) di header sebelah kanan
2. Modal add transaction akan terbuka
3. Isi form dan submit

### Menghapus Transaksi
1. Buka history modal
2. Ketuk menu tiga titik (⋮) pada transaksi yang ingin dihapus
3. Pilih "Hapus"
4. Transaksi akan dihapus dan balance terupdate

## Keunggulan Fitur
- **Filter Fleksibel**: Bisa filter berdasarkan kategori dan tipe
- **Summary Real-time**: Total transaksi dan jumlah terupdate otomatis
- **UI Konsisten**: Menggunakan design system yang sama
- **Responsive**: Modal menyesuaikan tinggi layar
- **User Friendly**: Interface yang mudah dipahami dan digunakan
