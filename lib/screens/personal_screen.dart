import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hanger/routes/routes_names.dart';
import 'package:image_picker/image_picker.dart';


class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  int _currentStep = 0; // 0 = Form, 1 = Photo

  late final TextEditingController _fullNameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _shopController;
  late final TextEditingController _customCountryController;
  
  String? _selectedCountry;

  File? _selectedProfileImage; 
  final ImagePicker _picker = ImagePicker();

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _usernameController = TextEditingController();
    _shopController = TextEditingController();
    _customCountryController = TextEditingController();

    _fullNameController.addListener(_updateState);
    _usernameController.addListener(_updateState);
    _shopController.addListener(_updateState);
    _customCountryController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _shopController.dispose();
    _customCountryController.dispose();
    super.dispose();
  }

  // Gallery se picture uthane ki logic
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedProfileImage = File(image.path); 
        });
      }
    } catch (e) {
      debugPrint("Gallery error: $e");
    }
  }

  bool get _isFormComplete {
    bool isCountryValid = _selectedCountry != null && _selectedCountry != 'Other';
    if (_selectedCountry == 'Other') {
      isCountryValid = _customCountryController.text.isNotEmpty;
    }
    return _fullNameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _shopController.text.isNotEmpty &&
        isCountryValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar / Back Button
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 20.w),
              child: InkWell(
                onTap: () {
                  if (_currentStep == 1) {
                    setState(() {
                      _currentStep = 0; 
                    });
                  } else {
                    Get.back(); 
                  }
                },
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            SizedBox(height: 30.h),
            
            // Dynamic Screen Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: _currentStep == 0 ? _buildFormStep() : _buildPhotoStep(),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFormStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal information",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 30.h),

          _buildTextField(controller: _fullNameController, hintText: "Full name"),
          _buildTextField(controller: _usernameController, hintText: "Username"),
          
          // Country Dropdown
          SizedBox(
            height: 50.h,
            child: DropdownButtonFormField<String>(
              value: _selectedCountry,
              hint: Text("Where are you from?", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              items: _countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country, style: TextStyle(fontSize: 14.sp)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue;
                  if (newValue != 'Other') _customCountryController.clear();
                });
              },
            ),
          ),

          if (_selectedCountry == 'Other') ...[
            SizedBox(height: 10.h),
            _buildTextField(controller: _customCountryController, hintText: "Type your country name"),
          ],

          _buildTextField(controller: _shopController, hintText: "What's your favourite place to shop"),

          SizedBox(height: 50.h),

          Center(
            child: InkWell(
              onTap: () {
                if (_isFormComplete) {
                  setState(() { _currentStep = 1; });
                }
              },
              child: Container(
                width: 350.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _isFormComplete ? Colors.black : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  _isFormComplete ? "Submit" : "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText}) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }


  Widget _buildPhotoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Every great outfit needs a model. Add a photo\nto complete the look",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.4),
        ),
        SizedBox(height: 30.h),

        Row(
          children: [
            InkWell(
              onTap: _showPhotoBottomSheet,
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15.r),
                  image: _selectedProfileImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedProfileImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedProfileImage == null
                    ? const Center(child: Icon(Icons.add, color: Colors.black, size: 30))
                    : null,
              ),
            ),
            SizedBox(width: 20.w),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _fullNameController.text.isNotEmpty ? _fullNameController.text : "Full name",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 1,
                  width: 150.w,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                ),
                Text(
                  _usernameController.text.isNotEmpty ? "@${_usernameController.text}" : "@Username",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
                ),
              ],
            )
          ],
        ),
        
        const Spacer(),
        
        // Smart Bottom Action Section
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (_selectedProfileImage == null) {
                    _showPhotoBottomSheet();
                  } else {
                    Get.toNamed(AppRoutes.mainScreen); 
                  }
                },
                child: Container(
                  width: 350.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedProfileImage == null ? Colors.grey.shade300 : Colors.black,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _selectedProfileImage == null ? "Snap a selfie" : "Continue",
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              
              if (_selectedProfileImage == null) ...[
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.mainScreen); 
                  },
                  child: Text(
                    "Skip for now",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ],
    );
  }

 
  void _showPhotoBottomSheet() {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add photo", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.photo_library_outlined, color: Colors.black),
                title: Text("Choose from library", style: TextStyle(fontSize: 16.sp)),
                onTap: () {
                  Get.back(); 
                  _pickImageFromGallery();
                },
              ),
              
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.camera_alt_outlined, color: Colors.black),
                title: Text("Take a photo", style: TextStyle(fontSize: 16.sp)),
                onTap: () async {
                  Get.back(); // Bottom sheet band karein
                  
                  // Camera screen se aane wali picture ka path receive karein
                  // AppRoutes.camera ko apne route name se replace kar lijiye ga
                  // final imagePath = await Get.toNamed(AppRoutes.camera); 
                  
                  // Misaal ke tor par:
                  /*
                  if (imagePath != null) {
                    setState(() {
                      _selectedProfileImage = File(imagePath);
                    });
                  }
                  */
                },
              ),
            ],
          ),
        );
      },
    );
  }
}