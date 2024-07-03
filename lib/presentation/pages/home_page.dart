import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/bloc/app_state.dart';
import 'package:expense_tracker/presentation/pages/expenses_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  // final ExpenseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final appState = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Expense Tracker'),
      // ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                padding: EdgeInsets.only(left: 20, right: 20, top: 40),
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
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.primaryColorLight),
                          child: Icon(
                            Icons.person,
                            color: AppColor.primaryColorDark,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'My Expenses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Filter",
                                              style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 18),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: AppColor.hintTextColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      BlocBuilder<AppCubit, AppState>(
                                        builder: (context, state) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                            ),
                                            child: TextField(
                                              onTap: () async {
                                                appState.pickDate(context);
                                              },
                                              readOnly: true,
                                              controller:
                                                  appState.dateController,
                                              cursorColor:
                                                  AppColor.primaryColor,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: AppColor.hintTextColor
                                                      .withOpacity(0.8),
                                                ),
                                                hintText: "Select Date",
                                                hintStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        AppColor.hintTextColor,
                                                    fontSize: 14),
                                                contentPadding: EdgeInsets.only(
                                                    left: 18,
                                                    right: 18,
                                                    top: 12,
                                                    bottom: 12),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .borderColor)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .primaryColor)),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  // Get.back();
                                                  Navigator.pop(context);
                                                  appState.dateController
                                                      .clear();
                                                  appState.fetchExpenses();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .hintTextColor)),
                                                  child: Text(
                                                    "Reset",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .blackColor),
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
                                                  appState.filterListByDate();
                                                  // Get.back();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 10),
                                                  decoration: BoxDecoration(
                                                    color: AppColor
                                                        .primaryColorDark,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    "Submit",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: AppColor.whiteColor,
                          ))
                    ],
                  ),
                ),
              ),
              Container(
                // transform: Matrix4.translationValues(0.0, -120, 0.0),
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 160, bottom: 10),
                width: double.infinity,
                // height: 120,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                decoration: BoxDecoration(
                    color: AppColor.primaryColorDark,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(offset: Offset(0.2, 0.2), blurRadius: 10)
                    ]),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total Expense",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_drop_up_sharp,
                              color: AppColor.whiteColor,
                              size: 20,
                            ),
                          ],
                        ),
                        Icon(
                          Icons.more_horiz,
                          color: AppColor.whiteColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          color: AppColor.whiteColor,
                          size: 20,
                        ),
                        BlocBuilder<AppCubit, AppState>(
                          builder: (context, state) {
                            return Text(
                              "${appState.totalExpenses.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ExpensesPage(),
          ),
          // ElevatedButton(
          //   onPressed: () => Get.toNamed('/expense_summary'),
          //   child: Text('View Summary'),
          // ),
        ],
      ),
    );
  }
}
