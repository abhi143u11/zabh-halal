import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/colors.dart';
// import 'package:diamond_fab/diamond_fab.dart';
import 'package:zabh_halal/ui/tabs/4-ourway/accounts_page.dart';
import 'package:zabh_halal/ui/tabs/5-more/more.dart';
import 'package:zabh_halal/ui/tabs/3-my_order/my_orders_page.dart';
import 'package:zabh_halal/ui/tabs/2-how_shop/how_shop_page.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/new_mainPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  int current_idex = 3;

  final _options = [
    MoreInfo(),
    AccountsPage(),
    Scaffold(
      body: Container(),
    ),
    NewMain(),
    MyOrdersPage(),
    HowShopPage(),
  ];

  AnimationController _animationController1;

  /// Rotation [Animation] that'll be passed to [RotationTransition]
  Animation<double> _rotateAnimation1;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Timer(
    //     Duration(seconds: 3),
    //     () => SystemChrome.setPreferredOrientations(
    //         [DeviceOrientation.portraitUp]));

    /// Initializing our AnimationController
    /// Longer duration means slower rotations and vice versa.
    _animationController1 =
        AnimationController(vsync: this, duration: Duration(seconds: 15));

    /// Initializing our rotate animation
    /// We use [Curves.linear] so that our animation plays out evenly.
    _rotateAnimation1 =
        CurvedAnimation(parent: _animationController1, curve: Curves.linear);

    /// Telling our animation to repeat indefinitely.
    _animationController1.repeat();
    // _animationController1.forward();
    // _animationController1.addListener(()=>setState((){
    //   print('sss');
    // }));
    pageController.addListener(() {
      if (pageController.page == 3.0) {
        print('this is 3');
        _height = 80;
      } else {
        _height = 55;
      }
    });
  }

  PageController pageController = PageController(initialPage: 3);
  @override
  Widget build(BuildContext context) {
// print(baseModel.userData.data.apiToken);
    return Stack(
      children: <Widget>[
        Scaffold(
            body: PageView(
              children: _options,
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
            ),
            floatingActionButton: Container(
              width: 100,
              height: 100,
              // color: Colors.blue,
            ),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: new Theme(
              data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                  canvasColor: Colors.grey[400]
                  // sets the active color of the `BottomNavigationBar` if `Brightness` is light

                  ),
              child: Builder(builder: (context) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: Container(
                    // height: 135,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(blurRadius: 4, color: Colors.grey)
                          ]),
                          height: 80,
                          child: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            currentIndex: current_idex,
                            // fixedColor: Colors.grey,
                            onTap: (index) {
                              pageController.jumpToPage(
                                index,
                              );

                              setState(() {
                                current_idex = index;
                                print(index);
                                print(current_idex);
                                print(pageController.page);
                              });
                            },
                            showUnselectedLabels: true,

                            selectedItemColor: ColorsD.redDefault,
                            selectedLabelStyle: TextStyle(
                                color: ColorsD.redDefault, fontFamily: 'thin'),
                            unselectedLabelStyle: TextStyle(
                                color: ColorsD.redDefault, fontFamily: 'thin'),
                            backgroundColor: Colors.grey[200],
                            items: [
                              BottomNavigationBarItem(
                                title: Text("المزيد"),
                                icon: Image.asset(
                                  'assets/icons/more_gray.png',
                                  height: 20,
                                ),
                                activeIcon: Image.asset(
                                  'assets/icons/more.png',
                                  height: 25,
                                ),
                              ),
                              BottomNavigationBarItem(
                                title: Text("  طريقنا"),
                                icon: Image.asset('assets/icons/map.png',
                                    height: 20),
                                activeIcon: Image.asset(
                                    'assets/icons/location.png',
                                    height: 25),
                              ),
                              BottomNavigationBarItem(
                                  title: Text(""), icon: Container()),
                              BottomNavigationBarItem(
                                  title: Text(""), icon: Container()
                                  // icon: Image.asset(
                                  //   "",
                                  // )
                                  ),
                              BottomNavigationBarItem(
                                title: Text("طلباتى"),
                                icon: Image.asset('assets/icons/car_gray.png',
                                    height: 20),
                                activeIcon: Image.asset('assets/icons/car.png',
                                    height: 25),
                              ),
                              BottomNavigationBarItem(
                                  title: Text(
                                    "كيف تتسوق",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  icon: Image.asset(
                                    'assets/icons/text.png',
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                  activeIcon: Image.asset(
                                    'assets/icons/text.png',
                                    color: ColorsD.redDefault,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )),
        Positioned(
            bottom: 25,
            right: MediaQuery.of(context).size.width / 2 + -35,
            child: GestureDetector(
              onTap: () {
                pageController.jumpToPage(
                  3,
                );

                current_idex = 3;
                setState(() {});
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.bounceOut,
                  height: _height,
                  child: Image.asset(
                    'assets/icons/logo.png',
                    fit: BoxFit.contain,
                    height: 50,
                    width: 70,
                  )),
            ))
      ],
    );
  }

  double _height = 80;
}
