import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_icon.dart';
import 'package:hanger/constants/app_images.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:hanger/weidgets/common/common_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isPasswordHidden = true; 
  
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
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
                    Image.asset(AppImages.container),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: const Center(
                  child: Text(
                    "WELCOME BACK",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: const Center(
                  child: Text(
                    "Already part of Hanger? Sign in your way",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  AppImages.signin,
                  height: 300.h,
                  width: 300.w,
                  fit: BoxFit.cover,
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w), 
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter email",
                  ),
                ),
              ),
              
              SizedBox(height: 15.h), 
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordHidden, 
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 10.h),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Abhi koi navigation nahi lagayi
                    },
                    child: InkWell(
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20.h),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: commonButton(
                    text: "sign in",
                    color: Colors.black,
                    width: 350.w, 
                    onPressed: () {
                    Get.toNamed(AppRoutes.mainScreen);
                    }
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.signUp);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}