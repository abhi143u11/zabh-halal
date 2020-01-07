import 'package:flutter/material.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/utillities.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  int _currentOffer = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 20),
              child: Text(
                "العروض",
                style: TextStyle(
                    fontSize: 16, color: Colors.white, fontFamily: "thin"),
              ),
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: []
            ..add(
              Align(
                child: Text(
                  'قم بتحديد العرض الذى تريده',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 26,
                    fontFamily: 'thin',
                  ),
                ),
              ),
            )
            ..addAll(
              List.generate(10, (index) {
                return _buildRadioOffers(index);
              }),
            )
            ..addAll([
              ClippedButton(
                  color: Colors.grey[300],
                  onTapCallback: () => Navigator.pop(context),
                  child: TextD(
                    title: "الرجوع للصفحة الرئيسية",
                    fontSize: 16,
                  )),
              ClippedButton(
                  color: ColorsD.redDefault,
                  child: TextD(
                    title: "طلب",
                    textColor: Colors.white,
                    fontSize: 16,
                  ))
            ]),
        ));
  }

  Widget _buildRadioOffers(int index) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
            ),
          ]),
      child: RadioListTile(
        controlAffinity: ListTileControlAffinity.leading,
        isThreeLine: true,
        secondary: Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                height: 50,
                width: 100,
                color: Colors.green,
                child: Image.network(
                  'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
                  fit: BoxFit.contain,
                )),
          ),
        ),
        subtitle: TextD(
          title: '980 ر.س',
          textDirection: TextDirection.rtl,
          textColor: ColorsD.redDefault,
        ),
        title: TextD(
          title: 'بربرى مناسب لجميع الحاجات',
          fontSize: 18,
        ),
        groupValue: _currentOffer,
        value: index,
        onChanged: (val) {
          setState(() {
            _currentOffer = val;
          });
        },
      ),
    );
  }
}
