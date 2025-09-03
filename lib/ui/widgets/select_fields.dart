import 'package:flutter/material.dart';
import 'package:money_expense/helpers/category_icon_helper.dart';
import 'package:money_expense/styles.dart';

class SelectFieldTile extends StatelessWidget {
  final String valueText;
  final IconData trailingIcon;
  final VoidCallback onTap;
  final Color labelColor;
  final Color valueColor;
  final bool isCategory;

  const SelectFieldTile({
    super.key,
    this.isCategory = false,
    required this.valueText,
    required this.onTap,
    this.trailingIcon = Icons.chevron_right_rounded,
    this.labelColor = const Color(0xFF0A97B0),
    this.valueColor = const Color(0xFF46B5A7),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: AppColors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isCategory,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: CategoryIconHelper.buildCategoryIcon(
                        valueText,
                        iconColor:
                            CategoryIconHelper.getCategoryColor(valueText),
                      ),
                    ),
                  ),
                  Text(valueText, style: AppStyles.bodyMedium),
                ],
              ),
            ),
            Container(
              decoration: isCategory
                  ? BoxDecoration(
                      color: AppColors.grey5, shape: BoxShape.circle)
                  : null,
              child: Center(child: Icon(trailingIcon, color: AppColors.grey3)),
            ),
          ],
        ),
      ),
    );
  }
}
