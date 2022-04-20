import 'package:fastzone/data/hive.dart';
import 'package:fastzone/pages/home_page.dart';
import 'package:fastzone/pages/profile/profile_page.dart';
import 'package:fastzone/utils/onesignal.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//  io.flutter.app.FlutterApplication
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp();
  await loadHive();
  await setupOneSignal();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fastzone',
      theme: AppTheme.theme,
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  Home({ Key? key }) : super(key: key);
  final RxInt _selectedIndex = RxInt(0);
  final _pageOptions = <Widget>[
     HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: _pageOptions[_selectedIndex.value],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.redColor,
        currentIndex: _selectedIndex.value,
        onTap: (int index) {
          _selectedIndex.value = index;
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    ));
  }
}
