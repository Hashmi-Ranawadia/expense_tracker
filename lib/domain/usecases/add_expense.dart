import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class AddExpense {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.addExpense(expense);
  }
}
