import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:track_your_expense/data/expense_data.dart';
import 'package:track_your_expense/home_page.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 1, 106, 29),
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
);
void main() async {
  await Hive.initFlutter();
  await Hive.openBox("expense_tracker_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
    );
    return ChangeNotifierProvider(
      create: (BuildContext context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false, home: MyHomePage(), theme: theme),
    );
  }
}


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   Get.put(UserProfileViewModel());
//   Get.put(AuthViewModel());
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String defaultLanguage =
//       prefs.getString('defaultLanguage') ?? 'english_IN';

//   // Set the default language
//   Get.updateLocale(
//       Locale(defaultLanguage.split('_')[0], defaultLanguage.split('_')[1]));
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         ScreenUtil.init(
//           context,
//           designSize: Size(
//             MediaQuery.of(context).size.width,
//             MediaQuery.of(context).size.height,
//           ),
//         );
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: theme,
//           locale: const Locale('english', 'IN'),
//           fallbackLocale: const Locale('english', 'IN'),
//           translations: Languages(),
//           initialRoute: '/',
//           unknownRoute:
//               GetPage(name: '/route_error', page: () => const RouteErrorView()),
//           getPages: AppRoutes.pages,
//         );
//       },
//     );
//   }
// }
