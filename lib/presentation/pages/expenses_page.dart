import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/pages/expense_summary_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/presentation/controllers/expense_controller.dart';
import 'package:expense_tracker/presentation/widgets/expense_item.dart';

class ExpensesPage extends StatelessWidget {
  final ExpenseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Expenses'),
      // ),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return Center(child: Text('No expenses yet'));
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expense History",
                    style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ExpenseSummaryPage());
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                          color: AppColor.hintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.expenses.length,
                itemBuilder: (context, index) {
                  final expense = controller.expenses[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => AddExpensePage(
                            expense: expense,
                          ));
                    },
                    onLongPress: () {
                      showDeletePopup(context, expense);
                    },
                    child: ExpenseItem(expense: expense),
                  );
                },
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColorDark,
        onPressed: () => Get.toNamed('/add_expense'),
        child: Icon(Icons.add, color: AppColor.whiteColor,),
      ),
    );
  }

  void showDeletePopup(BuildContext context, ExpenseModel expense) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColor.whiteColor,
          title: Text(
            "Warning!",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(
              color: Colors.red.withOpacity(0.9),
              fontSize: 22,
              fontWeight: FontWeight.w500),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure you want to delete\nthis record?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.hintTextColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColor.hintTextColor)),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColor.blackColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.removeExpense(expense.id);
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColorDark,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Delete",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
