import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:path_provider/path_provider.dart';

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
  DateTime? _preBarcodeTime;    // 이전 바코드 인식한 시간 저장
  Timer? _barcodeTimer;     // 바코드 인식 후 종료를 체크하기 위한 타이머
  String? _qrInfo;

  @override
  void initState() {
    super.initState();
    initializeCamera();
    startRecording();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final camera = cameras!.first;
    _controller = CameraController(camera, ResolutionPreset.medium);
    // final camera = cameras.first;
    // controller = CameraController(camera, ResolutionPreset.high);
    await _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }



  void startRecording() async {
    if (isRecording) {
      return;
    }

    final Directory appDirectory = await getTemporaryDirectory();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String videoPath = '/assets/video/$timestamp.mp4'; // 클래스 멤버인 videoPath에 할당

    try {
      await _controller!.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
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
      if (widget.barcode == _qrInfo) {
        _qrInfo = null;
        widget.barcode = null;

      }
    } catch (e) {
      print(e);
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
              child : Stack(
                children: [
                  CameraPreview(_controller!),
                  Positioned.fill(
                      child: QRBarScannerCamera(
                        onError: (context, error) => Text(
                          error.toString(),
                          style: TextStyle(color: Colors.red),
                        ), qrCodeCallback: (code) {
                        setState(() {
                          _qrInfo = code;
                        });
                      },
                  ))
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(isRecording ? Icons.stop : Icons.fiber_manual_record),
                color: isRecording ? Colors.red : Colors.black,
                onPressed: isRecording ? stopRecording : startRecording,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
