import 'package:expense_tracker/data/model/expense_model.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(ExpenseModel expense);
  Future<void> deleteExpense(int id);
  Future<List<ExpenseModel>> getExpenses();
  Future<void> updateExpense(ExpenseModel expense);
}
