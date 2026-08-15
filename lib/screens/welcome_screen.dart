import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/weidgets/common/common_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AppImages.welcome,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
        
          SafeArea(
            child: SizedBox(
              width: double.infinity, 
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      AppImages.logo, 
                      fit: BoxFit.contain, 
                    ),
                  ),
                  SizedBox(
                    height: 480.h,
                  ),
                  Text("Know what you own.\nWear what you love.",style: TextStyle(fontWeight: FontWeight(600),fontSize: 19),),
                  SizedBox(
                    height: 20.h,
                  ),
              commonButton(
                width: 300.w,
  text: "Get Started", 
  onPressed: () {
    Get.toNamed(AppRoutes.signIn); 
 
  },
  color: Colors.black
)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}