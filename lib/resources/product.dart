import 'dart:convert';
import 'dart:io' as prefix0;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:zabh_halal/model/allProducts_model.dart';
import 'package:zabh_halal/model/cart_mode.dart';
import 'package:zabh_halal/model/cities_model.dart';
import 'package:zabh_halal/model/order_model.dart';
import 'package:zabh_halal/model/payment_model.dart';
import 'package:zabh_halal/utilities/apis.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

import 'base_scoped_model.dart';

mixin ProductModel on Model {
  startLoading() {
    BaseModel.isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    BaseModel.isLoading = false;
    notifyListeners();
  }

  Future<CartModel> getCart(
    BuildContext context,
  ) async {
    final response = await Apis.getRequest(context, '${Apis.baseUrl}cart', token: baseModel.userData==null?'':baseModel.userData.data.apiToken);
    if (response != null)
      return CartModel.fromJson(response);
    else
      throw Error();
  }

  Future<AllProductsModel> getAllProductData(
    BuildContext context,
  ) async {
    final response =
        await Apis.getRequest(context, '${Apis.baseUrl}order/data');
    if (response != null)
      return AllProductsModel.fromJson(response);
    else
      throw Error();
  }

  Future<CitiesModel> getAllCities(BuildContext context) async {
    final response = await Apis.getRequest(context, '${Apis.baseUrl}cities');
    if (response != null)
      return CitiesModel.fromJson(response);
    else
      throw Error();
  }

  Future<OrderModel> makeOrder(
      BuildContext context, Map<String, String> body) async {
    // final request = MultipartRequest('POST', Uri.parse('${Apis.baseUrl}orders'));
    // request.fields.addAll(body);
    // final res = await request.send();
    // print(res.statusCode);
    // return;
    // print(body);
    startLoading();
    final response =
        await Apis.postRequest(context, '${Apis.baseUrl}orders', baseModel.userData==null? '': baseModel.userData.data.apiToken, body);
    stopLoading();
    if (response != null) return OrderModel.fromJson(response);
    else
    throw Error();
  }
// /Hy9xQg9T5OCOkW1ecFYm4MlWNWoGrfAc3osbj2gP2JO5WX7SfwQHeireLQex
  Future confirmPayment(BuildContext context, String name, String phone,
      String orderID, prefix0.File image) async {
    startLoading();
    final request =
        MultipartRequest('POST', Uri.parse('${Apis.baseUrl}payments'));
    request.headers['Authorization'] =
        'Bearer ${baseModel.userData==null?'':baseModel.userData.data.apiToken} ';
    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['order_id'] = orderID;
    request.files.add(await MultipartFile.fromPath('image', '${image.path}'));
    print(image.path);
    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      stopLoading();
      return response.stream.first
          .asStream()
          .transform(utf8.decoder)
          .listen((res) {
        var data = json.decode(res);
        print(data);
        if (data['msg'] == 'success') {
          return PaymentModel.fromJson(data);
        } else
          AlertDialogs.failed(context, content: data['msg']);
      });
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
  }
}
