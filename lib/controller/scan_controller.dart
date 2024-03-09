// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initCamera();
    initTFlite();
  }

  @override
  void dispose() {
    super.dispose();
    releaseTFlite();
    cameraController.dispose();
  }

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isCameraInitialized = false.obs;
  var cameraCount = 0;

  var x, y, w, h = 0.0;
  var label = "";

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      print("Permission denied");
    }
  }

  initTFlite() async {
    await Tflite.loadModel(
      model: "assets/model/ssd_mobilenet.tflite",
      labels: "assets/model/ssd_mobilenet.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  releaseTFlite() async {
    await Tflite.close();
  }

  objectDetector(CameraImage image) async {
    bool detectorReady = false;
    List<dynamic>? detector;

    try {
      detector = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: "SSDMobileNet",
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        threshold: 0.1,
        asynch: true,
      );
      detectorReady = true;
    } catch (e) {
      debugPrint("Error in object detection: $e");
    }

    if (detectorReady && detector != null && detector.isNotEmpty) {
      log("Result is $detector");

      if (detector.first["confidenceInClass"] * 100 > 45) {
        label = detector.first["detectedClass"].toString();
        h = detector.first['rect']['h'];
        w = detector.first['rect']['w'];
        x = detector.first['rect']['x'];
        y = detector.first['rect']['y'];
      }
      update();
    }
  }
}
