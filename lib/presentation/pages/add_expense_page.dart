import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/bloc/app_state.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  AddExpensePage({super.key, this.expense});
  final ExpenseModel? expense;

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  @override
  void initState() {
    // selectedDate = DateTime.now();
    final appState = BlocProvider.of<AppCubit>(context);
    appState.amountController.clear();
    appState.dateController.clear();
    appState.descriptionController.clear();
    appState.selectedCategory = '';

    if (widget.expense != null) {
      appState.expenseId = widget.expense!.id;
      appState.selectedCategory = widget.expense!.category;
      appState.amountController.text =
          widget.expense!.amount.toStringAsFixed(2) ?? "";
      appState.dateController.text = widget.expense!.date.toString() ?? "";
      appState.descriptionController.text =
          widget.expense!.description.toString() ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   title: Text(widget.expense != null ? 'Edit Expense' : 'Add Expense'),
      // ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/header.png",
                  ),
                  fit: BoxFit.fill),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  InkWell(
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
                  Expanded(
                      child: Text(
                    widget.expense != null ? 'Edit Expense' : 'Add Expense',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                // transform: Matrix4.translationValues(0.0, MediaQuery.of(context).size.height * -0.25, 0.0),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.65,
                margin: EdgeInsets.only(left: 15, right: 15, bottom: MediaQuery.of(context).size.height * 0.10),
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        // spreadRadius: 2
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Category",
                        style: TextStyle(
                            color: AppColor.hintTextColor, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  "Select Category",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                isExpanded: true,
                                items: appState.categoryType
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: appState.selectedCategory.isEmpty
                                    ? null
                                    : appState.selectedCategory,
                                onChanged: (value) {
                                  appState.onSelect(value!);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: AppColor.hintTextColor, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: appState.amountController,
                        cursorColor: AppColor.primaryColor,
                        decoration: InputDecoration(
                          hintText: "Enter Amount",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.hintTextColor,
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(
                              left: 18, right: 18, top: 12, bottom: 12),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor)),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Date",
                        style: TextStyle(
                            color: AppColor.hintTextColor, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          return TextField(
                            onTap: () async {
                              appState.pickDate(context);
                            },
                            readOnly: true,
                            controller: appState.dateController,
                            cursorColor: AppColor.primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: AppColor.hintTextColor.withOpacity(0.8),
                              ),
                              hintText: "Select Date",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: AppColor.hintTextColor,
                                  fontSize: 14),
                              contentPadding: EdgeInsets.only(
                                  left: 18, right: 18, top: 12, bottom: 12),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: AppColor.borderColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: AppColor.primaryColor)),
                            ),
                            keyboardType: TextInputType.number,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            color: AppColor.hintTextColor, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: appState.descriptionController,
                        cursorColor: AppColor.primaryColor,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Enter Description",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppColor.hintTextColor,
                              fontSize: 14),
                          contentPadding: EdgeInsets.only(
                              left: 18, right: 18, top: 12, bottom: 12),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.borderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor)),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 48,
                        // width: MediaQuery.of(context).size.width * 0.80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              // elevation: 10,
                              shadowColor:
                                  AppColor.primaryColor.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if (widget.expense != null) {
                              final expense = ExpenseModel(
                                id: appState.expenseId,
                                category: appState.selectedCategory,
                                amount: double.parse(
                                    appState.amountController.text),
                                date: appState.dateController.text,
                                description:
                                    appState.descriptionController.text,
                              );
                              appState.updateExistingExpense(expense);
                            } else {
                              final random = Random();
                              appState.expenseId = random.nextInt(10000);
                              final expense = ExpenseModel(
                                id: appState.expenseId,
                                category: appState.selectedCategory,
                                amount: double.parse(
                                    appState.amountController.text),
                                date: appState.dateController.text,
                                description:
                                    appState.descriptionController.text,
                              );
                              appState.addNewExpense(expense);
                            }
                            // Get.back();
                            appState.dateController.clear();
                            Navigator.pop(context);
                          },
                          child: Center(
                              child: Text(
                            widget.expense != null
                                ? "Update Expense"
                                : "Add Expense",
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Container(
          //   height: double.infinity,
          //   color: Colors.amber,
          // ),
        ],
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: amountController,
      //         decoration: InputDecoration(labelText: 'Amount'),
      //         keyboardType: TextInputType.number,
      //       ),
      //       TextField(
      //         controller: dateController,
      //         decoration: InputDecoration(labelText: 'Date'),
      //       ),
      //       TextField(
      //         controller: descriptionController,
      //         decoration: InputDecoration(labelText: 'Description'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      // if (widget.expense != null) {
      //   final expense = ExpenseModel(
      //     id: expenseId,
      //     amount: double.parse(amountController.text),
      //     date: dateController.text,
      //     description: descriptionController.text,
      //   );
      //   controller.updateExistingExpense(expense);
      // } else {
      //   final random = Random();
      //   expenseId = random.nextInt(10000);
      //   final expense = ExpenseModel(
      //     id: expenseId,
      //     amount: double.parse(amountController.text),
      //     date: dateController.text,
      //     description: descriptionController.text,
      //   );
      //   controller.addNewExpense(expense);
      // }
      // Get.back();
      //         },
      //         child:
      //             Text(widget.expense != null ? 'Edit Expense' : 'Add Expense'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
