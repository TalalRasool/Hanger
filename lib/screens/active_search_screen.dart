import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/constants/app_images.dart'; 
import 'package:hanger/screens/item_detail_screen.dart';

class ActiveSearchScreen extends StatefulWidget {
  const ActiveSearchScreen({super.key});

  @override
  State<ActiveSearchScreen> createState() => _ActiveSearchScreenState();
}

class _ActiveSearchScreenState extends State<ActiveSearchScreen> {
  List<String> _activeFilters = ['Size: UK 9', 'Colour: Black'];

  final List<Map<String, String>> _filteredItems = [
    {
      'image': AppImages.photo, 
      'name': 'Yeezy Boost 350',
      'brand': 'Adidas'
    },
    {
      'image': AppImages.photo3,
      'name': 'Air Jordan 1 Retro',
      'brand': 'Nike'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Bar (Search Header)
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w, bottom: 15.h, right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search items...",
                        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Active Filters (Tags)
            if (_activeFilters.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: _activeFilters.map((filter) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          ),
                          SizedBox(width: 6.w),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _activeFilters.remove(filter);
                              });
                            },
                            child: Icon(Icons.close, size: 16.sp, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

            SizedBox(height: 10.h),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        "No items found.",
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 20.h,
                        childAspectRatio: 0.75, 
                      ),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
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
                                style: TextStyle(
                                  fontSize: 14.sp, 
                                  fontWeight: FontWeight.w600, 
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                item['brand']!,
                                style: TextStyle(
                                  fontSize: 12.sp, 
                                  color: Colors.grey.shade600,
                                ),
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
    );
  }
}