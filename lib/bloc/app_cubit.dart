import 'package:bloc/bloc.dart';
import 'package:expense_tracker/bloc/app_state.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(initialState());

  
  List<ExpenseModel> expenses = [];
  var selectedDate;
  int expenseId = 0;
  var totalExpenses = 0.0;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var categoryType = ["Travel", "Sports", "Education", "Business", "Personal"];

  var selectedCategory = '';

  var selectedIndex = 0;
  var filteredList = [];
  List<ExpenseModel> filteredListByDate = [];

  ExpenseRepositoryImpl respository = ExpenseRepositoryImpl();
  
  void fetchExpenses() async {
    expenses.clear();
    filteredList.clear();

    expenses = await respository.getExpenses();
    totalExpenses = 0;
    for (int i = 0; i < expenses.length; i++) {
      totalExpenses += expenses[i].amount;
    }
    filteredList.addAll(expenses);
    emit(successState());
  }

  void addNewExpense(ExpenseModel expense) async {
    await respository.addExpense(expense);
    fetchExpenses();
  }

  void updateExistingExpense(ExpenseModel expense) async {
    await respository.updateExpense(expense);
    fetchExpenses();
  }

  void removeExpense(int id) async {
    await respository.deleteExpense(id);
    fetchExpenses();
  }

  void pickDate(BuildContext context) async {
    selectedDate = DateTime.now();
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
      emit(successState());
    }
  }

  void onSelect(String value) {
    selectedCategory = value;
    emit(successState());
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
    emit(successState());
  }

  void filterListByDate() async {
    expenses.clear();

    // expenses.value = await getExpenses();
    filteredListByDate = await respository.getExpenses();
    totalExpenses = 0;

    expenses.addAll(filteredListByDate
        .where((element) => element.date == dateController.text));

    for (int i = 0; i < expenses.length; i++) {
      totalExpenses += expenses[i].amount;
    }
    emit(successState());
  }
}
