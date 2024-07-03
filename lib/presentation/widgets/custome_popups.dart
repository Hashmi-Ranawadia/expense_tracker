import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomPopups {
  static void showDeletePopup(BuildContext context, ExpenseModel expense, AppCubit appState) {
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
                          // Get.back();
                          Navigator.pop(context);
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
                          appState.removeExpense(expense.id);
                          // Get.back();
                          Navigator.pop(context);
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
