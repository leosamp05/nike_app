import 'package:flutter/material.dart';
import 'package:nike_app/pages/home_page.dart';
import 'package:nike_app/pages/inbox.dart';
import 'package:nike_app/pages/profile.dart';
import 'package:nike_app/pages/wishlist.dart';
import 'package:nike_app/widgets/drawer_custom.dart';
import 'package:nike_app/widgets/header.dart';
import 'package:nike_app/widgets/bottom_app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      home: const MyHomePage(title: 'Nike App', selectedIndex: 0),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required selectedIndex});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [HomePage(), Wishlist(), Inbox(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerCustom(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),

      appBar: const Header(),
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
