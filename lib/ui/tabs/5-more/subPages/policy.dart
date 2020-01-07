import 'package:flutter/material.dart';
import 'package:zabh_halal/utilities/colors.dart';
class PrivacyPolicy extends StatefulWidget {
  final String policy;

  PrivacyPolicy(this.policy);
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              textColor: Colors.white,
              title: "سياسة الإستخدام",
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: TextD(title: '${widget.policy}',fontSize: 22,),
            )
          ],
        ),
      )
    );
  }
}