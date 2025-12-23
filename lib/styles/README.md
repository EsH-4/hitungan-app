# Styles

Direktori ini berisi semua definisi style yang digunakan dalam aplikasi.

## Struktur File

### `app_text_styles.dart`
Berisi semua definisi text style:
- Headers (header1, header2, header3, header4)
- Body text (bodyLarge, bodyMedium, bodySmall)
- Labels (labelLarge, labelMedium, labelSmall)
- Button text (buttonLarge, buttonMedium, buttonSmall)
- Special text styles (balanceAmount, currency, dll)
- Status text (success, error, warning)

### `app_decorations.dart`
Berisi semua definisi decoration:
- Card decorations (card, cardHover, primaryCard)
- Button decorations (primaryButton, secondaryButton)
- Input decorations (inputField, inputFieldFocused)
- Icon containers (iconContainer, iconContainerSuccess, dll)
- Special decorations (avatar, bottomSheet, transactionCard)

## Penggunaan

```dart
// Text Style
Text(
  'Title',
  style: AppTextStyles.header2,
)

// Decoration
Container(
  decoration: AppDecorations.card,
  child: Text('Content'),
)

// Icon Container
Container(
  decoration: AppDecorations.iconContainerSuccess,
  child: Icon(Icons.check),
)
```

## Keuntungan

1. **Konsistensi Visual**: Semua text dan decoration menggunakan style yang sama
2. **Easy Maintenance**: Mudah mengubah style di satu tempat
3. **Brand Consistency**: Mempertahankan konsistensi brand
4. **Code Reusability**: Style bisa digunakan ulang
5. **Design System**: Membuat design system yang terstruktur
