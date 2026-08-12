import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';
// Apne assets aur routes ke path zaroor verify kar lijiye ga
// import 'package:hanger/constants/app_images.dart'; 
// import 'package:hanger/routes/routes_names.dart'; 
// import 'package:hanger/screens/add_item_screen.dart'; 

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Menu Bottom Sheet Function
  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              SizedBox(height: 10.h),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.settings_outlined, color: Colors.black),
                title: Text("Settings", style: TextStyle(fontSize: 16.sp)),
                onTap: () {
                  Get.back(); 
                  // Get.toNamed(AppRoutes.settings); 
                },
              ),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.help_outline, color: Colors.black),
                title: Text("Help", style: TextStyle(fontSize: 16.sp)),
                onTap: () {},
              ),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, color: Colors.black),
                title: Text("Logout", style: TextStyle(fontSize: 16.sp)),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      color: Colors.grey.shade300,
                      // Agar PNG image use karni ho toh yahan lagayein
                      // child: Image.asset('assets/images/profile.png', fit: BoxFit.cover), 
                    ),
                  ),
                  SizedBox(width: 12.w),
                  
                  // Name & Handle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jamain Gordon",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      Text(
                        "@Jamain",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  
                  const Spacer(), 
                  
                  // Top Menu Icon
                  InkWell(
                    onTap: () => _showMenuBottomSheet(context),
                    child: Icon(Icons.menu, size: 28.sp, color: Colors.black),
                  ),
                ],
              ),
            ),

            // 2. Center Body (Empty State for now)
            Expanded(
              child: Center(
                child: Text(
                  "Don't leave us hanging.\nTap + to stock your closet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.black, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. Floating Custom Bottom Navigation Bar
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.home_outlined, size: 28.sp, color: Colors.black),
              ),
              InkWell(
                onTap: () {},
                child: Icon(Icons.search, size: 28.sp, color: Colors.black),
              ),
              
              // ✅ Nayi Screen (Add Item) par jane ka button
              InkWell(
                onTap: () {
                Get.toNamed(
                  AppRoutes.additem
                );
                },
                child: Icon(Icons.add_box_outlined, size: 28.sp, color: Colors.black),
              ),
              
              InkWell(
                onTap: () {},
                child: Icon(Icons.local_offer_outlined, size: 28.sp, color: Colors.black),
              ),
              InkWell(
                onTap: () => _showMenuBottomSheet(context),
                child: Icon(Icons.menu, size: 28.sp, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}