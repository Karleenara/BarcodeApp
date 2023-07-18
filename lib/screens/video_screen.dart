import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'onboard_screen.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<CameraDescription>? cameras = [];
  late CameraController controller;
  bool isRecording = false;
  late String videoPath;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final camera = cameras!.first;
    controller = CameraController(camera, ResolutionPreset.high);
    // final camera = cameras.first;
    // controller = CameraController(camera, ResolutionPreset.high);
    await controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startRecording() async {
    if (!controller.value.isInitialized) {
      return;
    }

    final Directory appDirectory = await getTemporaryDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    videoPath = '$videoDirectory/$timestamp.mp4'; // 클래스 멤버인 videoPath에 할당

    try {
      await controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void stopRecording() async {
    if (!controller.value.isRecordingVideo) {
      return;
    }

    final Directory appDirectory = await getTemporaryDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final videoPath = '$videoDirectory/$timestamp.mp4';

    try {
      await controller.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      print('Video recorded to: $videoPath');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recorder'),
        backgroundColor: Color(0xFF3A3A3A),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
                color: isRecording ? Colors.red : Colors.black,
                onPressed: () {
                  if (isRecording) {
                    stopRecording();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPageWidget()),
                    );
                  } else {
                    startRecording();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
