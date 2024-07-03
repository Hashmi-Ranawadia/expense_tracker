import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/bloc/app_state.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/pages/expense_summary_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:expense_tracker/presentation/widgets/custome_popups.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/presentation/widgets/expense_item.dart';

class ExpensesPage extends StatefulWidget {
  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  // final ExpenseController controller = Get.find();
  @override
  void initState() {
    final appState = BlocProvider.of<AppCubit>(context);
    appState.fetchExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Expenses'),
      // ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
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
                        // Get.to(() => ExpenseSummaryPage());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpenseSummaryPage(),
                          ),
                        );
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
                child: appState.expenses.isEmpty
                    ? Center(
                        child: Text("No expenses yet!"),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appState.expenses.length,
                        itemBuilder: (context, index) {
                          final expense = appState.expenses[index];
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
                             CustomPopups.showDeletePopup(context, expense, appState);
                            },
                            child: ExpenseItem(expense: expense),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColorDark,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddExpensePage(),
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
