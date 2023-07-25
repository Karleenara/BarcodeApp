import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'onboard_screen.dart';

class VideoScreen extends StatefulWidget {
  late final String? barcode;
  VideoScreen({this.barcode});
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<CameraDescription>? cameras = [];
  CameraController? _controller;
  bool isRecording = false;
  late String videoPath;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    //startRecording();
  }


  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final camera = cameras!.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
    startRecording();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }



  void startRecording() async {
    if (isRecording || _controller!.value.isRecordingVideo) {
      return;
      }

      final Directory appDirectory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      videoPath = '${appDirectory.path}/$timestamp.mp4'; // 클래스 멤버인 videoPath에 할당

      try {
        await _controller!.startVideoRecording();
        setState(() {
          isRecording = true;
        });
      } catch (e) {
        print(e);
      }

    Future.delayed(Duration(seconds: 3), () {
      stopRecording();
    });
    }


  void stopRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      print('Video recorded to: $videoPath');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPageWidget()),
      );

    } catch (e) {
      print('Error stopRecoding: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_controller==null || !_controller!.value.isInitialized) {
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
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
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
                    print(isRecording);
                    stopRecording(); // 녹화 중이면 중지
                  } else {
                    startRecording(); // 녹화 중이 아니면 시작
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
