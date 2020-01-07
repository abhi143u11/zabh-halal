import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs_page.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

class DonePayment extends StatefulWidget {
  final String orderID;

  const DonePayment({Key key, this.orderID}) : super(key: key);

  @override
  _DonePaymentState createState() => _DonePaymentState();
}

class _DonePaymentState extends State<DonePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              title: 'الشراء',
              fontSize: 22,
              textColor: Colors.white,
              height: 0.8,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/true.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                TextD(
                  title:
                      'تم تجهيز طلبكم رقم ${widget.orderID}\nوفى انتظار تسليمه',
                  fontSize: 24,
                )
              ],
            ),
            ClippedButton(
              onTapCallback: () {
                SharedPreferences.getInstance().then((pref){
                  baseModel.allProducts =[];
                  pref.setString('products', json.encode([]));
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TabsPage()), (Route route)=>false);
                });
              },
              color: ColorsD.redDefault,
              child: TextD(
                title: 'الرجوع للصفحة الرئيسية',
                textColor: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
