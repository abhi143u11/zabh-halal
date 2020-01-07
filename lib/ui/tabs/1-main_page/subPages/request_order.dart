import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/cities_model.dart';
import 'package:zabh_halal/model/order_model.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/confirm_payment.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/done_payment.dart';
import 'package:zabh_halal/ui/tabs/1-main_page/subPages/shopping_cart.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/utillities.dart';

class RequestOrder extends StatefulWidget {
  List order;
  final String notes;
  RequestOrder({Key key, this.order, this.notes}) : super(key: key);
  @override
  _RequestOrderState createState() => _RequestOrderState();
}

class _RequestOrderState extends State<RequestOrder> {
  bool isCOD = false;
  String cityName;
  // List<String> cities = ['Egypt', 'Morocco', 'Sudanese', 'Sweden'];
  CitiesModel citiesModel;

  GlobalKey<FormState> _orderForm = GlobalKey<FormState>();
  @override
  void initState() {
    widget.order = baseModel.allProducts;
    if (baseModel.isAuth) {
      phoneCtrler.text = baseModel.userData.data.phone.substring(3);
      setState(() {});
    } else
      print(widget.order);
    baseModel.getAllCities(context).then((resCities) {
      citiesModel = resCities;
      setState(() {});
      // print(widget.order.length);
    });
    // TODO: implement initState
    super.initState();
  }

  TextEditingController nameCtrler = TextEditingController();
  TextEditingController phoneCtrler = TextEditingController();
  TextEditingController districtCtrler = TextEditingController();

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
      body: Container(
        // model: baseModel,
        child:
            ScopedModelDescendant<BaseModel>(builder: (context, child, model) {
          return LoadablePage(
            isLoading: BaseModel.isLoading,
            children: <Widget>[
              Form(
                autovalidate: true,
                key: _orderForm,
                child: Column(
                  children: <Widget>[
                    ClippedButton(
                      color: Colors.white,
                      child: Align(
                        child: TextD(
                          title: 'أدخل بياناتك',
                          textColor: ColorsD.redDefault,
                          fontSize: 22,
                          height: 0.8,
                        ),
                      ),
                    ),
                    ClippedButton(
                      child: _defultTextField('الإسم', nameCtrler),
                      color: Colors.white,
                    ),
                    Utility.contaner(
                        Colors.white,
                        context,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset('assets/icons/SA.png',height: 30,),
                                SizedBox(width: 5,),
                                TextD(
                                  title: '966+',
                                  textColor: Colors.black,
                                  fontSize: 16,
                                  height: 0.8,
                                ),
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: TextField(
                                  controller: phoneCtrler,
                                  textAlign: TextAlign.end,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10)
                                    
                                  ],
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(
                                      height: 0.6,
                                      fontFamily: 'thin',
                                      color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'رقم الجوال',
                                    hintStyle: TextStyle(
                                      // height: 0.9,
                                      fontFamily: 'thin',
                                    ),
                                  ),
                                ))
                          ],
                        )),
                    Utility.contaner(Colors.white, context,
                        _defultTextField('الحى', districtCtrler)),
                    Utility.contaner(
                      Colors.white,
                      context,
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: citiesModel == null
                            ? Center(
                                child: Loading(
                                color: ColorsD.redDefault,
                                indicator: BallPulseIndicator(),
                              ))
                            : DropdownButton(
                                hint: TextD(
                                  title: 'اختر مدينة',
                                  textColor: Colors.black,
                                  fontSize: 16,
                                ),
                                value: cityName,
                                onChanged: (s) {
                                  setState(() {
                                    cityName = s;
                                  });
                                },
                                items: List.generate(
                                    citiesModel.data.cities.length, (index) {
                                  return DropdownMenuItem(
                                    child: Text(
                                        citiesModel.data.cities[index].name),
                                    value: citiesModel.data.cities[index].name,
                                  );
                                }),
                                isExpanded: true,
                                underline: Container(),
                              ),
                      ),
                    ),
                    ClippedButton(
                      onTapCallback: () {},
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Switch(
                            value: isCOD,
                            onChanged: (b) {
                              isCOD = b;
                              setState(() {});
                            },
                          ),
                          TextD(
                            title: 'الدفع عند الإستلام',
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    ClippedButton(
                      color: ColorsD.redDefault,
                      onTapCallback: BaseModel.isLoading? null: () async {
                        // _sendOrder();
                        if (phoneCtrler.text.length < 9) {
                          AlertDialogs.failed(context,
                              content: "من فضلك ادخل رقم صحيح");
                          return;
                        }
                        if (baseModel.isAuth) {
                          order['user_id'] =
                              baseModel.userData.data.id.toString();
                          _sendOrder();
                        } else
                          model.login(context, '966${phoneCtrler.text}').then((_) {
                            order['user_id'] =
                                baseModel.userData.data.id.toString();
                            _sendOrder();
                          });
                      },
                      child: TextD(
                        title: 'إرسال طلب',
                        textColor: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Map<String, String> order = {};
  Future _sendOrder() async {
    if (nameCtrler.text == null ||
        districtCtrler.text == null ||
        phoneCtrler.text == null ||
        cityName == null || 
        nameCtrler.text.isEmpty ||
        districtCtrler.text.isEmpty || 
        cityName.isEmpty
        
        )
      AlertDialogs.failed(context, content: 'من فضلك أكمل البيانات');
    else {
      order['products'] = json.encode({"products": (baseModel.allProducts)});
      order['phone'] = '966${phoneCtrler.text}';
      order['name'] = nameCtrler.text;
      order['city_id'] = citiesModel.data.cities
          .singleWhere((city) => city.name == cityName)
          .id
          .toString();
      order['user_id'] = order['user_id'] ?? '143';
      order['region'] = districtCtrler.text;
      print(json.encode(order).toString());
      baseModel.makeOrder(context, order).then((returnedModel) {
        OrderModel orderModel = returnedModel;
        if (isCOD)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DonePayment(
                  orderID: orderModel.data.orders.first.id.toString())));
        else
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmPayment(
                        id: orderModel.data.orders.first.id.toString(),
                        name: nameCtrler.text,
                        phon: '${phoneCtrler.text}',
                      )));
      });
    }
  }

  TextFormField _defultTextField(
      String hint, TextEditingController textEditingController) {
    bool valid = true;
    return TextFormField(
      validator: (name) {
        valid = (name == null || name.isEmpty);
      },
      // textDirection: TextDirection.rtl,
      controller: textEditingController,
      textAlign: TextAlign.end,
      style: TextStyle(height: 0.6, fontFamily: 'thin', color: Colors.black),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          // height: 0.9,
          fontFamily: 'thin',
        ),
      ),
    );
  }
}
