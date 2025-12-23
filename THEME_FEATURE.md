# Fitur Tema Dark/Light Mode

## Deskripsi
Aplikasi sekarang mendukung perubahan tema antara mode terang (light) dan mode gelap (dark) melalui switch di modal profil.

## Implementasi

### 1. Theme Provider
- **File**: `lib/providers/theme_provider.dart`
- **Fungsi**: Mengelola state tema aplikasi
- **Method**:
  - `toggleTheme()`: Mengubah tema
  - `setTheme(bool)`: Set tema secara langsung
  - `isDarkMode`: Getter untuk status tema
  - `themeMode`: Getter untuk ThemeMode

### 2. App Theme Configuration
- **File**: `lib/config/app_theme.dart`
- **Light Theme**: Tema terang dengan warna-warna cerah
- **Dark Theme**: Tema gelap dengan warna-warna yang lebih gelap
- **Konsistensi**: Menggunakan design system yang sama untuk kedua tema

### 3. Profile Modal
- **File**: `lib/widgets/profile_modal.dart`
- **Fitur**:
  - Switch tema dengan toggle yang responsif
  - Informasi profil pengguna
  - Pengaturan notifikasi
  - Export data (placeholder)
  - Tentang aplikasi
  - Logout

### 4. Main App Integration
- **File**: `lib/main.dart`
- **Provider**: Menggunakan ChangeNotifierProvider untuk ThemeProvider
- **Consumer**: Menggunakan Consumer untuk mendengarkan perubahan tema
- **ThemeMode**: Otomatis berubah berdasarkan state provider

## Cara Penggunaan

### Mengakses Modal Profil
1. Ketuk avatar/ikon profil di kanan atas
2. Modal profil akan terbuka

### Mengubah Tema
1. Buka modal profil
2. Ketuk switch "Tema Aplikasi"
3. Tema akan berubah secara real-time
4. Modal akan menutup dan tema tetap tersimpan

## Warna Tema

### Light Mode
- **Background**: `#F5F5F5` (AppColors.background)
- **Surface**: `#FFFFFF` (AppColors.surface)
- **Text Primary**: `#1B1B1B` (AppColors.textPrimary)
- **Text Secondary**: `#666666` (AppColors.textSecondary)
- **Border**: `#E0E0E0` (AppColors.border)

### Dark Mode
- **Background**: `#121212` (Dark background)
- **Surface**: `#1E1E1E` (Dark surface)
- **Text Primary**: `#E0E0E0` (Light text)
- **Text Secondary**: `#B0B0B0` (Secondary light text)
- **Border**: `#404040` (Dark border)

## Komponen yang Mendukung Tema

### 1. Text Styles
- Semua text style otomatis menyesuaikan warna
- Header, body, label, dan caption text
- Menggunakan Google Fonts Poppins

### 2. Input Fields
- TextFormField dengan border yang sesuai tema
- Label dan hint text dengan warna yang tepat
- Focus state dengan warna primary

### 3. Cards dan Containers
- Background color yang sesuai tema
- Border color yang konsisten
- Shadow yang sesuai dengan tema

### 4. Buttons
- ElevatedButton, TextButton, OutlinedButton
- Warna yang konsisten dengan tema
- Hover dan press state

### 5. Icons
- Icon color yang sesuai dengan tema
- Primary dan secondary icon theme

## Keunggulan

### 1. Real-time Switching
- Perubahan tema langsung terlihat tanpa restart
- Smooth transition antar komponen

### 2. Konsistensi Design
- Menggunakan design system yang sama
- Warna yang harmonis untuk setiap tema

### 3. User Experience
- Mudah diakses melalui profil
- Visual feedback yang jelas
- Persistence state (tema tersimpan)

### 4. Accessibility
- Kontras yang baik untuk readability
- Warna yang tidak menyakitkan mata
- Support untuk preferensi sistem

## Technical Details

### State Management
- Menggunakan Provider pattern
- ChangeNotifier untuk reactive updates
- Consumer widget untuk UI updates

### Theme Data
- Material 3 design system
- Custom color scheme
- Consistent spacing dan typography

### Performance
- Lightweight theme switching
- No rebuild of entire app
- Efficient state updates
