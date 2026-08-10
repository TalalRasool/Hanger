import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_icon.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/weidgets/common/common_button.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Sab kuch center align karne ke liye
              children: [
                // 1. Top App Bar (Back Icon & Logo)
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

                SizedBox(height: 120.h), // Top se margin

                // 2. Heading
                Text(
                  "LOCKED OUT OF THE CLOSET?",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                
                SizedBox(height: 15.h),

                // 3. Subheading (Paragraph)
                Text(
                  "Don't get your knickers in a twist.\nEnter your email below, and we'll help\nyou iron this out.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // Line spacing thori zyada ki hai look behtar karne ke liye
                  ),
                ),

                SizedBox(height: 120.h), // Middle space

                // 4. Email TextField (Sirf bottom border ke sath)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // Image ke mutabiq box border nahi hai, sirf underline hai
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // 5. Submit Button
                commonButton(
                  text: "Send the Thread",
                  color: const Color(0xFF1C140C), // Image mein button ka color dark brown/black shade mein hai
                  width: double.infinity, // Button ko full width dene ke liye
                  onPressed: () {
                    Get.toNamed(AppRoutes.resetLinkSent, arguments: _emailController.text);
                  }
                ),

                SizedBox(height: 40.h), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}