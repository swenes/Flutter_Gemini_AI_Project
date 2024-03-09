import 'package:camera/camera.dart';
import 'package:err_detector_project/controller/scan_controller.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:err_detector_project/widgets/border_container.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OcrPage2 extends StatelessWidget {
  const OcrPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nesne Tanıma",
              style: TextStyle(
                  fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        backgroundColor: Colors.black,
        body: GetBuilder<ScanController>(
          init: ScanController(),
          builder: (controller) {
            return controller.isCameraInitialized.value
                ? SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CameraPreview(controller.cameraController),
                            Positioned(
                              top: controller.y != null
                                  ? controller.y * 650
                                  : 100,
                              right: controller.x != null
                                  ? controller.x * 550
                                  : 100,
                              child: Container(
                                width: controller.w != null
                                    ? (controller.w * 100 * context.width / 100)
                                    : 100,
                                height:
                                    controller.h * 100 * context.height / 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.green, width: 4.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      color: Colors.white.withOpacity(0.5),
                                      child: Text(controller.label),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Expanded ekleyerek, Container'ın geri kalan yüksekliği almasını sağladık
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              width: context.width - 80,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 131, 4, 4),
                                  border:
                                      Border.all(color: Constants.borderColor),
                                  borderRadius: BorderRadius.circular(40)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Şu an Tespit Edilen Nesne',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cera Pro'),
                                    ),
                                    Text(
                                      controller.label,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 226, 66),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Cera Pro'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: BorderContainer(
                        color: Colors.white,
                        text: "Kameranıza Erişiyoruz..",
                        fontSize: 20));
          },
        ));
  }
}
