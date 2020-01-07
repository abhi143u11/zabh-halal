import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/model/cart_mode.dart';
import 'package:zabh_halal/model/product.dart' as prefix0;
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/request_order.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/shopping_cart.dart';
import 'package:zabh_halal/ui/tabs_page.dart';
import 'package:zabh_halal/utilities/colors.dart';

class ProductDetails extends StatefulWidget {
  final String tag;
  final Products productData;
  String service;
  List<Cut> cuts;
  List<Packaging> packaging;
  ProductDetails(this.tag, this.productData,
      {this.service, this.cuts, this.packaging});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  dynamic cutWidget;
  TabController garbageCtrl;
  // CartModel cart;
  @override
  void initState() {
    // mooodeeeel = ScopedModel.of(context);
    widget.cuts = baseModel.cuts;
    widget.packaging = baseModel.packaging;

    garbageCtrl = TabController(length: 2, initialIndex: 1, vsync: this);
    // baseModel.getCart(context).then((returnedCart) {
    //   cart = returnedCart;
    // });
    // TODO: implement initState
    super.initState();
  }

  TextEditingController notesCtrler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // baseModel.allProducts.removeLast();
    // print(baseModel.userData.data.apiToken);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                textColor: Colors.white,
                title: "الشراء",
                fontSize: 18,
              ),
            )
          ],
        ),
        body: Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: Container(
              child: ScopedModelDescendant<BaseModel>(
                builder: (context, child, model) {
                  return ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Material(
                          elevation: 20,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            height: 50,
                            child: Align(
                              child: TextD(
                                fontSize: 16,
                                title: '${widget.productData.name}',
                                textColor: ColorsD.redDefault,
                              ),
                            ),
                          ),
                        ),
                      ),

                      ///========================== Product Image ==============================//
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetAnimationDuration: Duration(seconds: 1),
                              elevation: 0.0,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                // tag: widget.tag,
                                height: MediaQuery.of(context).size.height / 2,
                                child: PhotoView(
                                  backgroundDecoration:
                                      BoxDecoration(color: Colors.transparent),
                                  customSize: Size.fromHeight(
                                      MediaQuery.of(context).size.height / 2),
                                  heroAttributes: PhotoViewHeroAttributes(
                                    tag: widget.tag,
                                  ),
                                  imageProvider: NetworkImage(
                                      'http://alzabhalhalal.com/public/dash/assets/img/${widget.productData.image}'),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Hero(
                            tag: widget.tag,
                            child: Image.network(
                              'http://alzabhalhalal.com/public/dash/assets/img/${widget.productData.image}',
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            )),
                      ),

                      ///============================= Share Button ============================//
                      GestureDetector(
                        onTap: () {
                          if (Platform.isIOS)
                            Share.share(
                                'http://itunes.apple.com/app/id1492194576');
                          else
                            Share.share(
                              'https://play.google.com/store/apps/details?id=com.skinnyg.zabh_halal',
                            );
                        },
                        child: customContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  TextD(
                                    title: 'ارسال لصديق',
                                    fontSize: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        'assets/icons/whatsapp.png'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      /// =========================== Price ==========================//
                      customContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextD(
                                title:
                                    ' ${int.tryParse(widget.productData.price.toString()) * (counter)} ريال سعودى',
                                fontSize: 16,
                                textColor: ColorsD.redDefault,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4.5,
                              ),
                              TextD(title: 'السعر', fontSize: 16),
                            ],
                          ),
                        ),
                      ),

                      /// ====================================== Size ======================//
                      customContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(),
                              TextD(
                                title: '${widget.service}',
                                fontSize: 16,
                                textColor: ColorsD.redDefault,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4.5,
                              ),
                              TextD(title: 'الخدمة', fontSize: 16),
                            ],
                          ),
                        ),
                      ),
                      _buildPackaging(),
                      _buildCut(),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 16.0, right: 16),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: <Widget>[
                      //       Expanded(
                      //         child: TabBar(
                      //           controller: garbageCtrl,
                      //           unselectedLabelColor: ColorsD.redDefault,
                      //           unselectedLabelStyle: TextStyle(
                      //             fontFamily: 'thin',
                      //             color: ColorsD.redDefault,
                      //           ),
                      //           labelStyle: TextStyle(
                      //             fontFamily: 'thin',
                      //             color: ColorsD.redDefault,
                      //           ),
                      //           indicator: BoxDecoration(
                      //               boxShadow: [
                      //                 BoxShadow(blurRadius: 4, color: Colors.grey)
                      //               ],
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: ColorsD.redDefault),
                      //           tabs: <Widget>[
                      //             Tab(
                      //               text: 'بالكيلو',
                      //             ),
                      //             Tab(
                      //               text: 'بالرأس',
                      //             ),
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      customContainer(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        if (counter != 1)
                                          setState(() {
                                            counter--;
                                          });
                                      },
                                      child: Image.asset(
                                          'assets/icons/negativ.png')),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TextD(
                                    textColor: ColorsD.redDefault,
                                    fontSize: 22,
                                    title: counter.toString(),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        counter++;
                                        setState(() {});
                                      },
                                      child:
                                          Image.asset('assets/icons/plus.png')),
                                ],
                              ),
                              TextD(
                                title: 'الكمية',
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      customContainer(
                          height: 150,
                          child: TextField(
                            controller: notesCtrler,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintText: 'ملاحظات',
                              hintStyle: TextStyle(fontFamily: 'thin'),
                              alignLabelWithHint: true,
                            ),
                          )),
                      customContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 100,
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'أدخل كود الخصم',
                                      hintStyle: TextStyle(
                                          fontFamily: 'thin', height: 0.5)),
                                  controller: code,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TextD(title: 'الخصم', fontSize: 16),
                            ],
                          ),
                        ),
                      ),
                      customContainer(
                        height: 55,
                        child: Container(
                          // margin: EdgeInsets.only(top: 20),
                          height: 55,
                          child: CheckboxListTile(
                            dense: false,
                            activeColor: ColorsD.redDefault,
                            onChanged: (b) {
                              setState(() {
                                shaloot = b;
                              });
                            },
                            value: shaloot,
                            isThreeLine: false,
                            title: TextD(
                              title: '(مجانا)',
                              textColor: ColorsD.redDefault,
                              height: 0.5,
                            ),
                            secondary: TextD(
                              title: "مع شلوطة",
                              height: 0.5,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ),
                      Align(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                final pref =
                                    await SharedPreferences.getInstance();
                                productInfo['name'] = widget.productData.name;
                                productInfo['price'] =
                                    widget.productData.price.toString();
                                productInfo['product_id'] =
                                    widget.productData.id.toString();
                                productInfo['power'] = shaloot ? '1' : '0';
                                productInfo['qty'] = counter;
                                productInfo['notes'] =
                                    '${notesCtrler.text ?? ' '}';

                                if (code.text == null || code.text.isEmpty)
                                  productInfo['code'] = '0';
                                else
                                  productInfo['code'] = code.text;
                                productInfo['Shredder'] = baseModel.cuts
                                    .singleWhere(
                                        (shred) =>
                                            shred.name ==
                                            productInfo['ShredderX'],
                                        orElse: () => baseModel.cuts.first)
                                    .id;
                                productInfo['packaging'] = baseModel.packaging
                                    .singleWhere(
                                        (shred) =>
                                            shred.name ==
                                            productInfo['packagingX'],
                                        orElse: () => baseModel.packaging.first)
                                    .id;
                                productInfo['image'] = widget.productData.image;
                                baseModel.allProducts.add((productInfo));
                                pref.setString('products',
                                    json.encode(baseModel.allProducts));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShoppingCartCheck())).then((_) {
                                  productInfo = {};
                                });
                                return;
                                if (!baseModel.isAuth)
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => RequestOrder(
                                              notes: notesCtrler.text ?? '')))
                                      .then((_) {
                                    productInfo = {};
                                  });
                                else
                                  print('not auth');
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: customContainer(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        TextD(
                                          title: "إتمام الشراء",
                                          textColor: ColorsD.redDefault,
                                          height: 1.2,
                                          fontSize: 16,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset('assets/icons/done.png'),
                                      ],
                                    ),
                                  )),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: GestureDetector(
                                  onTap: () async {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    productInfo['name'] =
                                        widget.productData.name;
                                    productInfo['price'] =
                                        widget.productData.price.toString();
                                    productInfo['product_id'] =
                                        widget.productData.id.toString();
                                    productInfo['power'] = shaloot ? '1' : '0';
                                    productInfo['qty'] = counter;
                                    productInfo['notes'] =
                                        '${notesCtrler.text ?? ' '}';

                                    if (code.text == null || code.text.isEmpty)
                                      productInfo['code'] = '0';
                                    else
                                      productInfo['code'] = code.text;
                                    productInfo['Shredder'] = baseModel.cuts
                                        .singleWhere(
                                            (shred) =>
                                                shred.name ==
                                                productInfo['ShredderX'],
                                            orElse: () => baseModel.cuts.first)
                                        .id;
                                    productInfo['packaging'] = baseModel
                                        .packaging
                                        .singleWhere(
                                            (shred) =>
                                                shred.name ==
                                                productInfo['packagingX'],
                                            orElse: () =>
                                                baseModel.packaging.first)
                                        .id;
                                    productInfo['image'] =
                                        widget.productData.image;
                                    baseModel.allProducts.add((productInfo));
                                    pref.setString('products',
                                        json.encode(baseModel.allProducts));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TabsPage())).then((_) {
                                      productInfo = {};
                                    });
                                  },
                                  child: customContainer(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          TextD(
                                            title: 'اضافة منتج أخر',
                                            textColor: Colors.white,
                                            height: 1.2,
                                            fontSize: 16,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/icons/plus.png',
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      color: ColorsD.redDefault),
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }));
  }

  bool addConds;
  int counter = 1;
  bool shaloot = false;
  Map<String, dynamic> productInfo = {};
  TextEditingController code = TextEditingController();
  // Widget _buildPackaging() {
  //   return _customDropDown(widget.cuts, 'التجهيز', 'ShredderX');
  // }

  // Widget _buildCut() {

  //   return _customDropDown(widget.packaging, 'التقطيع', 'packagingX');
  // }

  Widget _buildCut() {
    return customContainer(
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButton(
                  hint: Container(
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: TextD(
                      title: '${baseModel.cuts.first.name}',
                      textColor: ColorsD.redDefault,
                      fontSize: null,
                    ),
                  ),
                  value: productInfo['ShredderX'],
                  onChanged: (val) {
                    productInfo['ShredderX'] = val;
                    if (mounted) setState(() {});
                  },
                  underline: Container(),
                  items: List.generate(baseModel.cuts.length, (index) {
                    print(baseModel.cuts[index].name);
                    return DropdownMenuItem(
                        child: Center(
                          // textDirection: TextDirection.rtl,
                          child: TextD(
                            title: '${baseModel.cuts[index].name}',
                            textColor: ColorsD.redDefault,
                            fontSize: null,
                          ),
                        ),
                        value: baseModel.cuts[index].name);
                  }),
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width / 4.5,
              // ),
              TextD(title: 'التقطيع', fontSize: 16),
            ],
          )),
    );
  }

  Widget _buildPackaging() {
    return customContainer(
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                
                              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButton(
                    hint: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextD(
                        title: '${baseModel.packaging.first.name}',
                        textColor: ColorsD.redDefault,
                        fontSize: null,
                      ),
                    ),
                    value: productInfo['packagingX'],
                    onChanged: (val) {
                      productInfo['packagingX'] = val;
                      if (mounted) setState(() {});
                    },
                    underline: Container(),
                    items: List.generate(baseModel.packaging.length, (index) {
                      print(baseModel.packaging[index].name);
                      return DropdownMenuItem(
                          child: Center(
                            // textDirection: TextDirection.rtl,
                            child: TextD(
                              title: '${baseModel.packaging[index].name}',
                              textColor: ColorsD.redDefault,
                              fontSize: null,
                            ),
                          ),
                          value: baseModel.packaging[index].name);
                    }),
                  ),
                ),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width / 4.5,
              // ),
              Flexible(child: TextD(title: 'التجهيز', fontSize: 16)),
            ],
          )),
    );
  }

  Widget customContainer({Widget child, double height = 45, Color color}) {
    Color newColor = color == null ? Colors.white : color;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: height,
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
