import 'package:expense_tracker/bloc/app_cubit.dart';
import 'package:expense_tracker/data/local/sqflite_database.dart';
import 'package:expense_tracker/presentation/pages/onboarding_page.dart';
import 'package:expense_tracker/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/pages/expense_summary_page.dart';
import 'package:expense_tracker/presentation/pages/expenses_page.dart';
import 'package:expense_tracker/presentation/pages/home_page.dart';
import 'package:expense_tracker/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation('America/Detroit')); // Set to your local time zone

  // final database = SqfliteDatabase();
  // final repository = ExpenseRepositoryImpl();
  // final addExpense = AddExpense(repository);
  // final deleteExpense = DeleteExpense(repository);
  // final getExpenses = GetExpenses(repository);
  // final updateExpense = UpdateExpense(repository);

  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.scheduleDailyNotifications();

  // Get.put(ExpenseController(
  //   addExpense: addExpense,
  //   deleteExpense: deleteExpense,
  //   getExpenses: getExpenses,
  //   updateExpense: updateExpense,
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        // initialRoute: '/',
        // getPages: [
        //   GetPage(name: '/', page: () => SplashPage()),
        //   GetPage(name: '/onboarding', page: () => OnBoardingPage()),
        //   GetPage(name: '/home', page: () => HomePage()),
        //   GetPage(name: '/add_expense', page: () => AddExpensePage()),
        //   GetPage(name: '/expense_summary', page: () => ExpenseSummaryPage()),
        // ],
      ),
    );
  }
}
