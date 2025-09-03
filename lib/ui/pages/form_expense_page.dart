import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/helpers/category_icon_helper.dart';
import 'package:money_expense/models/expense.dart';
import 'package:money_expense/providers/expense_provider.dart';
import 'package:money_expense/styles.dart';
import 'package:money_expense/ui/widgets/app_textfields.dart';
import 'package:money_expense/ui/widgets/select_fields.dart';
import 'package:provider/provider.dart';

class ExpenseFormPage extends StatefulWidget {
  final Expense? expense;

  const ExpenseFormPage({super.key, this.expense});

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  DateTime? _selectedDate;
  late String _selectedCategory;

  final List<String> _categories = [
    'Makanan',
    'Internet',
    'Edukasi',
    'Hadiah',
    'Transport',
    'Belanja',
    'Alat Rumah',
    'Olahraga',
    'Hiburan',
  ];

  bool get isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      _titleController = TextEditingController(text: widget.expense!.title);
      _amountController =
          TextEditingController(text: formatRupiah(widget.expense!.amount));
      _selectedDate = widget.expense!.date;
      _selectedCategory = widget.expense!.category;
    } else {
      _titleController = TextEditingController();
      _amountController = TextEditingController();
      _selectedCategory = 'Makanan';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: getDeviceHeight(context) * 0.4,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Kategori',
                    style: AppStyles.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close),
                  )
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: AppDimensions.categoryIconWidth,
                                height: AppDimensions.categoryIconHeight,
                                decoration: BoxDecoration(
                                  color: CategoryIconHelper.getCategoryColor(
                                      category),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(
                                    AppDimensions.categoryIconPadding),
                                child: CategoryIconHelper.buildCategoryIcon(
                                  category,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _selectedCategory == category
                                      ? AppColors.darkGrey
                                      : AppColors.grey3,
                                  fontWeight: _selectedCategory == category
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isValidForm() {
    return (_formKey.currentState?.validate() ?? false) &&
        _selectedDate != null;
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final digits = _amountController.text.replaceAll(RegExp(r'[^0-9]'), '');

      final amount = double.tryParse(digits) ?? 0.0;

      if (amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nominal pengeluaran harus lebih dari 0'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final expenseProvider =
          Provider.of<ExpenseProvider>(context, listen: false);

      if (isEditing) {
        expenseProvider.updateExpense(
          id: widget.expense!.id,
          title: title,
          amount: amount,
          date: _selectedDate ?? widget.expense!.date,
          category: _selectedCategory,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengeluaran berhasil diperbarui'),
            backgroundColor: Color(0xFF46B5A7),
          ),
        );
      } else {
        expenseProvider.addExpense(
          title: title,
          amount: amount,
          date: _selectedDate ?? DateTime.now(),
          category: _selectedCategory,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengeluaran berhasil ditambahkan'),
            backgroundColor: Color(0xFF46B5A7),
          ),
        );
      }

      Navigator.of(context).pop();
    }
  }

  void _deleteExpense() {
    if (isEditing) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hapus Pengeluaran'),
            content: const Text(
                'Apakah Anda yakin ingin menghapus pengeluaran ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<ExpenseProvider>(context, listen: false)
                      .deleteExpense(widget.expense!.id);

                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pengeluaran berhasil dihapus'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.navigate_before,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:
              Text(isEditing ? 'Edit Pengeluaran' : 'Tambah Pengeluaran Baru'),
          centerTitle: true,
          actions: isEditing
              ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _deleteExpense,
                  ),
                ]
              : null,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                AppTextField(
                  controller: _titleController,
                  hint: 'Nama Pengeluaran',
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Masukkan nama pengeluaran'
                      : null,
                  onChanged: (v) => setState(() {}),
                ),
                const SizedBox(height: 16),
                SelectFieldTile(
                  valueText: _selectedCategory,
                  trailingIcon: Icons.navigate_next_outlined,
                  isCategory: true,
                  onTap: _showCategoryBottomSheet,
                ),
                const SizedBox(height: 16),
                SelectFieldTile(
                  valueText: _selectedDate != null
                      ? formatDate(_selectedDate!)
                      : 'Tanggal Pengeluaran',
                  trailingIcon: Icons.calendar_month_outlined,
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  onChanged: (v) => setState(() {}),
                  controller: _amountController,
                  isCurrency: true,
                  hint: 'Nominal',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Masukkan nominal pengeluaran';
                    }

                    final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
                    if (digits.isEmpty) {
                      return 'Masukkan nominal yang valid';
                    }

                    final n = double.tryParse(digits);
                    if (n == null) {
                      return 'Masukkan nominal yang valid';
                    }
                    if (n <= 0) {
                      return 'Nominal harus lebih dari 0';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isValidForm() ? _submitExpense : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF0A97B0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      isEditing ? 'Update' : 'Simpan',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
