import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/model/cart_mode.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/new_mainPage.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/request_order.dart';
import 'package:zabh_halal/ui/tabs_page.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

class ShoppingCartCheck extends StatefulWidget {
  @override
  _ShoppingCartStateCheck createState() => _ShoppingCartStateCheck();
}

int total = 0;

class _ShoppingCartStateCheck extends State<ShoppingCartCheck> {
  int subTotal;
  int grandTotal;
  List newAllProducts;

  @override
  void initState() {
    // TODO: implement initState
    // print('-----${baseModel.allProducts[0]['packagingX']}--------');
    grandTotal = 0;
    baseModel.allProducts.forEach((product) {
      final int subPrice = int.parse(product['price']) *
          (product['qty'] == 0 ? product['amount'] : product['qty']);

      grandTotal += subPrice;
    });
    // baseModel.allProducts.forEach((prod){
    //   baseModel.allProducts.forEach((product){
    //     if(prod['product_id'] == product['product_id']){
    //       baseModel.allProducts[baseModel.allProducts.indexOf(prod)]['qty']++;
    //       baseModel.allProducts.removeAt(baseModel.allProducts.indexOf(product));
    //     }
    //   });
    //   bool shouldIncrement = false;
    //   newAllProducts
    // for (var i = 0; i < baseModel.allProducts.length; i++) {
    //   for (var j = 0; j < baseModel.allProducts.length; j++) {
    //     if(baseModel.allProducts[i]['product_id'] == baseModel.allProducts[j]['product_id'])
    //     {
    //       shouldIncrement = false;
    //       baseModel.allProducts[i]['qty'] = (int.tryParse(baseModel.allProducts[i])).toString();
    //     }
    //   }
      
    // }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: TextD(
              title: 'عربة التسوق',
              fontSize: 22,
              textColor: Colors.white,
              height: 0.8,
            ),
          )
        ],
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                SharedPreferences.getInstance().then((pref) {
                  baseModel.allProducts = [];
                  pref.setString('products', json.encode([]));
                });
                if (mounted) setState(() {});
              },
              child: TextD(
                title: "تفريغ العربة",
                textColor: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => TabsPage()),
                    (Route route) => false);
              },
              child: TextD(
                title: "إضافة منتج",
                textColor: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: baseModel.allProducts.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: TextD(
                    title: 'العربة فارغة',
                    fontSize: 18,
                  ),
                ),
                ClippedButton(
                  onTapCallback: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TabsPage()),
                        (Route route) => false);
                  },
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextD(
                    title: 'الرجوع للصفحة الرئيسية',
                    textColor: Colors.white,
                    fontSize: 16,
                  ),
                  color: ColorsD.redDefault,
                )
              ],
            )
          : ScopedModelDescendant<BaseModel>(builder: (context, child, model) {
              return Builder(
                  // future: model.getCart(context),
                  builder: (context) {
                return Align(
                  child: ListView(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    shrinkWrap: true,
                    children: _buildItems()
                      ..addAll([
                        ClippedButton(
                          child: TextD(
                            title: 'المجموع: $grandTotal ريال سعودى',
                            textColor: ColorsD.redDefault,
                            fontSize: 16,
                          ),
                        ),
                        ClippedButton(
                          onTapCallback: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    RequestOrder(notes: ' ')));
                          },
                          color: ColorsD.redDefault,
                          child: TextD(
                            title: 'إستكمال الطلب',
                            textColor: Colors.white,
                            height: 0.8,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                  ),
                );
              });
            }),
    );
  }

  List<Widget> _buildItems() {
    return List.generate(
      baseModel.allProducts.length,
      (index) {
        subTotal = int.parse(baseModel.allProducts[index]['price']) *
            (baseModel.allProducts[index]['qty'] == 0
                ? baseModel.allProducts[index]['amount']
                : baseModel.allProducts[index]['qty']);
        return Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height / ,
              // width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: ColorsD.redDefault,

                ),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'http://www.alzabhalhalal.com/public/dash/assets/img/${baseModel.allProducts[index]['image']}',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title: baseModel.allProducts[index]['name'],
                      fontSize: 16,
                      height: 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title:
                          'التجهيز: ${baseModel.packaging.singleWhere((pack) => pack.id == baseModel.allProducts[index]['packaging']).name}',
                      fontSize: 16,
                      height: 0.8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title:
                          'التقطيع: ${baseModel.cuts.singleWhere((pack) => pack.id == baseModel.allProducts[index]['Shredder']).name}',
                      fontSize: 16,
                      height: 0.8,
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title:
                          'السعر: ${baseModel.allProducts[index]['price']} ريال سعودى',
                      textColor: Colors.redAccent,
                      fontSize: 18,
                      height: 0.8,
                      fontFamily: 'black',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title: baseModel.allProducts[index]['qty'] == 0
                          ? 'الكمية: ${baseModel.allProducts[index]['amount']} كيلو'
                          : 'الكمية: ${baseModel.allProducts[index]['qty']} ',
                      textColor: Colors.redAccent,
                      fontSize: 18,
                      height: 0.8,
                      fontFamily: 'black',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextD(
                      title: 'السعر الكلى $subTotal ريال سعودى',
                      textColor: Colors.redAccent,
                      fontSize: 18,
                      height: 0.8,
                      fontFamily: 'black',
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                color: ColorsD.redDefault,
                onPressed: () {
                  SharedPreferences.getInstance().then((pref) {
                    baseModel.allProducts.removeAt(index);
                    pref.setString(
                        'products', json.encode(baseModel.allProducts));
                    setState(() {});
                  });
                },
                icon: Icon(Icons.delete_forever),
              ),
            )
          ],
        );
      },
    );
  }
}
