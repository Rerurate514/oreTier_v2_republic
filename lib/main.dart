import 'package:flutter/material.dart';
import 'package:reoretier/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ore-tier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "yomogi"
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;
  late final List<Widget> _pages;

  void moveHomePage(){
    setState(() {
      _pageIndex = 0;
    });
  }

  @override
  void initState(){
    super.initState();
    _pages = [
      const HomePage(),
    ];
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(child: _pages[_pageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: "CREATE"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "SETTING"
          ),
        ]
      ),
    );
  }
}
