import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/cart_mode.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

class ShoppingCart extends StatefulWidget {
  final String id;

  const ShoppingCart({Key key, this.id}) : super(key: key);
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

int total = 0;

class _ShoppingCartState extends State<ShoppingCart> {
  Future<CartModel> _future;
  @override
  void initState() {
    // TODO: implement initState
    _future = baseModel.getCart(context);
    if (widget.id != null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _future = baseModel.getCart(context);
    // print(baseModel.userData.data.apiToken);
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
        // title: Row(
        //   children: <Widget>[
        //     TextD(
        //       title: "تفريغ العربة",
        //       textColor: Colors.white,
        //       fontSize: 14,
        //     ),
        //     SizedBox(
        //       width: 25,
        //     ),
        //     TextD(
        //       title: "إضافة منتج",
        //       textColor: Colors.white,
        //       fontSize: 14,
        //     ),
        //   ],
        // ),
      ),
      body: ScopedModelDescendant<BaseModel>(builder: (context, child, model) {
        return FutureBuilder<CartModel>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: Loading(indicator: BallPulseIndicator(),color: ColorsD.redDefault,),
                );
              if (snapshot.hasError || snapshot.data == null)
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _future = baseModel.getCart(context);
                    });
                  },
                                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.refresh, color: Colors.grey, size: 55,),
                        TextD(
                          title: 'العربة فارغة',
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                );
              total = 0;
              snapshot.data.data.orders.forEach((order) {
                total += order.totalPrice;
              });
              List<Orders> selectedByCode;
              selectedByCode = List.from(snapshot.data.data.orders);
              if (widget.id.isNotEmpty && snapshot.data.data.orders.firstWhere((order)=>order.id.toString() == widget.id, orElse: ()=>null) != null) {
               print('${widget.id}');
                selectedByCode = snapshot.data.data.orders
                    .where(
                      (order) => order.id.toString() == widget.id,
                    )
                    .toList();
                total = 0;
                selectedByCode.forEach((order) {
                  total += order.totalPrice;
                });
              }

              return Align(
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shrinkWrap: true,
                  children: _buildItems(selectedByCode.isEmpty
                      ? snapshot.data.data.orders
                      : selectedByCode)
                    ..addAll([
                      ClippedButton(
                        child: TextD(
                          title: 'المجموع: $total ريال سعودى',
                          textColor: ColorsD.redDefault,
                          fontSize: 16,
                        ),
                      ),
                      // ClippedButton(
                      //   onTapCallback: () {},
                      //   color: ColorsD.redDefault,
                      //   child: TextD(
                      //     title: 'إعادة الطلب',
                      //     textColor: Colors.white,
                      //     height: 0.8,
                      //     fontSize: 16,
                      //   ),
                      // ),
                    ]),
                ),
              );
            });
      }),
    );
  }

  List<Widget> _buildItems(List<Orders> snapshot) {
    print('ssss ${snapshot.length}');
    return List.generate(
      snapshot.length,
      (index) {
        return Container(
          // height: MediaQuery.of(context).size.height / ,
          width: MediaQuery.of(context).size.width * 0.4,
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: ColorsD.redDefault
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
                  'http://www.alzabhalhalal.com/public/dash/assets/img/${snapshot[index].product.image}',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title: snapshot[index].product.name,
                  fontSize: 16,
                  height: 0.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title: 'رقم الطلب: ${snapshot[index].id}',
                  fontSize: 16,
                  height: 0.8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title:
                      'الخدمة: ${baseModel.services.singleWhere((serv) => serv.id == snapshot[index].product.serviceId).name}',
                  fontSize: 16,
                  height: 0.8,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title: 'السعر: ${snapshot[index].product.price} ريال سعودى',
                  textColor: Colors.redAccent,
                  fontSize: 18,
                  height: 0.8,
                  fontFamily: 'black',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title: 'الكمية: ${(snapshot[index].amount).toString()}',
                  textColor: Colors.redAccent,
                  fontSize: 18,
                  height: 0.8,
                  fontFamily: 'black',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextD(
                  title: 'السعر الكلى ${snapshot[index].totalPrice} ريال سعودى',
                  textColor: Colors.redAccent,
                  fontSize: 18,
                  height: 0.8,
                  fontFamily: 'black',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
