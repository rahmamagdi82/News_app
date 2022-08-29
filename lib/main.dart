
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cach_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'layout/news_layout.dart';
import 'shared/cubit/cubit_observe.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isWindows){
  //   DesktopWindow.setMinWindowSize(
  //       Size(360.0, 650.0)
  //   );
  // }
  DioHelper.initial();
  await CachHelper.initial();
bool? darkMode=CachHelper.getData(key: 'darkMode');
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(darkMode));
    },
    blocObserver: MyBlocObserver(
    ),
  );
}

class MyApp extends StatelessWidget {
  bool? darkMode;
  MyApp(this.darkMode);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (
        BuildContext context) =>NewsApp()..getBusiness()..changeMode(fromShared: darkMode),
      child: BlocConsumer<NewsApp,NewsAppStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            home: HomeNews(),
            debugShowCheckedModeBanner:false,
            theme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              primarySwatch: Colors.purple,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.purpleAccent[100],
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                elevation: 25.0,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                  size: 30.0,
                ),
                backgroundColor: Colors.white,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            darkTheme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              primarySwatch: Colors.purple,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.purpleAccent[100],
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                elevation: 25.0,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme:  AppBarTheme(
                titleSpacing: 20.0,
                titleTextStyle: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 30.0,
                ),
                backgroundColor: HexColor('333739'),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            themeMode:NewsApp.get(context).darkMode? ThemeMode.dark:ThemeMode.light,
          );
        },
        listener: (BuildContext context, Object? state) {  },
      ),

    );
  }

}

