import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class GetExpenses {
  final ExpenseRepository repository;

  GetExpenses(this.repository);

  Future<List<ExpenseModel>> call() async {
    return await repository.getExpenses();
  }
}
