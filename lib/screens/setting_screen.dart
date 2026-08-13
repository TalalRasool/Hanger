import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w, bottom: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Personal Information Option
                  _buildSettingsOption(
                    title: "Personal information",
                    showArrow: true,
                    onTap: () {
                    Get.toNamed(AppRoutes.editpersonalinfo);
                    },
                  ),
                  SizedBox(height: 15.h),

                  _buildSettingsOption(
                    title: "Buy me chai latte, to keep your wardrobe full",
                    showArrow: true,
                    onTap: () {
                    },
                  ),
                  SizedBox(height: 15.h),

                  _buildSettingsOption(
                    title: "Logout",
                    showArrow: false, 
                    onTap: () {
                     ( Get.offAllNamed(AppRoutes.signIn));
                    },
                  ),
                ],
              ),
            ),

            const Spacer(), 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flight_takeoff, size: 24.sp, color: Colors.black), // Dummy logo icon
                      SizedBox(width: 8.w),
                      Text(
                        "HANGER",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "Version: 0.2",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required String title,
    required bool showArrow,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios, 
                size: 14.sp,
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}