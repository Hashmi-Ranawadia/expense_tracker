import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/usecases/add_expense.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/presentation/controllers/expense_controller.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseModel expense;
  final ExpenseController controller = Get.find();

  ExpenseItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 20, right: 20),
      title: Text(
        expense.category,
        style: TextStyle(color: AppColor.primaryColorDark, fontSize: 18),
      ),
      subtitle: Text(
        expense.date,
        style: TextStyle(
          color: AppColor.hintTextColor,
        ),
      ),
      trailing: Text(
        "₹${expense.amount.toStringAsFixed(2)}",
        style: TextStyle(color: AppColor.primaryColorDark, fontSize: 16),
      ),
      // trailing: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     IconButton(
      //       icon: Icon(Icons.edit, color: AppColor.primaryColorDark,),
      //       onPressed: () {
      //         // Edit expense logic
              // Get.to(() => AddExpensePage(
              //       expense: expense,
              //     ));
      //       },
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.delete, color: Colors.red.withOpacity(0.9),),
      //       onPressed: () {
              // controller.removeExpense(expense.id);
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
