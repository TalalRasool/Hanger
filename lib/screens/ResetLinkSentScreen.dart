import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_icon.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/weidgets/common/common_button.dart';

class ResetLinkSentScreen extends StatelessWidget {
  final String email; 
  
  const ResetLinkSentScreen({
    super.key, 
    this.email = "user@example.com", 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(AppIcon.backArrow),
                      ),
                    ),
                    Image.asset(
                      AppImages.container, // Hanger Logo
                      height: 25.h,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text(
                      "IT’S IN THE BAG!",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: const Color(0xFF3E2723), 
                      ),
                    ),
                    
                    SizedBox(height: 25.h),
                    
                    // Dynamic Email Text
                    Text(
                      "We've sent a reset link to [$email].\nFollow the thread in that email to get\nback in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.4, 
                      ),
                    ),
                    
                    SizedBox(height: 25.h),
                    
                    Text(
                      "(Can't find it? Check your spam folder, it might be hiding\nin the back of the wardrobe.)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87, 
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 30.h), 
                child: commonButton(
                  text: "Back to Hanger",
                  color: const Color(0xFF1C140C), 
                  width: double.infinity, 
                  onPressed: () {
                Get.toNamed(AppRoutes.signIn);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}