import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/bloc/app_state.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:expense_tracker/presentation/widgets/custome_popups.dart';
import 'package:expense_tracker/presentation/widgets/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseSummaryPage extends StatefulWidget {
  @override
  State<ExpenseSummaryPage> createState() => _ExpenseSummaryPageState();
}

class _ExpenseSummaryPageState extends State<ExpenseSummaryPage> {
  // final ExpenseController controller = Get.find();
  var appState;

  @override
  void initState() {
    appState = BlocProvider.of<AppCubit>(context);
    appState.categoryType.insert(0, "All");
    appState.fetchExpenses();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appState.selectedIndex = 0;
    appState.categoryType.removeAt(0);
    appState.filteredList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColorDark,
        leading: InkWell(
          onTap: () {
            // Get.back();
            Navigator.pop(context);
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
      body: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 12),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: appState.categoryType.length,
              itemBuilder: (context, index) {
                return BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        appState.itemSelectedIndex(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: AppColor.primaryColorDark),
                            color: appState.selectedIndex == index
                                ? AppColor.primaryColorDark
                                : AppColor.whiteColor),
                        child: Text(
                          "${appState.categoryType[index]}",
                          style: TextStyle(
                              color: appState.selectedIndex == index
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
          BlocBuilder<AppCubit, AppState>(builder: (context, state) {
            return Expanded(
              child: appState.filteredList.isEmpty
                  ? Center(
                      child: Text("No expenses yet!"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: appState
                          .filteredList.length, //controller.expenses.length,
                      itemBuilder: (context, index) {
                        final expense = appState
                            .filteredList[index]; //controller.expenses[index];
                        return InkWell(
                          onTap: () {
                            // Get.to(() => AddExpensePage(
                            //       expense: expense,
                            //     ));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddExpensePage(
                                  expense: expense,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            CustomPopups.showDeletePopup(
                                context, expense, appState);
                          },
                          child: ExpenseItem(expense: expense),
                        );
                      },
                    ),
            );
          }),
        ],
      ),
    );
  }
}
