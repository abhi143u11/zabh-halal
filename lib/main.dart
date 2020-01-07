import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'ui/splash.dart';
import 'package:zabh_halal/utillities.dart';

// GetIt locator = GetIt.asNewInstance();
void main() async {
  baseModel = BaseModel();
  // SharedPreferences.getInstance().then((p){
  //   p.clear();
  // });
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

setLocator() {
  GetIt.I.registerLazySingleton(() => BaseModel());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<BaseModel>(
      model: baseModel,
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[200],
            appBarTheme: AppBarTheme(
              color: Utility.c,
            ),
            primarySwatch: Colors.red,
          ),
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: Splash());
            }
          )),
    );
  }
}
