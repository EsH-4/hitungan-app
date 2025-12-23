# Konfigurasi Aplikasi

Direktori ini berisi semua konfigurasi dan konstanta yang digunakan dalam aplikasi.

## Struktur File

### `app_colors.dart`
Berisi semua definisi warna yang digunakan dalam aplikasi:
- Primary colors (hijau)
- Background colors
- Text colors
- Status colors (success, error, warning)
- Border dan shadow colors
- Gradient colors

### `app_dimensions.dart`
Berisi semua konstanta dimensi:
- Padding dan margin
- Border radius
- Icon sizes
- Button heights
- Container sizes
- Shadow properties

### `app_theme.dart`
Konfigurasi theme utama aplikasi yang menggunakan:
- AppColors untuk color scheme
- AppDimensions untuk spacing dan sizing
- AppTextStyles untuk typography
- AppDecorations untuk styling

## Penggunaan

```dart
// Import yang diperlukan
import '../config/app_colors.dart';
import '../config/app_dimensions.dart';
import '../styles/app_text_styles.dart';
import '../styles/app_decorations.dart';

// Contoh penggunaan
Container(
  padding: const EdgeInsets.all(AppDimensions.paddingL),
  decoration: AppDecorations.card,
  child: Text(
    'Hello World',
    style: AppTextStyles.header2,
  ),
)
```

## Keuntungan

1. **Konsistensi**: Semua style menggunakan konstanta yang sama
2. **Maintainability**: Mudah mengubah style di satu tempat
3. **Reusability**: Style bisa digunakan ulang di berbagai widget
4. **Readability**: Code lebih mudah dibaca dan dipahami
5. **Scalability**: Mudah menambah style baru
