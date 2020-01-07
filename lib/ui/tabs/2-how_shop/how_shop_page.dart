import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:zabh_halal/model/contactUs_model.dart';
import 'package:zabh_halal/model/settings_nodel.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utillities.dart';

class HowShopPage extends StatefulWidget {
  @override
  _HowShopPageState createState() => _HowShopPageState();
}

class _HowShopPageState extends State<HowShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.blue,
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Utility.c,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                textColor: Colors.white,
                title: "كيف تتسوق",
                fontSize: 18,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: FutureBuilder<SettingsModel>(
              future: baseModel.getContactInfo(context),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.refresh,
                            color: Colors.grey,
                            size: 55,
                          ),
                          TextD(
                            title: 'فشل الاتصال',
                          ),
                        ],
                      ),
                    ),
                  );
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                      child: Loading(
                    color: ColorsD.redDefault,
                    indicator: BallPulseIndicator(),
                  ));
                return Center(
                  child: ListView(shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextD(
                          title: '${snapshot.data.data.settings.myWay}',
                          fontSize: 18,
                        )
                      ]),
                );
              }),
        ));
  }

  List<Widget> _buildHowToTexts() {
    return [
      Align(
        alignment: Alignment.center,
        child: TextD(
          title: 'هذا النص مثال لنص يمكن ان يستخدم',
          fontSize: 18,
          textColor: ColorsD.redDefault,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: TextD(
          title:
              'هذا النص مثال لنص يمكن ان يستخدم هذا النص مثال لنص يمكن ان يستخدم هذا النص مثال لنص يمكن ان يستخدم',
          fontSize: 12,
          height: 0.5,
        ),
      ),
    ];
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
