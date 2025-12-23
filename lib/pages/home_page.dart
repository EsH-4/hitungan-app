import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../styles/app_decorations.dart';
import '../models/transaction.dart';
import '../widgets/transaction_card.dart';
import '../widgets/balance_card.dart';
import '../widgets/category_grid.dart';
import '../widgets/add_transaction_modal.dart';
import '../widgets/category_history_modal.dart';
import '../widgets/profile_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Transaction> transactions = [];
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double balance = 0.0;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    
    // Data contoh
    _loadSampleData();
  }

  void _loadSampleData() {
    setState(() {
      transactions = [
        Transaction(
          id: '1',
          title: 'Gaji Bulanan',
          amount: 15000000,
          date: DateTime.now().subtract(const Duration(days: 2)),
          type: TransactionType.income,
          category: 'Gaji',
        ),
        Transaction(
          id: '2',
          title: 'Bayar Listrik',
          amount: 750000,
          date: DateTime.now().subtract(const Duration(days: 1)),
          type: TransactionType.expense,
          category: 'Utilities',
        ),
        Transaction(
          id: '3',
          title: 'Beli Alat Kantor',
          amount: 1200000,
          date: DateTime.now(),
          type: TransactionType.expense,
          category: 'Peralatan',
        ),
      ];
      _calculateTotals();
    });
  }

  void _calculateTotals() {
    totalIncome = transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    totalExpense = transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    balance = totalIncome - totalExpense;
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      transactions.insert(0, transaction);
      _calculateTotals();
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((t) => t.id == id);
      _calculateTotals();
    });
  }

  void _showAddTransactionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTransactionModal(
        onAddTransaction: _addTransaction,
      ),
    );
  }

  void _showCategoryHistoryModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CategoryHistoryModal(
        transactions: transactions,
        onDeleteTransaction: (transaction) => _deleteTransaction(transaction.id),
      ),
    );
  }

  void _showProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ProfileModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _buildSimpleLayout(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCategoryHistoryModal,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.history, color: Colors.white),
      ),
    );
  }

  Widget _buildSimpleLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            BalanceCard(
              balance: balance,
              income: totalIncome,
              expense: totalExpense,
              fadeAnimation: _fadeAnimation,
            ),
            const SizedBox(height: 16),
            CategoryGrid(
              onAddTransaction: _addTransaction,
            ),
            const SizedBox(height: 16),
            _buildTransactions(),
            const SizedBox(height: 100), // Space untuk FAB
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, Admin!',
                style: AppTextStyles.header2,
              ),
              Text(
                'Kelola keuangan dengan bijak',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).cardColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _showAddTransactionModal,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _showProfileModal,
              child: Container(
                width: 50,
                height: 50,
                decoration: AppDecorations.avatar,
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: AppColors.textWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.card,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi Terbaru',
                style: AppTextStyles.header4,
              ),
              Text(
                '${transactions.length} transaksi',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          transactions.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      transaction: transactions[index],
                      onDelete: _deleteTransaction,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          child: const Icon(
            Icons.receipt_long,
            size: 80,
            color: AppColors.textDisabled,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Belum ada transaksi',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}