import 'package:employee_master/provider/login_provider.dart';
import 'package:employee_master/provider/update_provider.dart';
import 'package:employee_master/routname/centralize_route.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'provider/dashboard_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(),
  );
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ListenableProvider<DashBoardProvider>(create: (_) => DashBoardProvider()),
          ListenableProvider<UpdateProvider>(create: (_) => UpdateProvider()),
          ListenableProvider<LoginProvider>(create: (_) => LoginProvider()),


        ],
    child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: () => MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: orangeTheme,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => CentralizeRoute.makeRoute(
            context: context,
            routeName: settings.name,
            arguments: settings.arguments,
          ),
          maintainState: true,
          fullscreenDialog: false,
        );
      },
      initialRoute: RouteName.initialRoute,
    )));
  }

    MaterialColor orangeTheme = const MaterialColor(
    0xFFD06128,
    <int, Color>{
      50: Color(0xFFFFF3E0),
      100: Color(0xFFFFE0B2),
      200: Color(0xFFFFCC80),
      300: Color(0xFFFFB74D),
      400: Color(0xFFFFA726),
      500: Color(0xFFD06128),
      600: Color(0xFFD06128),
      700: Color(0xFFD06128),
      800: Color(0xFFD06128),
      900: Color(0xFFD06128),
    },
  );
}


