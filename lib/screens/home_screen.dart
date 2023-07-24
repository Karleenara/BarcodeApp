import 'package:smooth_page_indicator/smooth_page_indicator.dart'
as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'onboard_screen.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = OnboardingModel();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.8,
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                                child: PageView(
                                  controller: _model.pageViewController ??=
                                      PageController(initialPage: 2),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/easily_capture_and_record.png',
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/Video_file.png',
                                        width: 300,
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/images/You_can_record_videos_by_scanning_invoice_barcode_with_your_phone.png',
                                        width: 300,
                                        height: 85,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 50),
                                  child:
                                  smooth_page_indicator.SmoothPageIndicator(
                                    controller: _model.pageViewController ??=
                                        PageController(initialPage: 2),
                                    count: 3,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) async {
                                      await _model.pageViewController!
                                          .animateToPage(
                                        i,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    effect: smooth_page_indicator
                                        .ExpandingDotsEffect(
                                      expansionFactor: 3,
                                      spacing: 8,
                                      radius: 16,
                                      dotWidth: 20,
                                      dotHeight: 5,
                                      dotColor: Color(0xFFF0C0D7),
                                      activeDotColor: Color(0xFFE78CB9),
                                      paintStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPageWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE78CB9),
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(    // 모서리 둥글게
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                    child: Text('Continue',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingModel extends ChangeNotifier {
  // 모델의 상태를 관리하는 변수들을 선언합니다.
  // 예시로 pageViewController 변수를 추가하였습니다.
  PageController? pageViewController;

  // _unfocusNode 변수 추가
  final FocusNode _unfocusNode = FocusNode();

  // unfocusNode getter 수정
  FocusNode get unfocusNode => _unfocusNode;

  // 모델이 더 이상 사용되지 않을 때 호출되는 메서드입니다.
  void dispose() {
    pageViewController?.dispose();
    super.dispose();
  }
}
