import 'package:flutter/material.dart';
import 'package:money_expense/constants/string_constant.dart';

class AppColors {
  static const Color primary = Color(0xFF0A97B0);
  static const Color secondary = Color(0xFF46B5A7);
  static const Color white = Colors.white;
  static const Color grey = Color(0xffE0E0E0);
  static const Color grey3 = Color(0xff828282);
  static const Color grey4 = Color(0xffBDBDBD);
  static const Color grey5 = Color(0xffE0E0E0);
  static const Color foodCategory = Color(0xffF2C94C);
  static const Color internetCategory = Color(0xff56CCF2);
  static const Color educationCategory = Color(0xffF2994A);
  static const Color giftCategory = Color(0xffEB5757);
  static const Color transportCategory = Color(0xff9B51E0);
  static const Color darkGrey = Color(0xff333333);
  static const Color shopCategory = Color(0xff27AE60);
  static const Color homeCategory = Color(0xffBB6BD9);
  static const Color sportCategory = Color(0xff2D9CDB);
  static const Color entertainmentCategory = Color(0xff2F80ED);
}

class AppStyles {
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontFamily: SOURCESANSPRO,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: SOURCESANSPRO,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: SOURCESANSPRO,
  );
}

class AppDimensions {
  static const double categoryIconWidth = 36.0;
  static const double categoryIconHeight = 36.0;
  static const double categoryIconPadding = 6.0;
}

// THEME DATA
final appThemeData = ThemeData(
  fontFamily: SOURCESANSPRO,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
  ),
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: const TextStyle(
        fontFamily: SOURCESANSPRO,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    titleTextStyle: TextStyle(
      fontFamily: SOURCESANSPRO,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.darkGrey,
    ),
    centerTitle: true,
  ),
  textTheme: TextTheme(
    titleLarge: AppStyles.titleLarge,
    titleMedium: AppStyles.titleMedium,
    bodyMedium: AppStyles.bodyMedium,
  ),
);
