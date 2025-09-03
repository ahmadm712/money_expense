import 'package:flutter/material.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/styles.dart';

class ExpenseTotalCard extends StatelessWidget {
  final String title;
  final double amount;
  final IconData icon;
  final Color iconColor;

  const ExpenseTotalCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: iconColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.titleMedium.apply(color: AppColors.white),
            ),
            const SizedBox(height: 14),
            Text(
              formatRupiah(amount),
              style: AppStyles.titleLarge.apply(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
