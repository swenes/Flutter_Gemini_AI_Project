import 'package:camera/camera.dart';
import 'package:err_detector_project/controller/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcrPage2 extends StatefulWidget {
  const OcrPage2({super.key});

  @override
  State<OcrPage2> createState() => _OcrPage2State();
}

class _OcrPage2State extends State<OcrPage2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ScanController>(
          init: ScanController(),
          builder: (controller) {
            return controller.isCameraInitialized.value
                ? Stack(
                    children: [
                      CameraPreview(controller.cameraController),
                      Positioned(
                        top: (controller.y * 700),
                        right: (controller.x * 500),
                        child: Container(
                          width: controller.w * 100 * context.width / 100,
                          height: controller.h * 100 * context.width / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green, width: 4),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: Colors.white,
                                child: Text(controller.label),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text('Loading Preview..'));
          },
        ),
      ),
    );
  }
}
