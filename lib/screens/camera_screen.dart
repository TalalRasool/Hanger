import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // Real camera initialize karne ka function
  Future<void> _initializeCamera() async {
    try {
      // Device ke available cameras get karein
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        
        // ✅ Front camera find karne ki nayi logic
        CameraDescription? selectedCamera;
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.front) {
            selectedCamera = camera;
            break; // Jaise hi front camera mile, loop rok dein
          }
        }
        
        // Agar front camera nahi milta, toh jo bhi pehla camera available ho wo use karein
        selectedCamera ??= cameras.first;

        _cameraController = CameraController(
          selectedCamera,
          ResolutionPreset.high,
          enableAudio: false, // Hamein sirf photo chahiye, video nahi
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint("Camera initialize hone mein error: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose(); // Memory leak se bachne ke liye camera band karein
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close, color: Colors.black),
                  ),
                  InkWell(
                    onTap: () {
                      // Flash toggle ki mazeed logic baad mein laga sakte hain
                    },
                    child: const Icon(Icons.flash_on_outlined, color: Colors.black),
                  ),
                ],
              ),
            ),

            // 2. Real Camera Viewfinder
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.black, 
                  borderRadius: BorderRadius.circular(15.r),
                ),
                // ✅ Yahan actual camera preview show hoga
                child: _isCameraInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CameraPreview(_cameraController!),
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
              ),
            ),

            // 3. Shutter Button
            Padding(
              padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
              child: Column(
                children: [
                  Text("Snap it", style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                  SizedBox(height: 15.h),
                  InkWell(
                    onTap: () async {
                      if (_isCameraInitialized && _cameraController != null) {
                        try {
                          // Picture click karne ki actual logic
                          final image = await _cameraController!.takePicture();
                          debugPrint("Picture yahan save hui hai: ${image.path}");
                          // Yahan aap picture click hone ke baad ka action laga sakte hain
                          // Get.back(result: image.path);
                        } catch (e) {
                          debugPrint("Picture lene mein error: $e");
                        }
                      }
                    },
                    child: Container(
                      height: 70.w,
                      width: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400, width: 2), 
                      ),
                      child: Center(
                        child: Container(
                          height: 55.w,
                          width: 55.w,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
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
}