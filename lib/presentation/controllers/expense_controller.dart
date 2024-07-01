import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/domain/usecases/add_expense.dart';
import 'package:expense_tracker/domain/usecases/delete_expense.dart';
import 'package:expense_tracker/domain/usecases/get_expenses.dart';
import 'package:expense_tracker/domain/usecases/update_expense.dart';
import 'package:intl/intl.dart';

class ExpenseController extends GetxController {
  final AddExpense addExpense;
  final DeleteExpense deleteExpense;
  final GetExpenses getExpenses;
  final UpdateExpense updateExpense;

  ExpenseController({
    required this.addExpense,
    required this.deleteExpense,
    required this.getExpenses,
    required this.updateExpense,
  });

  var expenses = <ExpenseModel>[].obs;
  var selectedDate;
  int expenseId = 0;
  var totalExpenses = 0.0.obs;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var categoryType = ["Travel", "Sports", "Education", "Business", "Personal"];

  var selectedCategory = '';

  var selectedIndex = 0;
  var filteredList = [];
  var filteredListByDate = <ExpenseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate = DateTime.now();
    fetchExpenses();
  }

  void fetchExpenses() async {
    expenses.value.clear();
    filteredList.clear();

    expenses.value = await getExpenses();
    totalExpenses.value = 0;
    for (int i = 0; i < expenses.length; i++) {
      totalExpenses.value += expenses[i].amount;
    }
    filteredList.addAll(expenses);
  }

  void addNewExpense(ExpenseModel expense) async {
    await addExpense(expense);
    fetchExpenses();
  }

  void updateExistingExpense(ExpenseModel expense) async {
    await updateExpense(expense);
    fetchExpenses();
  }

  void removeExpense(int id) async {
    await deleteExpense(id);
    fetchExpenses();
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData(
                primaryColor: AppColor.primaryColor,
                colorScheme: ColorScheme.light(
                    primary: AppColor.primaryColor,
                    onSurface: AppColor.primaryColorDark),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        },
        context: context,
        initialDate: DateFormat("yyyy-MM-dd").parse(selectedDate.toString()),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2050, 5));
    if (picked != null) {
      selectedDate = DateFormat("yyyy-MM-dd").format(picked);
      dateController.text = selectedDate;
      update();
    }
  }

  void onSelect(String value) {
    selectedCategory = value;
    update();
  }

  void itemSelectedIndex(int index) {
    selectedIndex = index;

    filteredList.clear();
    if (categoryType[index] == "All") {
      filteredList.addAll(expenses);
    } else {
      filteredList.addAll(
          expenses.where((element) => element.category == categoryType[index]));
    }
    update();
  }

  void filterListByDate() async {
    expenses.value.clear();

    // expenses.value = await getExpenses();
    filteredListByDate.value = await getExpenses();
    totalExpenses.value = 0;

    expenses.addAll(filteredListByDate
        .where((element) => element.date == dateController.text));

    for (int i = 0; i < expenses.length; i++) {
      totalExpenses.value += expenses[i].amount;
    }
    update();
  }
}
