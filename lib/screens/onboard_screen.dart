import 'package:flutter/material.dart';
import 'barcode_screen.dart';
import 'filePicker_screen.dart';

class MenuPageWidget extends StatefulWidget {
  const MenuPageWidget({Key? key}) : super(key: key);

  @override
  _MenuPageWidgetState createState() => _MenuPageWidgetState();
}

class _MenuPageWidgetState extends State<MenuPageWidget> {
  late LoggedinPageModel _model;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = LoggedinPageModel();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // GestureDetector 위젯 : 터치 이벤트 처리
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(    // Scaffold : 전체적인 화면 구조를 나타내는 Scaffold 위젯
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(     // SafeArea : 상단바와 겹치지 않는 안전한 영역 나타내는 위젯
          top: true,
          child: Align(   // Align : 자식 위젯을 정렬하기 위한 Align 위젯
            alignment: AlignmentDirectional(0, -1),
            child: Padding(   // Padding : 여백 주기
              padding: EdgeInsetsDirectional.fromSTEB(20, 100, 20, 0),
              child: Container(   // 박스 위젯에 배경색과 그림자 효과주기
                width: 515,
                height: 236,
                decoration: BoxDecoration(
                  //  color: FlutterFlowTheme.of(context).secondaryBackground
                  color: Color(0xffea99c6),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 0),
                                child: InkWell(     // 터지에 반응하는 효과를 줄 수 있는 위젯
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {   // 페이지 이동 (라우팅)
                                    // context.pushNamed('camera'); XX
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BarcodeScreen()),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/barcode.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 0),
                                  child: InkWell(     // 터지에 반응하는 효과를 줄 수 있는 위젯
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {   // 페이지 이동 (라우팅)
                                      // context.pushNamed('camera'); XX
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BulkUpload()),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/816x6_.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/checklist.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/video.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 0),
                              child: InkWell(     // 터지에 반응하는 효과를 줄 수 있는 위젯
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {   // 페이지 이동 (라우팅)
                                  // context.pushNamed('camera'); XX
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BarcodeScreen()),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/cogwheel.png',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
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
            ),
          ),
        ),
      ),
    );
  }
}

class LoggedinPageModel extends ChangeNotifier {
  // 모델의 상태를 관리하는 변수들을 선언합니다.
  // 예시로 isLoggedIn 변수를 추가하였습니다.
  bool isLoggedIn = false;

  // _unfocusNode 변수 추가
  final FocusNode _unfocusNode = FocusNode();

  // unfocusNode getter 수정
  FocusNode get unfocusNode => _unfocusNode;

  // 로그인 상태를 변경하는 메서드
  void toggleLoggedIn() {
    isLoggedIn = !isLoggedIn;
    notifyListeners();
  }
}
