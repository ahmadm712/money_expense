import 'package:flutter/material.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/helpers/category_icon_helper.dart';
import 'package:money_expense/styles.dart';

class CategoryExpenseCard extends StatelessWidget {
  final String category;
  final double amount;

  const CategoryExpenseCard({
    super.key,
    required this.category,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppDimensions.categoryIconWidth,
            height: AppDimensions.categoryIconHeight,
            padding: EdgeInsets.all(AppDimensions.categoryIconPadding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CategoryIconHelper.getCategoryColor(
                category,
              ),
            ),
            child: CategoryIconHelper.buildCategoryIcon(
              category,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category,
            style: AppStyles.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            formatRupiah(amount),
            style: AppStyles.bodyBold.merge(TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
