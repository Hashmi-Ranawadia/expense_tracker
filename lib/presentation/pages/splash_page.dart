import 'package:expense_tracker/presentation/pages/home_page.dart';
import 'package:expense_tracker/presentation/pages/onboarding_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences? prefs;
  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  void changeScreen() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    final showHome = prefs!.getBool('showHome') ?? false;

    Future.delayed(
      Duration(seconds: 2),
      () {
        // Get.offAll(() => showHome ? HomePage() : OnBoardingPage());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => showHome ? HomePage() : OnBoardingPage(),), (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Expense Tracker", style: TextStyle(color: AppColor.whiteColor, fontSize: 30),))
        ],
      ),
    );
  }
}
