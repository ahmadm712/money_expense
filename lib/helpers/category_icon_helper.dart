import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_expense/styles.dart';

class CategoryIconHelper {
  static String getIconPath(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return 'assets/icons/ic_food_category.svg';
      case 'internet':
        return 'assets/icons/ic_internet_category.svg';
      case 'edukasi':
        return 'assets/icons/ic_education_category.svg';
      case 'hadiah':
        return 'assets/icons/ic_gift_category.svg';
      case 'transport':
        return 'assets/icons/ic_transport_category.svg';
      case 'belanja':
        return 'assets/icons/ic_shop_category.svg';
      case 'alat rumah':
        return 'assets/icons/ic_home_category.svg';
      case 'olahraga':
        return 'assets/icons/ic_sport_category.svg';
      case 'hiburan':
        return 'assets/icons/ic_entertainment_category.svg';
      default:
        return 'assets/icons/ic_food_category.svg';
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'makanan':
        return AppColors.foodCategory;
      case 'internet':
        return AppColors.internetCategory;
      case 'edukasi':
        return AppColors.educationCategory;
      case 'hadiah':
        return AppColors.giftCategory;
      case 'transport':
        return AppColors.transportCategory;
      case 'belanja':
        return AppColors.shopCategory;
      case 'alat rumah':
        return AppColors.homeCategory;
      case 'olahraga':
        return AppColors.sportCategory;
      case 'hiburan':
        return AppColors.entertainmentCategory;
      default:
        return AppColors.foodCategory;
    }
  }

  static Widget buildCategoryIcon(
    String category, {
    double size = 24,
    Color? iconColor,
  }) {
    try {
      return SvgPicture.asset(
        getIconPath(category),
        width: size,
        height: size,
        fit: BoxFit.cover,
        colorFilter: iconColor == null
            ? null
            : ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    } catch (e) {
      return Icon(
        Icons.category,
        size: size,
        color: Colors.grey,
      );
    }
  }
}
