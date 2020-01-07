import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/model/question_model.dart';
import 'package:zabh_halal/model/user_mode.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs/5-more/subPages/bank_accounts.dart';
import 'package:zabh_halal/ui/tabs/5-more/subPages/contactus_page.dart';
import 'package:zabh_halal/ui/tabs/5-more/subPages/policy.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

import 'package:zabh_halal/utilities/colors.dart';

class MoreInfo extends StatefulWidget {
  @override
  _MoreInfoState createState() => _MoreInfoState();
}

bool loading = false;
bool loadingPolicy = false;

class _MoreInfoState extends State<MoreInfo> {
  bool isLoading = false;
  startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(baseModel.userData.data.apiToken);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              textColor: Colors.white,
              title: "المزيد",
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ContactUsPage()));
              },
              child: customContainer(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios),
                    TextD(
                      title: 'اتصل بنا',
                      fontSize: 18,
                    ),
                  ],
                ),
              ))),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BankAccounts()));
            },
            child: customContainer(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.arrow_back_ios),
                    TextD(
                      title: 'حساباتنا',
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ScopedModelDescendant<BaseModel>(builder: (context, child, model) {
            TextEditingController questionCtrler = TextEditingController();
            return Builder(
                // future: model.getQuestion(context),
                builder: (context) {
              return loading
                  ? customContainer(
                      color: Colors.white,
                      child: Center(
                        child: Loading(
                          indicator: BallPulseIndicator(),
                          color: ColorsD.redDefault,
                        ),
                      ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          loading = true;
                        });
                        model.getQuestion(context).then((q) {
                          setState(() {
                            loading = false;
                          });
                          if (q != null)
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: ColorsD.redDefault)),
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextD(
                                            title: q.data.products.question,
                                            fontSize: 18,
                                            textColor: ColorsD.redDefault,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextField(
                                            controller: questionCtrler,
                                            style:
                                                TextStyle(fontFamily: 'thin'),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: ColorsD.redDefault),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            ClippedButton(
                                              color: Colors.white,
                                              child: TextD(
                                                title: 'الرجوع',
                                                textColor: ColorsD.redDefault,
                                              ),
                                              onTapCallback: () =>
                                                  Navigator.of(context).pop(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.4,
                                            ),
                                            ClippedButton(
                                              color: ColorsD.redDefault,
                                              child: TextD(
                                                title: 'أرسل الإجابة',
                                                textColor: Colors.white,
                                              ),
                                              onTapCallback: () async {
                                                await baseModel
                                                    .answerQuestion(context,
                                                        '${questionCtrler.text}')
                                                    .then((_) {
                                                  Navigator.pop(context);
                                                });
                                                AlertDialogs.success(context,
                                                    content:
                                                        'نشكركم على ابداء رأيكم');
                                                // Navigator.pop(context);
                                              },
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.4,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                        });
                      },
                      child: customContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.arrow_back_ios),
                              TextD(
                                title: 'سؤال',
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            });
          }),
          ScopedModelDescendant<BaseModel>(
              rebuildOnChange: false,
              builder: (context, child, model) {
                return Builder(builder: (context) {
                  return loadingPolicy
                      ? customContainer(
                          child: Center(
                              child: Loading(
                                  indicator: BallPulseIndicator(),
                                  color: ColorsD.redDefault)),
                          color: Colors.white)
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              loadingPolicy = true;
                            });
                            model.getContactInfo(context).then((info) {
                              setState(() {
                                loadingPolicy = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy(
                                      info.data.settings.policy)));
                            });
                          },
                          child: customContainer(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.arrow_back_ios),
                                  TextD(
                                    title: 'سياسة الإستخدام',
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                });
              }),
          baseModel.isAuth
              ? ClippedButton(
                  child: TextD(
                    title: "تسجيل الخروج",
                    textColor: Colors.white,
                    fontSize: 18,
                  ),
                  color: ColorsD.redDefault,
                  onTapCallback: () async {
                    SharedPreferences.getInstance().then((pref) {
                      baseModel.userData = null;
                      baseModel.allProducts = [];
                      pref.clear();
                      baseModel.checkAuth();
                      setState(() {});
                    });
                  },
                )
              : ClippedButton(
                  child: TextD(
                    title: "تسجيل الدخول",
                    textColor: Colors.white,
                    fontSize: 18,
                  ),
                  color: ColorsD.redDefault,
                  onTapCallback: () {
                    showDialog(
                        context: context,
                        builder: (context) =>  _phoneDialogue()).then((_) {
                      setState(() {});
                    });
                  },
                )
        ],
      ),
    );
  }

  Widget _phoneDialogue(){
    return Builder(builder: (context) {
                              // isLoading = false;
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side:
                                        BorderSide(color: ColorsD.redDefault)),
                                content: _buildEnterPhone(),
                                actions: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ClippedButton(
                                        color: Colors.white,
                                        child: TextD(
                                          title: 'الرجوع',
                                          textColor: ColorsD.redDefault,
                                        ),
                                        onTapCallback: () =>
                                            Navigator.of(context).pop(),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.4,
                                      ),
                                      isLoading
                                          ? Loading(
                                              color: ColorsD.redDefault,
                                              indicator: BallPulseIndicator(),
                                            )
                                          : ClippedButton(
                                              color: ColorsD.redDefault,
                                              child: TextD(
                                                title: 'التسجيل',
                                                textColor: Colors.white,
                                              ),
                                              onTapCallback: () async {
                                                if (key.currentState
                                                    .validate() && !isLoading) {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  await baseModel
                                                      .login(context,
                                                          '966${phoneCtrler.text}')
                                                      .then((user) {
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    Navigator.pop(context);
                                                    if (user.msg == 'success')
                                                      AlertDialogs.success(
                                                          context,
                                                          content:
                                                              'تم تسجيل دخولك بنجاح');
                                                    // Navigator.of(context).pop();
                                                  });
                                                }
                                              },
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.4,
                                            ),
                                    ],
                                  ),
                                ],
                              );
                            });
  }

  TextEditingController phoneCtrler = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Widget _buildEnterPhone() {
    return Container(
        height: MediaQuery.of(context).size.height / 2.5,
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
                child: Form(
                  key: key,
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    validator: (s) {
                      if (s.length < 9) return "من فضلك أدخل رقم صحيح";
                    },
                    controller: phoneCtrler,
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
            ),
          ],
        ));
  }

  Widget customContainer({Widget child, double height = 45, Color color}) {
    Color newColor = color == null ? Colors.white : color;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 7, color: Colors.grey)],
          color: newColor,
        ),
        child: child,
      ),
    );
  }
}
