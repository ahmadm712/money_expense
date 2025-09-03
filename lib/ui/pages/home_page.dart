import 'package:flutter/material.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/providers/expense_provider.dart';
import 'package:money_expense/styles.dart';
import 'package:money_expense/ui/pages/form_expense_page.dart';
import 'package:money_expense/ui/widgets/category_expense_card.dart';
import 'package:money_expense/ui/widgets/expense_card.dart';
import 'package:money_expense/ui/widgets/expense_total_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.all(16),
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpenseFormPage(),
              ),
            );
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(), // biar bulat sempurna
          elevation: 2, // bisa atur shadow
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 24, // biar pas di dalam 44x44
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0 + getMediaQuery(context).padding.top,
          bottom: 16.0 + getMediaQuery(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, User!',
              style: AppStyles.titleLarge,
            ),
            Text(
              'Jangan lupa catat keuanganmu setiap hari!',
              style: AppStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, child) {
                return Row(
                  children: [
                    Expanded(
                      child: ExpenseTotalCard(
                        title: 'Pengeluaranmu hari ini',
                        amount: expenseProvider.totalExpensesToday,
                        icon: Icons.today,
                        iconColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ExpenseTotalCard(
                        title: 'Pengeluaranmu bulan ini',
                        amount: expenseProvider.totalExpensesThisMonth,
                        icon: Icons.calendar_month,
                        iconColor: AppColors.secondary,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Pengeluaran berdasarkan kategori',
              style: AppStyles.bodyBold,
            ),
            const SizedBox(height: 16),
            Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, child) {
                final categoryExpenses = expenseProvider.expensesByCategory;
                if (categoryExpenses.isEmpty) {
                  return const Center(
                    child: Text('Belum ada pengeluaran'),
                  );
                }

                return SizedBox(
                  height: 140,
                  child: ListView.builder(
                    padding: EdgeInsets.all(6),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categoryExpenses.length,
                    itemBuilder: (context, index) {
                      final category = categoryExpenses.keys.elementAt(index);
                      final amount = categoryExpenses[category]!;
                      return CategoryExpenseCard(
                        category: category,
                        amount: amount,
                      );
                    },
                  ),
                );
              },
            ),
            Consumer<ExpenseProvider>(
              builder: (context, expenseProvider, child) {
                final todayExpenses = expenseProvider.todayExpenses;
                final yesterdayExpenses = expenseProvider.yesterdayExpenses;

                if (todayExpenses.isEmpty && yesterdayExpenses.isEmpty) {
                  return const Center(
                    child: Text('Belum ada pengeluaran'),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    if (todayExpenses.isNotEmpty) ...[
                      Text(
                        'Hari Ini',
                        style: AppStyles.bodyBold,
                      ),
                      const SizedBox(height: 20),
                      ...todayExpenses.map((expense) {
                        return ExpenseCard(
                          title: expense.title,
                          amount: expense.amount,
                          category: expense.category,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpenseFormPage(
                                  expense: expense,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                    if (yesterdayExpenses.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Kemarin',
                        style: AppStyles.bodyBold,
                      ),
                      const SizedBox(height: 8),
                      ...yesterdayExpenses.map((expense) {
                        return ExpenseCard(
                          title: expense.title,
                          amount: expense.amount,
                          category: expense.category,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExpenseFormPage(
                                  expense: expense,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
