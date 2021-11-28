import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:myapp/screens/booking_auth.dart';
import 'package:myapp/screens/booking_student.dart';
import 'package:myapp/screens/calendar.dart';
import 'package:myapp/screens/forgot_password_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/nested_dropdown.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
//import 'package:myapp/map.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch:Palette.mycolor,
//         ).copyWith(
//         ),
//       ),
//     home: Home(),
//   ));
// }
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//       routes: {
//         SignupScreen.routeName: (ctx)=> SignupScreen(),
//         LoginScreen.routeName: (ctx)=> LoginScreen(),
//         HomeScreen.routeName: (ctx)=> HomeScreen(),
//         ForgotPasswordScreen.routeName: (ctx)=>ForgotPasswordScreen(),
//         BookingStudentScreen.routeName: (ctx)=>BookingStudentScreen(),
//         BookingAuthScreen.routeName: (ctx)=>BookingAuthScreen(value: '',),
//         CalendarWidget.routeName:(ctx)=>CalendarWidget(),
//         Dropdownsearch.routeName:(ctx)=>Dropdownsearch(),
//       },
//     );
//   }
// }
// class Palette{
//   static const mycolor=const MaterialColor(
//     0xffFF4C29, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
//     const <int, Color>{
//       50: const Color(0xffFF4C29),//10%
//       100: const Color(0xffFF4C29),//20%
//       200: const Color(0xffa04332),//30%
//       300: const Color(0xff89392b),//40%
//       400: const Color(0xff733024),//50%
//       500: const Color(0xff5c261d),//60%
//       600: const Color(0xff451c16),//70%
//       700: const Color(0xff2e130e),//80%
//       800: const Color(0xff170907),//90%
//       900: const Color(0xff000000),//100%
//     },
//   );
// }






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel()
  {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId('73a8540a-50bd-4140-b43e-3e6f3d972db3');
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch:Palette.mycolor,
        ).copyWith(
          secondary: Colors.green,

        ),
        // platform: TargetPlatform.iOS,
      ),
      home: LoginScreen(),
      routes: {
        SignupScreen.routeName: (ctx)=> SignupScreen(),
        LoginScreen.routeName: (ctx)=> LoginScreen(),
        HomeScreen.routeName: (ctx)=> HomeScreen(),
        ForgotPasswordScreen.routeName: (ctx)=>ForgotPasswordScreen(),
        BookingStudentScreen.routeName: (ctx)=>BookingStudentScreen(),
        BookingAuthScreen.routeName: (ctx)=>BookingAuthScreen(value: '',),
        CalendarWidget.routeName:(ctx)=>CalendarWidget(),
        //Dropdownsearch.routeName:(ctx)=>Dropdownsearch(),
        StaticDropDown.routeName:(ctx)=>StaticDropDown(),
      },
    );
  }
}
class Palette{
  static const mycolor=const MaterialColor(
    0xffFF4C29, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffFF4C29),//10%
      100: const Color(0xffFF4C29),//20%
      200: const Color(0xffa04332),//30%
      300: const Color(0xff89392b),//40%
      400: const Color(0xff733024),//50%
      500: const Color(0xff5c261d),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );
}
