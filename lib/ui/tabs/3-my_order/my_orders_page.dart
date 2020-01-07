import 'package:flutter/material.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/cart.dart';
import 'package:zabh_halal/utillities.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  TextEditingController codeCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                textColor: Colors.white,
                title: "طلباتى",
                fontSize: 18,
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/icons/4.0x/talab.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: codeCtrler,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "ادخل كود الطلب",
                        hintStyle: TextStyle(fontFamily: 'thin')),
                  ),
                ),
              ),
              ClippedButton(
                child: TextD(
                  title: 'تابع الطلب',
                  textColor: Colors.white,
                  fontSize: 18,
                ),
                onTapCallback: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingCart(id: codeCtrler.text,))),
                color: ColorsD.redDefault,
              )
            ],
          ),
        ));
  }
}
