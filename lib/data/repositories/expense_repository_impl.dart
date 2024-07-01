import 'package:expense_tracker/data/local/sqflite_database.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final SqfliteDatabase database;

  ExpenseRepositoryImpl(this.database);

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    final db = await database.database;
    await db.insert('expenses', expense.toMap());
  }

  @override
  Future<void> deleteExpense(int id) async {
    final db = await database.database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final db = await database.database;
    final result = await db.query('expenses');
    return result.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await database.database;
    await db.update('expenses', expense.toMap(), where: 'id = ?', whereArgs: [expense.id]);
  }
}
