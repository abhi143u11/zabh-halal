import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/pacman_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:zabh_halal/resources/auth.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/utillities.dart';
import 'package:zabh_halal/ui/tabs_page.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  AnimationController anim;
  AnimationController anim2;
  Animation align;
  Animation align2;
  Animation opacity;
  Animation size;
  Animation width;
  TextEditingController phoneController = TextEditingController();
  String enteredCode;
  @override
  Duration _duration;
  Duration _duration2;
  // Duration _minuteDur;
  // Timer time;
  List<Widget> registerSteps;
  int index = 0;
  VideoPlayerController videoPlayerController;
  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController?.dispose();
    anim?.dispose();
    anim2?.dispose();
    super.dispose();
  }

  void initState() {
    videoPlayerController = VideoPlayerController.asset(
      'assets/images/23.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    _duration = new Duration(seconds: 4);
    _duration2 = new Duration(seconds: 2);
    // _minuteDur = new Duration(minutes: 1);
    // TODO: implement initState
    // startTime();
    anim = AnimationController(
      vsync: this,
      duration: _duration,
    )..addListener(() => setState(() {}));
    anim2 = AnimationController(
      vsync: this,
      duration: _duration,
    )..addListener(() => setState(() {}));
    align = AlignmentTween(
            begin: Alignment.center,
            end: Alignment.lerp(Alignment.center, Alignment.topCenter, 0.5))
        .animate(
      CurvedAnimation(
        parent: anim,
        curve: Interval(0.5, 0.75, curve: Curves.easeInCubic),
      ),
    );
    align2 = AlignmentTween(
            begin:
                Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.7),
            end: Alignment.bottomCenter)
        .animate(
      CurvedAnimation(
        parent: anim2,
        curve: Interval(0.3, 0.7, curve: Curves.easeInCubic),
      ),
    );
    width = Tween<double>(begin: 400, end: 200).animate(
      CurvedAnimation(
        parent: anim2,
        curve: Interval(0.3, 0.7, curve: Curves.easeInCubic),
      ),
    );
    opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: anim,
        curve: Interval(0.75, 1, curve: Curves.easeInCubic),
      ),
    );
    size = Tween<Size>(begin: Size.square(200), end: Size.square(150)).animate(
      CurvedAnimation(
        parent: anim,
        curve: Interval(0.5, 0.75, curve: Curves.easeInCubic),
      ),
    );
    // align.addListener(() => setState(() {}));
    anim.forward().then((f) => countDown());
    super.initState();
  }

  int counter = 60;
  countDown() {
    Timer timer;
    timer = Timer.periodic(Duration(seconds: 1), (s) {
      setState(() => --counter);
      if (counter == 0) timer.cancel();
    });
  }

  startTime() async {
    return new Timer(_duration, () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return TabsPage();
      }), (Route<dynamic> route) => false);
    });
  }

  List<String> btnTags = ['التسوق', 'التحقق', 'التسجيل'];
  double opaque = 1;
  DeviceOrientation orientation = DeviceOrientation.portraitUp;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([orientation]);

    registerSteps = [
      _buildAnswerWithTimer(),
      _buildEnterPhone(),
      // _buildEnterPinCode(),
    ];
    // Share.share()
    return Container(
      // model: baseModel,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LoadablePage(
              isLoading: BaseModel.isLoading,
              children: []
                ..add(Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/images/splash.png',
                    fit: BoxFit.cover,
                  ),
                ))
                ..add(_buildAfterSplash())
                ..add(
                  AnimatedOpacity(
                    opacity: opaque,
                    duration: Duration(milliseconds: 500),
                    child: Align(
                      alignment: align.value,
                      child: Container(
                        constraints: BoxConstraints.tight(size.value),
                        child: Image.asset('assets/icons/logo.png'),
                      ),
                    ),
                  ),
                ))),
    );
  }

  Widget _buildText(String title, {bool noDeco = false}) {
    return Container(
        margin: EdgeInsets.only(left: 6),
        constraints: BoxConstraints.tight(Size.square(40)),
        alignment: Alignment.center,
        decoration: noDeco
            ? null
            : BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)]),
        child: TextD(
          fontSize: 32,
          textColor: ColorsD.redDefault,
          title: title,
          height: 0.7,
        ));
  }

  Widget _buildAnswerWithTimer() {
    return Align(
      alignment: Alignment.center,
      child: Opacity(
        opacity: opacity.value,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextD(
            textColor: ColorsD.redDefault,
            title: 'أجب عن السؤال التالى',
            fontSize: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TextD(
              height: 0.5,
              textColor: Colors.grey,
              fontSize: 16,
              title:
                  'هذا النص هو عبارة عن نص يمكن ان يكون نص ولكنه ليس نصاولا ايه؟',
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildEnterPhone() {
    return Align(
        alignment:
            Alignment.lerp(Alignment.bottomCenter, Alignment.center, 0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextD(
              title: 'الرجاء إدخال رقم الجوال',
              textColor: ColorsD.redDefault,
              fontSize: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  // textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 6, 8, 0),
                      hintText: '548252956',
                      hintStyle:
                          TextStyle(fontFamily: 'thin', color: Colors.grey),
                      prefixIcon: Container(
                        // height: 50,
                        width: 75,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset('assets/icons/whatsapp.png'),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: TextD(
                                title: '+966',
                                textDirection: TextDirection.ltr,
                                fontSize: 16,
                                textColor: Colors.black54,
                              ),
                            )
                          ],
                        ),
                      ),
                      suffixIcon: Icon(Icons.phone)),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildEnterPinCode() {
    return Align(
        alignment:
            Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextD(
              title: "أدخل رمز التحقق",
              textColor: ColorsD.redDefault,
              fontSize: 24,
            ),
            VerificationCodeInput(
              autofocus: false,
              keyboardType: TextInputType.number,
              onCompleted: (s) {
                enteredCode = s;
              },
              textStyle:
                  TextStyle(fontFamily: 'thin', fontSize: 24, height: 0.8),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextD(
                      title: '0', fontSize: 24, textColor: ColorsD.redDefault),
                  TextD(
                      title: '0', fontSize: 24, textColor: ColorsD.redDefault),
                  TextD(
                      title: ':', fontSize: 24, textColor: ColorsD.redDefault),
                  TextD(
                      title: '0', fontSize: 24, textColor: ColorsD.redDefault),
                  TextD(
                      title: '0', fontSize: 24, textColor: ColorsD.redDefault),
                ],
              ),
            ),
            TextD(
                title: 'إعادة الإرسال',
                textColor: ColorsD.redDefault,
                fontSize: 24)
          ],
        ));
  }

  CrossFadeState fadeState = CrossFadeState.showFirst;
  Widget _buildFadedAfterSplash() {
    return AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: fadeState,
        firstChild: _buildSplashWidgets(),
        alignment: Alignment.center,
        secondChild: _buildAfterSplash());
  }

  Widget _buildSplashWidgets() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(children: [
        registerSteps[index],
        Visibility(
          visible: index == 0,
          child: Align(
            alignment:
                Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.45),
            child: Opacity(
              opacity: opacity.value,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildText('0'),
                  _buildText('0'),
                  _buildText(':', noDeco: true),
                  _buildText('${counter ~/ 10}'),
                  _buildText('${counter % 10}'),
                ],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: opacity.value,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ScopedModelDescendant<BaseModel>(
                builder: (context, child, model) {
              return ClippedButton(
                child: TextD(
                    textColor: Colors.white,
                    title: btnTags[index],
                    fontSize: 24,
                    height: 0.8),
                color: ColorsD.redDefault,
                onTapCallback: () async {
                  fadeState = CrossFadeState.showSecond;
                  // switch (index) {
                  //   case 0:
                  //     index++;
                  //     break;
                  //   case 1:
                  //     if (await model.register(
                  //             '966${phoneController.text}', context) !=
                  //         null) index++;
                  //     break;
                  //   case 2:
                  //     if (await model.verifyCode(context, enteredCode) != null)
                  //     break;
                  //   default:
                  //     break;
                  // }
                  setState(() {});
                  // if (index < 2)
                  //   index++;
                  // else
                  //   fadeState = CrossFadeState.showSecond;
                },
              );
            }),
          ),
        )
      ]),
    );
  }

  bool isPlaying = false;
  String knowUs = 'تعرف علينا';
  Widget _buildAfterSplash() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.cyan,
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              child: videoPlayerController.value.initialized &&
                      videoPlayerController.value.isPlaying
                  ? AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(
                        videoPlayerController,
                      ),
                    )
                  : Image.asset(
                      'assets/images/splash2.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          AnimatedOpacity(
            opacity: opacity.value,
            duration: Duration(milliseconds: 500),
            child: Align(
              alignment: Alignment.lerp(
                  Alignment.bottomCenter, Alignment.center, 0.15),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, anim, secAnim) => TabsPage())),
                  child: opaque == 0
                      ? Container()
                      : AnimatedOpacity(
                          opacity: opaque,
                          duration: Duration(milliseconds: 500),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Align(
                                child: TextD(
                                    title: 'إبدأ التسوق',
                                    fontSize: 22,
                                    height: 0.85,
                                    textColor: Colors.white)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black26,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 19, color: Colors.black26)
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: opacity.value,
            duration: Duration(milliseconds: 500),
            child: Align(
              alignment: align2.value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    print('----------------brfore-------------');
                    print('----------------after-------------');
                    if (videoPlayerController.value.isPlaying) {
                      print('----------------isStopped-------------');
                      videoPlayerController.pause().then((_) {
                        orientation = DeviceOrientation.portraitUp;
                        setState(() {});
                      });
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, anim, secAnim) =>
                                  TabsPage()));
                    } else {
                      print('----------------isPlaying-------------');
                      videoPlayerController.play();
                      setState(() {
                        orientation = DeviceOrientation.landscapeRight;
                        align = AlignmentTween(
                                begin: align.value, end: Alignment.topCenter)
                            .animate(
                          CurvedAnimation(
                            parent: anim,
                            curve:
                                Interval(0.0, 0.25, curve: Curves.easeInCubic),
                          ),
                        );
                        // anim.reset();
                        // anim.forward();
                        anim2.forward();
                        opaque = 0;
                        knowUs = "تخطى";
                      });
                    }
                  },
                  child: Container(
                    width: width.value,
                    height: 50,
                    child: Align(
                      child: TextD(
                          title: knowUs,
                          fontSize: 22,
                          height: 0.85,
                          textColor: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black26,
                        boxShadow: [
                          BoxShadow(blurRadius: 19, color: Colors.black26)
                        ],
                        border: Border.all(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
