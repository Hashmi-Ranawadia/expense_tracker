import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:expense_tracker/presentation/widgets/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/presentation/controllers/expense_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ExpenseSummaryPage extends StatefulWidget {
  @override
  State<ExpenseSummaryPage> createState() => _ExpenseSummaryPageState();
}

class _ExpenseSummaryPageState extends State<ExpenseSummaryPage> {
  final ExpenseController controller = Get.find();

  @override
  void initState() {
    controller.categoryType.insert(0, "All");
    controller.fetchExpenses();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.selectedIndex = 0;
    controller.categoryType.removeAt(0);
    controller.filteredList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColorDark,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.whiteColor,
            size: 20,
          ),
        ),
        title: Text(
          'Expense Summary',
          style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return Center(child: Text('No expenses yet'));
        }
        return Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 12),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryType.length,
                itemBuilder: (context, index) {
                  return GetBuilder<ExpenseController>(
                    builder: (controller) {
                      return InkWell(
                        onTap: () {
                          controller.itemSelectedIndex(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColor.primaryColorDark),
                              color: controller.selectedIndex == index
                                  ? AppColor.primaryColorDark
                                  : AppColor.whiteColor),
                          child: Text(
                            "${controller.categoryType[index]}",
                            style: TextStyle(
                                color: controller.selectedIndex == index
                                    ? AppColor.whiteColor
                                    : AppColor.primaryColorDark),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            GetBuilder<ExpenseController>(builder: (controller) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller
                      .filteredList.length, //controller.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = controller
                        .filteredList[index]; //controller.expenses[index];
                    return InkWell(
                      onTap: () {
                        Get.to(() => AddExpensePage(
                              expense: expense,
                            ));
                      },
                      onLongPress: () {
                        // showDeletePopup(context, expense);
                      },
                      child: ExpenseItem(expense: expense),
                    );
                  },
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}
