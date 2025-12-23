import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../models/transaction.dart';

class CategoryHistoryModal extends StatefulWidget {
  final List<Transaction> transactions;
  final Function(Transaction) onDeleteTransaction;

  const CategoryHistoryModal({
    Key? key,
    required this.transactions,
    required this.onDeleteTransaction,
  }) : super(key: key);

  @override
  State<CategoryHistoryModal> createState() => _CategoryHistoryModalState();
}

class _CategoryHistoryModalState extends State<CategoryHistoryModal> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'Semua';
  TransactionType? _selectedType;
  late List<Transaction> _localTransactions;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _localTransactions = List<Transaction>.from(widget.transactions);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _animationController.forward();
  }

  // Mapping kategori ke icon dan warna
  final Map<String, Map<String, dynamic>> _categoryData = {
    'Semua': {
      'icon': Icons.list,
      'color': Color(0xFF607D8B),
    },
    'Belanja': {
      'icon': Icons.shopping_cart,
      'color': Color(0xFF4CAF50),
    },
    'Gaji': {
      'icon': Icons.attach_money,
      'color': Color(0xFF2196F3),
    },
    'Rumah': {
      'icon': Icons.home,
      'color': Color(0xFFFF9800),
    },
    'Transport': {
      'icon': Icons.directions_car,
      'color': Color(0xFF9C27B0),
    },
    'Makanan': {
      'icon': Icons.restaurant,
      'color': Color(0xFFF44336),
    },
    'Kesehatan': {
      'icon': Icons.health_and_safety,
      'color': Color(0xFF00BCD4),
    },
    'Pendidikan': {
      'icon': Icons.school,
      'color': Color(0xFF795548),
    },
    'Lainnya': {
      'icon': Icons.more_horiz,
      'color': Color(0xFF607D8B),
    },
  };

  List<String> get _categories => _categoryData.keys.toList();

  List<Transaction> get _filteredTransactions {
    List<Transaction> filtered = List<Transaction>.from(_localTransactions);
    
    if (_selectedCategory != 'Semua') {
      filtered = filtered.where((t) => t.category == _selectedCategory).toList();
    }
    
    if (_selectedType != null) {
      filtered = filtered.where((t) => t.type == _selectedType).toList();
    }
    
    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    
    return filtered;
  }

  double get _totalAmount {
    return _filteredTransactions.fold(0.0, (sum, t) => sum + t.amount);
  }

  void _handleDelete(Transaction transaction) {
    setState(() {
      _localTransactions.removeWhere((t) => t.id == transaction.id);
    });
    widget.onDeleteTransaction(transaction);
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final first = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus transaksi?'),
        content: const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );

    if (first != true) return false;

    final second = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yakin?'),
        content: const Text('Tindakan ini tidak bisa dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, hapus'),
          ),
        ],
      ),
    );

    return second == true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Handle bar
              Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'History Transaksi',
                      style: AppTextStyles.header3,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              
              // Filter Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                // Category Filter
                Row(
                  children: [
                    Text(
                      'Kategori:',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            final categoryData = _categoryData[category]!;
                            final color = categoryData['color'] as Color;
                            
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                backgroundColor: color.withOpacity(0.1),
                                selectedColor: color.withOpacity(0.2),
                                checkmarkColor: color,
                                labelStyle: TextStyle(
                                  color: isSelected ? color : AppColors.textSecondary,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Type Filter
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Tipe:',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FilterChip(
                      label: const Text('Semua'),
                      selected: _selectedType == null,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = null;
                        });
                      },
                    ),
                    FilterChip(
                      label: const Text('Pemasukan'),
                      selected: _selectedType == TransactionType.income,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = selected ? TransactionType.income : null;
                        });
                      },
                      backgroundColor: const Color(0xFF4CAF50).withOpacity(0.1),
                      selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
                      checkmarkColor: const Color(0xFF4CAF50),
                    ),
                    FilterChip(
                      label: const Text('Pengeluaran'),
                      selected: _selectedType == TransactionType.expense,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = selected ? TransactionType.expense : null;
                        });
                      },
                      backgroundColor: const Color(0xFFF44336).withOpacity(0.1),
                      selectedColor: const Color(0xFFF44336).withOpacity(0.2),
                      checkmarkColor: const Color(0xFFF44336),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Summary
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Transaksi',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            '${_filteredTransactions.length} transaksi',
                            style: AppTextStyles.header4,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total Jumlah',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'Rp ${_totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                            style: AppTextStyles.header4.copyWith(
                              color: _totalAmount >= 0 ? AppColors.success : AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Transactions List
              Expanded(
                child: _filteredTransactions.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = _filteredTransactions[index];
                          return _buildTransactionItem(transaction);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final categoryData = _categoryData[transaction.category] ?? _categoryData['Lainnya']!;
    final color = categoryData['color'] as Color;
    final icon = categoryData['icon'] as IconData;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction.type == TransactionType.income ? '+' : '-'}Rp ${transaction.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: transaction.type == TransactionType.income 
                      ? AppColors.success 
                      : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.type == TransactionType.income ? 'Pemasukan' : 'Pengeluaran',
                style: AppTextStyles.caption.copyWith(
                  color: transaction.type == TransactionType.income 
                      ? AppColors.success 
                      : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _confirmDelete(context).then((confirmed) {
                  if (confirmed) {
                    _handleDelete(transaction);
                  }
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Hapus'),
                  ],
                ),
              ),
            ],
            child: const Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.receipt_long,
              size: 40,
              color: AppColors.textDisabled,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada transaksi',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai tambahkan transaksi untuk melihat history',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
