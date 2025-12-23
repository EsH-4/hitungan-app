import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../styles/app_text_styles.dart';
import '../styles/app_decorations.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expense;
  final Animation<double> fadeAnimation;

  const BalanceCard({
    Key? key,
    required this.balance,
    required this.income,
    required this.expense,
    required this.fadeAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.primaryCard,
        child: _buildSimpleLayout(context, currencyFormat),
      ),
    );
  }

  Widget _buildSimpleLayout(BuildContext context, NumberFormat currencyFormat) {
    return Column(
      children: [
        Text(
          'Saldo Total',
          style: AppTextStyles.balanceLabel,
        ),
        const SizedBox(height: 8),
        Text(
          currencyFormat.format(balance),
          style: AppTextStyles.balanceAmount,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _buildIncomeExpenseItem(
                context,
                'Pemasukan',
                income,
                Icons.arrow_upward,
                AppColors.income,
                currencyFormat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildIncomeExpenseItem(
                context,
                'Pengeluaran',
                expense,
                Icons.arrow_downward,
                AppColors.expense,
                currencyFormat,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIncomeExpenseItem(
      BuildContext context, String title, double amount, IconData icon, Color color, NumberFormat currencyFormat) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.incomeExpenseLabel,
        ),
        const SizedBox(height: 4),
        Text(
          currencyFormat.format(amount),
          style: AppTextStyles.incomeExpenseAmount,
        ),
      ],
    );
  }
}