import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';

class Apis {
  static String baseUrl = "http://www.alzabhalhalal.com/api/";
  static String baseUrl1 = "http://www.dab7halal.waslney.com/api/";
  static String imageUrl = "http://www.alzabhalhalal.com";
  static String imageUrl1 = "http://www.dab7halal.waslney.com";

  static Future getRequest(BuildContext context, url,
      {String token =
          ''}) async {
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer ${baseModel.userData == null? '': baseModel.userData.data.apiToken}'});
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else
        {
          if(responseData['msg'].toString().contains('unauth'))
          AlertDialogs.failed(context, content: 'يرجى تسجيل الدخول أولا').then((_){
            AlertDialogs.login(context).then((_){
              // getRequest(context, url);
            });
          });
          else
          AlertDialogs.failed(context,
            content: responseData['msg'] ??
                responseData['message'] ??
                'تعذر الإتصال');}
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
  }

  static Future postRequest(
      BuildContext context, url, String token,Map  body) async {
        print("LLL"+json.encode(body));
        // token =
        //   'Hy9xQg9T5OCOkW1ecFYm4MlWNWoGrfAc3osbj2gP2JO5WX7SfwQHeireLQex';
    final response = await http.post(
      url,
      body: (body)
      ,
      headers: {"Authorization": "Bearer $token"},
    );
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['msg'].toString().toLowerCase() == 'success')
        return responseData;
      else
        {
          if(responseData['msg'].toString().contains('unauth'))
          AlertDialogs.failed(context, content: 'يرجى تسجيل الدخول أولا').then((_){
            AlertDialogs.login(context);
          });
          else
          AlertDialogs.failed(context,
            content: responseData['msg'] ??
                responseData['message'] ??
                'تعذر الإتصال');}
    } else
      AlertDialogs.failed(context, content: 'تعذر الإتصال');
  }
}
