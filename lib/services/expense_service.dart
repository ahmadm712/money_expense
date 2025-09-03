import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_expense/models/expense.dart';
import 'package:uuid/uuid.dart';

class ExpenseService {
  static const String boxName = 'expenses';
  late Box<Expense> _expenseBox;

  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ExpenseAdapter());

    _expenseBox = await Hive.openBox<Expense>(boxName);
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    required String category,
  }) async {
    final expense = Expense(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    await _expenseBox.add(expense);
  }

  Future<void> updateExpense({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    required String category,
  }) async {
    final index =
        _expenseBox.values.toList().indexWhere((expense) => expense.id == id);
    if (index != -1) {
      final expense = _expenseBox.getAt(index)!;
      expense.title = title;
      expense.amount = amount;
      expense.date = date;
      expense.category = category;
      await expense.save();
    }
  }

  Future<void> deleteExpense(String id) async {
    final index =
        _expenseBox.values.toList().indexWhere((expense) => expense.id == id);
    if (index != -1) {
      await _expenseBox.deleteAt(index);
    }
  }

  double getTotalExpensesToday() {
    final today = DateTime.now();
    return _expenseBox.values
        .where((expense) =>
            expense.date.day == today.day &&
            expense.date.month == today.month &&
            expense.date.year == today.year)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double getTotalExpensesYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return _expenseBox.values
        .where((expense) =>
            expense.date.day == yesterday.day &&
            expense.date.month == yesterday.month &&
            expense.date.year == yesterday.year)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double getTotalExpensesThisMonth() {
    final today = DateTime.now();
    return _expenseBox.values
        .where((expense) =>
            expense.date.month == today.month &&
            expense.date.year == today.year)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  List<Expense> getAllExpenses() {
    final list = _expenseBox.values.toList();
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  List<Expense> getTodayExpenses() {
    final today = DateTime.now();
    final list = _expenseBox.values
        .where((expense) =>
            expense.date.day == today.day &&
            expense.date.month == today.month &&
            expense.date.year == today.year)
        .toList();

    list.sort((a, b) => b.date.compareTo(a.date));
    return list.reversed.toList();
  }

  List<Expense> getYesterdayExpenses() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final list = _expenseBox.values
        .where((expense) =>
            expense.date.day == yesterday.day &&
            expense.date.month == yesterday.month &&
            expense.date.year == yesterday.year)
        .toList();

    list.sort((a, b) => b.date.compareTo(a.date));
    return list.reversed.toList();
  }

  Map<String, double> getExpensesByCategory() {
    final Map<String, double> categoryTotals = {};

    final sortedExpenses = _expenseBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    for (var expense in sortedExpenses) {
      categoryTotals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return categoryTotals;
  }
}
