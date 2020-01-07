import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/all_productsPage.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/product_details.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/shopping_cart.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/movie_card.dart';

class NewMain extends StatefulWidget {
  @override
  _NewMainState createState() => _NewMainState();
}

class _NewMainState extends State<NewMain> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // TODO: implement initState
    super.initState();
  }

  int _time = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh,size: 32,),
              onPressed: () => setState((){}),
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.shoppingCart),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ShoppingCartCheck())),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              title: 'الرئيسية',
              fontSize: 22,
              textColor: Colors.white,
              height: 0.8,
            ),
          )
        ],
      ),
      body: Container(
        // model: baseModel,
        child: ScopedModelDescendant<BaseModel>(
            rebuildOnChange: false,
            builder: (context, child, model) {
              return FutureBuilder<AllProductsModel>(
                  future: model.getAllProductData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: Loading(
                          color: ColorsD.redDefault,
                          indicator: BallPulseIndicator(),
                        ),
                      );
                    if (snapshot.hasError)
                      return GestureDetector(
                        onTap: () => setState(() {}),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.refresh,
                                size: 60,
                                color: Colors.grey,
                              ),
                              TextD(
                                title: 'فشل الإتصال',
                              ),
                              // TextD(
                              //   title: 'Tap to refresh',
                              // )
                            ],
                          ),
                        ),
                      );
                    {
                      print('object --- ${snapshot.data.data.cut}');
                      baseModel.services = snapshot.data.data.services;
                      baseModel.cuts = snapshot.data.data.cut;
                      baseModel.packaging = snapshot.data.data.packaging;
                      return Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          //   child: Material(
                          //     elevation: 20,
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width,
                          //       color: Colors.white,
                          //       height: 50,
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: <Widget>[
                          //           Padding(
                          //             padding: const EdgeInsets.only(left: 0.0),
                          //             child: IconButton(
                          //               onPressed: () => setState(() {}),
                          //               icon: Icon(Icons.refresh),
                          //               color: ColorsD.redDefault,
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.only(left: 8.0),
                          //             child: Align(
                          //               child: TextD(
                          //                 fontSize: 16,
                          //                 title: 'الخدمات المتاحة',
                          //                 textColor: ColorsD.redDefault,
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(right: 8.0),
                          //             child: Icon(
                          //               Icons.ac_unit,
                          //               color: Colors.transparent,
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 12,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: snapshot.data.data.cut.length == 0
                                ? Center(
                                    child: TextD(
                                    title: 'لا توجد بيانات',
                                  ))
                                : Container(
                                    height: MediaQuery.of(context).size.height/5.25,
                                    width: MediaQuery.of(context).size.width,
                                    child: CarouselSlider(
                                        // aspectRatio: 2.5,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        // autoPlayInterval: Duration(milliseconds: 600),
                                        // autoPlayAnimationDuration: Duration(seconds: 1),
                                        items: List.generate(
                                            snapshot.data.data.cut.length,
                                            (index) {
                                          return Stack(
                                            children: <Widget>[
                                              Align(
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      '${Apis.imageUrl}${snapshot.data.data.cut[index].image}',
                                                      fit: BoxFit.cover,
                                                      width: 400,
                                                    )),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 45,
                                                    color: Colors.white24,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Icon(Icons
                                                            .arrow_back_ios),
                                                        TextD(
                                                          title:
                                                              '${snapshot.data.data.cut[index].name}',
                                                          textColor:
                                                              Colors.black87,
                                                        ),
                                                        Icon(Icons
                                                            .arrow_forward_ios)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        })),
                                  ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          // snapshot.data.data.cut.length ==0? Center(child: TextD(title: 'لا توجد بيانات',),):
                          CarouselSlider(
                            items: List.generate(snapshot.data.data.ads.length,
                                (index) {
                              return Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width * 10,
                                  color: ColorsD.redDefault,
                                  child: TextD(
                                    title: snapshot.data.data.ads[index].ad
                                        .toString(),
                                    textColor: Colors.white,
                                    fontSize: 16,
                                  ));
                            }),
                            height: 50,
                            viewportFraction: 1.2,
                            autoPlay: true,
                            reverse: true,
                            scrollPhysics: NeverScrollableScrollPhysics(),
                            autoPlayInterval: Duration(seconds: 4),

                            autoPlayAnimationDuration: Duration(seconds: 5),
                            autoPlayCurve: Curves.linear,
                            // enlargeCenterPage: true,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: GridView.count(
                              
                              // childAspectRatio: 1.4,
                              // childAspectRatio:0.97,
                              childAspectRatio: (MediaQuery.of(context).size.width/2.66)/(MediaQuery.of(context).size.height/5.3) ,
                              crossAxisSpacing: 10,
                              padding: EdgeInsets.all(8),
                              mainAxisSpacing: 10,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              children: List.generate(
                                  snapshot.data.data.services.length, (index) {
                                final newService =
                                    snapshot.data.data.services[index];
                                // final String service =
                                //     snapshot.data.data.services.singleWhere((serv) {
                                //   return serv.id == product.serviceId;
                                // }).name;
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductsPage(
                                              newService.products,
                                              newService.name))),
                                  child: MovieCard(
                                    cardTag: 'product$index',
                                    img:
                                        'http://alzabhalhalal.com/public/img/${newService.path}',
                                    title: '${newService.name}',
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      );
                    }
                  });
            }),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
