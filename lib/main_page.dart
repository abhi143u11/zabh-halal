import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utillities.dart';

import 'offers_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  String _Name, _PhoneNumber, _Area;
  String dropdownValue = 'المدينة';
  int counter = 0;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(vsync: this, length: 2, initialIndex: 1);
    super.initState();
  }

  /// ============================== Next ==============================//

  /// =================================================================//

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      ///first
      _buildFirstOrder(),

      ///secound
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 20),
              child: Image.asset(
                "assets/images/2.png",
                fit: BoxFit.cover,
              )),
          Utility.contaner(
              Colors.white,
              context,
              Text(
                "طريقة التقطيع",
                style: TextStyle(
                    fontFamily: "black", color: Utility.c, fontSize: 18),
              )),
          Utility.contaner(
              Colors.white,
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PopupMenuButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onSelected: (value) => setState(() {
                      dropdownValue = value;
                    }),
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  Text(
                    dropdownValue,
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "thin", fontSize: 15),
                  ),
                ],
              )),
          _buildNext()
        ],
      ),

      ///third
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 20),
              child: Image.asset(
                "assets/images/3.png",
                fit: BoxFit.cover,
              )),
          Utility.contaner(
              Colors.white,
              context,
              Text(
                "طريقة التغليف",
                style: TextStyle(
                    fontFamily: "black", color: Utility.c, fontSize: 18),
              )),
          Utility.contaner(
              Colors.white,
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PopupMenuButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onSelected: (value) => setState(() {
                      dropdownValue = value;
                    }),
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  Text(
                    dropdownValue,
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "thin", fontSize: 15),
                  ),
                ],
              )),
          _buildNext()
        ],
      ),

      ///fourth
//      showDialog(
//                    context: context,
//                    builder: (_) {
//                      return MyDialog();
//                    });,
      null,

      ///fives
      Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 20),
              child: Image.asset(
                "assets/images/5.png",
                fit: BoxFit.cover,
              )),
          Utility.contaner(
              Colors.white,
              context,
              Text(
                "ادخل بياناتك",
                style: TextStyle(
                    fontFamily: "black", color: Utility.c, fontSize: 18),
              )),
          Utility.contaner(
              Colors.white,
              context,
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    _Name = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "ادخل الاسم";
                  }
                  return null;
                },
                cursorColor: Utility.c,
                style: TextStyle(fontSize: 15, color: Utility.c),
                textAlign: TextAlign.right,
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(
                      fontSize: 15, color: Colors.grey, fontFamily: "thin"),
                  hintText: "الاسم",
                ),
              )),
          Utility.contaner(
              Colors.white,
              context,
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    _PhoneNumber = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "ادخل رقم الموبايل";
                  }
                  return null;
                },
                cursorColor: Utility.c,
                style: TextStyle(fontSize: 15, color: Utility.c),
                textAlign: TextAlign.right,
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(
                      fontSize: 15, color: Colors.grey, fontFamily: "thin"),
                  hintText: "رقم الجوال",
                ),
              )),
          Utility.contaner(
              Colors.white,
              context,
              TextFormField(
                onSaved: (value) {
                  setState(() {
                    _Area = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "ادخل الحي";
                  }
                  return null;
                },
                cursorColor: Utility.c,
                style: TextStyle(fontSize: 15, color: Utility.c),
                textAlign: TextAlign.right,
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(
                      fontSize: 15, color: Colors.grey, fontFamily: "thin"),
                  hintText: "الحي",
                ),
              )),
          Utility.contaner(
              Colors.white,
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PopupMenuButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onSelected: (value) => setState(() {
                      dropdownValue = value;
                    }),
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  Text(
                    dropdownValue,
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "thin", fontSize: 15),
                  ),
                ],
              )),
          Utility.contaner(
              Colors.white,
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PopupMenuButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onSelected: (value) => setState(() {
                      dropdownValue = value;
                    }),
                    itemBuilder: (BuildContext context) {
                      return Constants.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  Text(
                    dropdownValue,
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "thin", fontSize: 15),
                  ),
                ],
              )),
          Utility.contaner(
              Utility.c,
              context,
              Text(
                "ارسل الطلب",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: "thin"),
              )),
          _buildNext(),
        ],
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Utility.c,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 20),
              child: Text(
                "الشراء",
                style: TextStyle(
                    fontSize: 16, color: Colors.white, fontFamily: "thin"),
              ),
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                widgets[counter],

                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (counter == 1) {
                        counter = 0;
                      } else if (counter == 2) {
                        counter = 1;
                      } else if (counter == 4) {
                        counter = 2;
                      }
                    });
                  },
                  child: counter == 0
                      ? Container()
                      : Utility.contaner(
                          Colors.grey,
                          context,
                          Text(
                            "السابق",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "thin",
                                color: Colors.white),
                          )),
                ),

                ///---------first column------------

                ///---------second column------------

                ///---------third column------------

                ///---------fourth column------------

                ///---------fives column------------
              ],
            ),
          ),
        ));
  }

  Widget _buildOrdinaryOrder() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Utility.contaner(
            Colors.white,
            context,
            Text(
              "اختر المنتج",
              style: TextStyle(
                  fontFamily: "black", color: Utility.c, fontSize: 18),
            )),
        Container(
          height: MediaQuery.of(context).size.height / 4.5,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: FadeInImage.assetNetwork(
              height: MediaQuery.of(context).size.width / 3 - 40,
              placeholder: "assets/images/reload2.gif",
              image:
                  "https://i2.wp.com/www.caironewss.com/wp-content/uploads/%D8%AE%D8%B1%D9%88%D9%81-%D8%A7%D9%84%D8%B9%D9%8A%D8%AF.png?fit=450%2C328",
              fit: BoxFit.fill),
        ),
        Utility.contaner(
            Colors.white,
            context,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                PopupMenuButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onSelected: (value) => setState(() {
                    dropdownValue = value;
                  }),
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
                Text(
                  dropdownValue,
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "thin", fontSize: 15),
                ),
              ],
            )),
        Utility.contaner(
            Colors.white,
            context,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "ريال سعودي",
                  style: TextStyle(
                      color: Colors.grey, fontSize: 15, fontFamily: "thin"),
                ),
                Text("110",
                    style: TextStyle(
                        color: Utility.c, fontSize: 15, fontFamily: "thin")),
                Text(": السعر",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 15, fontFamily: "thin"))
              ],
            )),
        _buildNext(),
        _buildOfferButton()
      ],
    );
  }

  Widget _buildSpecialOffer() {
    return Container();
  }

  Widget _buildFirstOrder() {
    return Expanded(
      // height: 200,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 20),
            child: Image.asset(
              "assets/images/1.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TabBar(
              unselectedLabelColor: ColorsD.redDefault,
              indicator: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
                  borderRadius: BorderRadius.circular(30),
                  color: ColorsD.redDefault),
              controller: tabController,
              tabs: <Widget>[
                Tab(
                  text: 'طلب عادى',
                ),
                Tab(
                  text: 'طلب غير عادى',
                ),
              ],
            ),
          ),
          Expanded(
            // height: 100,
            // width: 100,
            // constraints: BoxConstraints.expand(),
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                _buildSpecialOffer(),
                _buildOrdinaryOrder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferButton() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => OffersPage())),
      child: Utility.contaner(
        Colors.white,
        context,
        Text(
          'العروض',
          style: TextStyle(
            fontFamily: 'thin',
            fontSize: 15,
            color: Utility.c,
          ),
        ),
      ),
    );
  }

  Widget _buildNext() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (counter == 0) {
            counter = 1;
          } else if (counter == 1) {
            counter = 2;
          } else if (counter == 2) {
            showDialog(
                context: context,
                builder: (_) {
                  return MyDialog();
                });
            counter = 4;
          }
        });
      },
      child: counter == 4
          ? Container()
          : Utility.contaner(
              Utility.c,
              context,
              Text(
                "التالي",
                style: TextStyle(
                    fontSize: 15, fontFamily: "thin", color: Colors.white),
              )),
    );
  }
}

class Constants {
  static const List<String> choices = <String>[
    'First Item',
    'Second Item',
    'Third Item',
  ];
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _Check = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.transparent,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                "تفاصيل الطلب",
                style: TextStyle(
                    fontSize: 15, fontFamily: "thin", color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: Utility.c,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 12, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "بربري مناسب للثلاجةو الصدفات",
                    style: TextStyle(
                        fontFamily: "thin", fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "بربري منال نتةن يبنيتبني للثلاجةو الصدفات",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: "thin", fontSize: 14, color: Colors.grey),
                  ),
                  Utility.contaner(
                      Colors.white,
                      context,
                      Text(
                        "قيمة المنتج :290 ريال سعودي",
                        style: TextStyle(
                            fontFamily: "thin",
                            fontSize: 15,
                            color: Colors.grey),
                      )),
                  Utility.contaner(
                      Colors.grey[400],
                      context,
                      Text(
                        "اضافة طلب اخر",
                        style: TextStyle(
                            fontFamily: "thin",
                            fontSize: 15,
                            color: Colors.white),
                      )),
                  Utility.contaner(
                      Utility.c,
                      context,
                      Text(
                        "اكمال الطلب",
                        style: TextStyle(
                            fontFamily: "thin",
                            fontSize: 15,
                            color: Colors.white),
                      )),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
