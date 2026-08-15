import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_images.dart'; 
import 'package:hanger/routes/routes_names.dart'; 
import 'package:hanger/screens/item_detail_screen.dart'; 
import 'package:hanger/screens/active_search_screen.dart'; 
import 'package:hanger/screens/for_sale_screen.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Map<String, String>> _dummyItems = [
    {'image': AppImages.photo, 'name': 'Yeezy Boost 350', 'brand': 'Adidas'},
    {'image': AppImages.photo1, 'name': 'Essential Brown Tee', 'brand': 'Fear of God'},
    {'image': AppImages.photo2, 'name': 'Black Puffer Jacket', 'brand': 'The North Face'},
    {'image': AppImages.photo3, 'name': 'Air Jordan 1 Retro', 'brand': 'Nike'},
    {'image': AppImages.photo4, 'name': 'Vintage Denim Jacket', 'brand': 'Levi\'s'},
    {'image': AppImages.photo5, 'name': 'White Canvas Sneakers', 'brand': 'Converse'},
  ];

  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
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
                  Get.toNamed(AppRoutes.setting); 
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

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h, 
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Search", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              TextField(
                autofocus: true, 
                decoration: InputDecoration(
                  hintText: "Search items, brands, or categories...",
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(child: _buildFilterButton("Size")),
                  SizedBox(width: 15.w),
                  Expanded(child: _buildFilterButton("Colour")),
                ],
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  Get.back(); 
                  Get.to(() => const ActiveSearchScreen()); 
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14.sp, color: Colors.black)),
          Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20.sp),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      color: Colors.grey.shade300,
                      child: Image.asset(AppImages.main, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jamain Gordon", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black)),
                      Text("@Jamain", style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                    ],
                  ),
                  const Spacer(), 
                  InkWell(
                    onTap: () => _showMenuBottomSheet(context),
                    child: Icon(Icons.menu, size: 28.sp, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: 0.75, 
                ),
                itemCount: _dummyItems.length,
                itemBuilder: (context, index) {
                  final item = _dummyItems[index];
                  return InkWell(
                    onTap: () {
                      Get.to(() => const ItemDetailScreen());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => 
                                    const Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          item['name']!,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          item['brand']!,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, spreadRadius: 1, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Icon(Icons.home, size: 28.sp, color: Colors.black), 
              ),
                            InkWell(
                onTap: () => _showSearchBottomSheet(context),
                child: Icon(Icons.search, size: 28.sp, color: Colors.black),
              ),
                            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.additem); 
                },
                child: Icon(Icons.add_box_outlined, size: 28.sp, color: Colors.black),
              ),
                            InkWell(
                onTap: () {
                  Get.to(() => const ForSaleScreen());
                },
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