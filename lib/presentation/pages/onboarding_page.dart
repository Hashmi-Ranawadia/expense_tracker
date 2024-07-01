import 'package:expense_tracker/presentation/pages/home_page.dart';
import 'package:expense_tracker/presentation/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});

  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/onboarding_bg.png",
                  ),
                  fit: BoxFit.fill),
            ),
            padding: EdgeInsets.all(60),
            child: Center(
              child: Image.asset(
                "assets/images/person.png",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Spend Smarter\nSave More",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.primaryColorDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 28),
            ),
          ),

          const SizedBox(
            height: 30,
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.75,
          //   height: 52,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30),
          //     color: AppColor.primaryColor,
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColor.primaryColor.withOpacity(0.4),
          //         spreadRadius: 3,
          //         blurRadius: 10,
          //         offset: Offset(0.2, 0.2)
          //       )
          //     ]
          //   ),
          //   child: Center(child: Text("Get Started", style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.w600, fontSize: 18),)),
          // )

          Container(
            height: 52,
            width: MediaQuery.of(context).size.width * 0.80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  elevation: 10,
                  shadowColor: AppColor.primaryColor.withOpacity(0.8)),
              onPressed: () async {
                if (prefs == null) {
                  prefs = await SharedPreferences.getInstance();
                }
                prefs!.setBool('showHome', true);
                Get.offAll(() => HomePage());
              },
              child: Center(
                  child: Text(
                "Get Started",
                style: TextStyle(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              )),
            ),
          )
        ],
      ),
    );
  }
}
