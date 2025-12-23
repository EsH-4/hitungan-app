import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../models/transaction.dart';

class CategoryGrid extends StatefulWidget {
  final Function(Transaction) onAddTransaction;
  
  const CategoryGrid({
    Key? key,
    required this.onAddTransaction,
  }) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {

  final List<Map<String, dynamic>> categories = const [
    {
      'icon': Icons.shopping_cart,
      'title': 'Belanja',
      'color': Color(0xFF4CAF50),
    },
    {
      'icon': Icons.attach_money,
      'title': 'Gaji',
      'color': Color(0xFF2196F3),
    },
    {
      'icon': Icons.home,
      'title': 'Rumah',
      'color': Color(0xFFFF9800),
    },
    {
      'icon': Icons.directions_car,
      'title': 'Transport',
      'color': Color(0xFF9C27B0),
    },
    {
      'icon': Icons.restaurant,
      'title': 'Makanan',
      'color': Color(0xFFF44336),
    },
    {
      'icon': Icons.health_and_safety,
      'title': 'Kesehatan',
      'color': Color(0xFF00BCD4),
    },
    {
      'icon': Icons.school,
      'title': 'Pendidikan',
      'color': Color(0xFF795548),
    },
    {
      'icon': Icons.more_horiz,
      'title': 'Lainnya',
      'color': Color(0xFF607D8B),
    },
  ];

  void _showQuickAddModal(String category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickAddTransactionModal(
        category: category,
        onAddTransaction: widget.onAddTransaction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Kategori',
            style: AppTextStyles.header4,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: categories.map((category) {
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                child: _buildCategoryItem(
                  context,
                  category['icon'] as IconData,
                  category['title'] as String,
                  category['color'] as Color,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, IconData icon, String title, Color color) {
    return GestureDetector(
      onTap: () => _showQuickAddModal(title),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAddTransactionModal extends StatefulWidget {
  final String category;
  final Function(Transaction) onAddTransaction;

  const _QuickAddTransactionModal({
    Key? key,
    required this.category,
    required this.onAddTransaction,
  }) : super(key: key);

  @override
  State<_QuickAddTransactionModal> createState() => _QuickAddTransactionModalState();
}

class _QuickAddTransactionModalState extends State<_QuickAddTransactionModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  TransactionType _selectedType = TransactionType.expense;
  DateTime _selectedDate = DateTime.now();

  // Mapping kategori ke icon dan warna
  final Map<String, Map<String, dynamic>> _categoryData = {
    'Belanja': {
      'icon': Icons.shopping_cart,
      'color': Color(0xFF4CAF50),
      'defaultTitle': 'Belanja',
    },
    'Gaji': {
      'icon': Icons.attach_money,
      'color': Color(0xFF2196F3),
      'defaultTitle': 'Gaji',
    },
    'Rumah': {
      'icon': Icons.home,
      'color': Color(0xFFFF9800),
      'defaultTitle': 'Biaya Rumah',
    },
    'Transport': {
      'icon': Icons.directions_car,
      'color': Color(0xFF9C27B0),
      'defaultTitle': 'Transportasi',
    },
    'Makanan': {
      'icon': Icons.restaurant,
      'color': Color(0xFFF44336),
      'defaultTitle': 'Makanan',
    },
    'Kesehatan': {
      'icon': Icons.health_and_safety,
      'color': Color(0xFF00BCD4),
      'defaultTitle': 'Kesehatan',
    },
    'Pendidikan': {
      'icon': Icons.school,
      'color': Color(0xFF795548),
      'defaultTitle': 'Pendidikan',
    },
    'Lainnya': {
      'icon': Icons.more_horiz,
      'color': Color(0xFF607D8B),
      'defaultTitle': 'Lainnya',
    },
  };

  @override
  void initState() {
    super.initState();
    // Set default title berdasarkan kategori
    final categoryData = _categoryData[widget.category];
    if (categoryData != null) {
      _titleController.text = categoryData['defaultTitle'];
    }
    
    // Set default type berdasarkan kategori
    if (widget.category == 'Gaji') {
      _selectedType = TransactionType.income;
    } else {
      _selectedType = TransactionType.expense;
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final transaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        type: _selectedType,
        category: widget.category,
        description: _descriptionController.text.isEmpty 
            ? null 
            : _descriptionController.text,
      );

      widget.onAddTransaction(transaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryData = _categoryData[widget.category] ?? _categoryData['Lainnya']!;
    final categoryColor = categoryData['color'] as Color;
    final categoryIcon = categoryData['icon'] as IconData;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Category Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      categoryIcon,
                      color: categoryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tambah Transaksi',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                        Text(
                          'Kategori: ${widget.category}',
                          style: TextStyle(
                            fontSize: 16,
                            color: categoryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Type Selection (hanya untuk kategori non-Gaji)
              if (widget.category != 'Gaji') ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildTypeButton(
                        'Pengeluaran',
                        TransactionType.expense,
                        categoryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTypeButton(
                        'Pemasukan',
                        TransactionType.income,
                        categoryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Judul Transaksi',
                  labelStyle: TextStyle(
                    color: const Color(0xFF666666),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: categoryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan judul transaksi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Amount Field
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  labelStyle: TextStyle(
                    color: const Color(0xFF666666),
                  ),
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: categoryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan jumlah';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harap masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Date Picker
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    labelStyle: TextStyle(
                      color: const Color(0xFF666666),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: categoryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF666666),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Description Field
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Deskripsi (Opsional)',
                  labelStyle: TextStyle(
                    color: const Color(0xFF666666),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: categoryColor),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: categoryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Tambah Transaksi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(String text, TransactionType type, Color categoryColor) {
    final isSelected = _selectedType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected
              ? type == TransactionType.income
                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                  : const Color(0xFFF44336).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? type == TransactionType.income
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFF44336)
                : const Color(0xFFE0E0E0),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? type == TransactionType.income
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFF44336)
                  : const Color(0xFF666666),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}