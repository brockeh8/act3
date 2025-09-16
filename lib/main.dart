import 'dart:math';
import 'package:flutter/material.dart';   // standard lib // app bar, text, etc

void main() {   // main entry in flutter app 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {   
  // main intro for objects to be used ie: a blueprint for whats to be built

  @override
  Widget build(BuildContext context) {   // first widget 
    return MaterialApp(     
      // grabs all the common features to how we are theme, nav, and title
      home: DefaultTabController(    
        // default screen
        length: 7,    
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {   // extends widget class
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();  
  // assigns state to widget
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  
  late TabController _tabController;     
  final RestorableInt tabIndex = RestorableInt(0);

  //weather start
  final TextEditingController _cityController = TextEditingController();
  String _city = '';
  String _temp = '';
  String _condition = '';

  void _fetchWeather() {
    final name = _cityController.text.trim();
    if (name.isEmpty) {
      setState(() {
        _city = 'Please enter a city';
        _temp = '';
        _condition = '';
      });
      return;
    }
    //random num
    final r = Random();
    final t = 15 + r.nextInt(16);
    const options = ['Sunny', 'Cloudy', 'Rainy'];
    final cond = options[r.nextInt(options.length)];

    setState(() {
      _city = name;
      _temp = '$t°C';
      _condition = cond;
    });
  }
  

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();   
    _tabController = TabController(
      initialIndex: 0,   
      length: 7,         
      vsync: this,       
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {   
    _tabController.dispose();
    tabIndex.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']; 
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tabs'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

          //tab starts
          Container(
          )
        ],
      ),
    );
  }
}
