import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(ExpenseModel expense) async {
    await repository.updateExpense(expense);
  }
}
