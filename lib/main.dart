// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobi_tax/firebase_options.dart';
import 'package:mobi_tax/introductionPage.dart';
import 'package:mobi_tax/profil_page.dart';
import 'package:mobi_tax/sign_in.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'themeModeData.dart';
import 'transaksi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeModeData()),
        // Tambahkan provider lain jika diperlukan di sini
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ColorScheme lightScheme = ColorScheme.fromSeed(
      seedColor: Colors.white,
    );
    ColorScheme darkScheme = ColorScheme.fromSeed(
      seedColor: Colors.black,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'MobiTax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // Penyesuaian warna font dan latar belakang untuk tema terang
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          labelMedium: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(color: Colors.black, fontSize: 12),
        ),
        canvasColor: Colors.white,
        colorScheme: lightScheme,
        dialogBackgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // Penyesuaian warna font dan latar belakang untuk tema gelap
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
          displaySmall: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          labelMedium: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        canvasColor: Colors.black,
        colorScheme: darkScheme,
        dialogBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNavigation();
          } else {
            return const IntroductionPage();
          }
        },
      ),
      // theme: Provider.of<ThemeProvider>(context).currentTheme,
      themeMode: context
          .watch<ThemeModeData>()
          .themeMode, // Gunakan ThemeMode dari penyedia ThemeModeData
      //home: MyHomePage(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List pages yang ditampilkan
  final List<Widget> _pages = [
    const MyHomePage(),
    transaksi(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromRGBO(70, 152, 138, 1),
        unselectedItemColor:
            // const Color.fromARGB(255, 161, 161, 159).withOpacity(0.5),
            Theme.of(context).iconTheme.color,
        //unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profil',
          ),
        ],
        //unselectedIconTheme: Theme.of(context).iconTheme,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
