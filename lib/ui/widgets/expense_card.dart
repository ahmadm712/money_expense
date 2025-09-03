import 'package:flutter/material.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/helpers/category_icon_helper.dart';
import 'package:money_expense/styles.dart';

class ExpenseCard extends StatelessWidget {
  final Color iconColor;
  final String category;
  final Color iconBgColor;
  final String title;
  final double amount;
  final VoidCallback? onTap;

  const ExpenseCard({
    super.key,
    required this.category,
    required this.title,
    required this.amount,
    this.iconColor = const Color(0xFFFECC47),
    this.iconBgColor = const Color(0x1AFECC47),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 67,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: CategoryIconHelper.buildCategoryIcon(
                category,
                iconColor: CategoryIconHelper.getCategoryColor(category),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkGrey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              formatRupiah(amount),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
