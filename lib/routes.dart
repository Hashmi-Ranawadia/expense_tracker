import 'package:expense_tracker/presentation/pages/onboarding_page.dart';
import 'package:expense_tracker/presentation/pages/splash_page.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/presentation/pages/add_expense_page.dart';
import 'package:expense_tracker/presentation/pages/expense_summary_page.dart';
import 'package:expense_tracker/presentation/pages/expenses_page.dart';
import 'package:expense_tracker/presentation/pages/home_page.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => SplashPage()),
    GetPage(name: '/onboarding', page: () => OnBoardingPage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/add_expense', page: () => AddExpensePage()),
    GetPage(name: '/expense_summary', page: () => ExpenseSummaryPage()),
    GetPage(name: '/expenses', page: () => ExpensesPage()),
  ];
}
