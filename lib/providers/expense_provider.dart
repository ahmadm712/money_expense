import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_expense/models/expense.dart';
import 'package:money_expense/services/expense_service.dart';

class ExpenseProvider with ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  Box<dynamic>? _prefs;

  Future<void> init() async {
    await _expenseService.init();

    _prefs ??= await Hive.openBox('app_prefs');

    final alreadyInitialized =
        _prefs!.get('is_initialized', defaultValue: false) as bool;

    if (!alreadyInitialized) {
      await _addSampleData();
      await _prefs!.put('is_initialized', true);
    }

    notifyListeners();
  }

  Future<void> _addSampleData() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    await _expenseService.addExpense(
      title: 'Makan Siang',
      amount: 25000,
      date: now,
      category: 'Makanan',
    );

    await _expenseService.addExpense(
      title: 'Bensin',
      amount: 50000,
      date: now,
      category: 'Transport',
    );

    await _expenseService.addExpense(
      title: 'Belanja Bulanan',
      amount: 150000,
      date: yesterday,
      category: 'Belanja',
    );

    await _expenseService.addExpense(
      title: 'Langganan Netflix',
      amount: 120000,
      date: yesterday,
      category: 'Hiburan',
    );
  }

  double get totalExpensesToday => _expenseService.getTotalExpensesToday();
  double get totalExpensesYesterday =>
      _expenseService.getTotalExpensesYesterday();
  double get totalExpensesThisMonth =>
      _expenseService.getTotalExpensesThisMonth();

  List<Expense> get allExpenses => _expenseService.getAllExpenses();
  List<Expense> get todayExpenses => _expenseService.getTodayExpenses();
  List<Expense> get yesterdayExpenses => _expenseService.getYesterdayExpenses();

  Map<String, double> get expensesByCategory =>
      _expenseService.getExpensesByCategory();

  Future<void> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String category,
  }) async {
    await _expenseService.addExpense(
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    notifyListeners();
  }

  Future<void> updateExpense({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    required String category,
  }) async {
    await _expenseService.updateExpense(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
    );
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    await _expenseService.deleteExpense(id);
    notifyListeners();
  }
}
