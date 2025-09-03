import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/providers/expense_provider.dart';
import 'package:money_expense/styles.dart';
import 'package:money_expense/ui/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final expenseProvider = ExpenseProvider();
  await expenseProvider.init();
  if (kDebugMode) avoidErrorMouseUsed();

  runApp(
    ChangeNotifierProvider.value(
      value: expenseProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Expense',
      theme: appThemeData,
      home: const HomePage(),
    );
  }
}
