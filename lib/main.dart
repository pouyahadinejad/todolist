// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todolist/data.dart';
// import 'home_screen.dart';
// import 'otp_login_page.dart';

// const taskBoxName = 'tasks';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Hive.initFlutter();
//   await Hive.initFlutter();
//   await Hive.openBox<String>('auth');
//   Hive.registerAdapter(TaskAdapter());
//   Hive.registerAdapter(PriorityAdapter());
//   await Hive.openBox<TaskEntity>(taskBoxName);
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: primaryVariantColor),
//   );
//   runApp(const MyApp());
// }

// const Color primaryColor = Color(0xff794CFF);
// const Color primaryVariantColor = Color(0xff5C0AFF);
// const secondaryTextColor = Color(0xffAFBED0);
// const normalPriority = Color(0xffF09819);
// const lowPriority = Color(0xff3BE1F1);
// const highPriority = primaryColor;

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box('auth');
//     var token = box.get('token') as String;
//     const primaryTextColor = Color(0xff1D2830);
//     return MaterialApp(
//       title: 'Flutter Demo',
//       // theme: ThemeData(

//       //   textTheme: GoogleFonts.poppinsTextTheme(
//       //     const TextTheme(
//       //       headlineSmall: TextStyle(fontWeight: FontWeight.bold),
//       //     ),
//       //   ),
//       //   inputDecorationTheme: const InputDecorationTheme(
//       //     floatingLabelBehavior: FloatingLabelBehavior.never,
//       //     labelStyle: TextStyle(color: secondaryTextColor),
//       //     border: InputBorder.none,
//       //     iconColor: secondaryTextColor,
//       //   ),
//       //   colorScheme: const ColorScheme.light(
//       //     primary: primaryColor,
//       //     onPrimaryFixed: primaryVariantColor,
//       //     background: Color(0xffF3F5F8),
//       //     onSurface: primaryTextColor,
//       //     onPrimary: Colors.white,
//       //     onBackground: primaryTextColor,
//       //     secondary: primaryColor,
//       //     onSecondary: Colors.white,
//       //   ),
//       // ),
//       theme: ThemeData(
//         textTheme: const TextTheme(
//           headlineSmall: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff1D2830),
//           ),
//           bodyMedium: TextStyle(fontSize: 14),
//         ),
//         inputDecorationTheme: const InputDecorationTheme(
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//           labelStyle: TextStyle(color: secondaryTextColor),
//           border: InputBorder.none,
//           iconColor: secondaryTextColor,
//         ),
//         colorScheme: const ColorScheme.light(
//           primary: primaryColor,
//           onPrimaryFixed: primaryVariantColor,
//           background: Color(0xffF3F5F8),
//           onSurface: primaryTextColor,
//           onPrimary: Colors.white,
//           onBackground: primaryTextColor,
//           secondary: primaryColor,
//           onSecondary: Colors.white,
//         ),
//       ),

//       home: token !=null?HomeScreen():OtpLoginPage(),
//       routes: {
//         '/home':(context)=>HomeScreen(),
//         '/login':(context)=>OtpLoginPage(),
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todolist/data.dart';
// import 'home_screen.dart';
// import 'otp_login_page.dart';

// const taskBoxName = 'tasks';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox<String>('auth');
//   Hive.registerAdapter(TaskAdapter());
//   Hive.registerAdapter(PriorityAdapter());
//   await Hive.openBox<TaskEntity>(taskBoxName);

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: primaryVariantColor),
//   );

//   runApp(const MyApp());
// }

// const Color primaryColor = Color(0xff794CFF);
// const Color primaryVariantColor = Color(0xff5C0AFF);
// const secondaryTextColor = Color(0xffAFBED0);
// const normalPriority = Color(0xffF09819);
// const lowPriority = Color(0xff3BE1F1);
// const highPriority = primaryColor;

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box<String>('auth');
//     var token = box.get('token') as String?;

//     const primaryTextColor = Color(0xff1D2830);

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',


//       theme: ThemeData(
//         textTheme: const TextTheme(
//           headlineSmall: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff1D2830),
//           ),
//           bodyMedium: TextStyle(fontSize: 14),
//         ),
//         inputDecorationTheme: const InputDecorationTheme(
//           floatingLabelBehavior: FloatingLabelBehavior.never,
//           labelStyle: TextStyle(color: secondaryTextColor),
//           border: InputBorder.none,
//           iconColor: secondaryTextColor,
//         ),
//         colorScheme: const ColorScheme.light(
//           primary: primaryColor,
//           onPrimaryFixed: primaryVariantColor,
//           background: Color(0xffF3F5F8),
//           onSurface: primaryTextColor,
//           onPrimary: Colors.white,
//           onBackground: primaryTextColor,
//           secondary: primaryColor,
//           onSecondary: Colors.white,
//         ),
//       ),
//       home: token != null ? HomeScreen() : OtpLoginPage(),
//       routes: {
//         '/home': (context) => HomeScreen(),
//         '/login': (context) => OtpLoginPage(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data.dart';
import 'home_screen.dart';
import 'otp_login_page.dart';

// --- اضافه کردن رنگ‌ها ---
const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const Color secondaryTextColor = Color(0xffAFBED0);
const Color normalPriority = Color(0xffF09819);
const Color lowPriority = Color(0xff3BE1F1);
const Color highPriority = primaryColor;

const taskBoxName = 'tasks';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('auth');
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: primaryVariantColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> checkToken() async {
    var box = Hive.box<String>('auth');
    var token = box.get('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff1D2830)),
          bodyMedium: TextStyle(fontSize: 14),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(color: secondaryTextColor),
          border: InputBorder.none,
          iconColor: secondaryTextColor,
        ),
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimaryFixed: primaryVariantColor,
          background: Color(0xffF3F5F8),
          onSurface: Color(0xff1D2830),
          onPrimary: Colors.white,
          onBackground: Color(0xff1D2830),
          secondary: primaryColor,
          onSecondary: Colors.white,
        ),
      ),
      home: FutureBuilder<bool>(
        future: checkToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return OtpLoginPage();
          }
        },
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => OtpLoginPage(),
      },
    );
  }
}
