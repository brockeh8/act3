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
        length: 4,    // changed from 3 to 4
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
  
  late TabController _tabController;     // going to keep track of all tabs and there history
  final RestorableInt tabIndex = RestorableInt(0);



  @override
  String get restorationId => 'tab_non_scrollable_demo';



  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }



  @override
  void initState() {
    super.initState();   // called everytime something is created 
    
    _tabController = TabController(
      initialIndex: 0,   // initialized 
      length: 4,         
      vsync: this,       // sync'd and pushes project to run smooth
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }



  // junk collector
  @override
  void dispose() {   // watches for leaks
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4']; 
    

    // app bar and body (main part of app)
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs'),
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

          // TAB 1 
          Container(
            color: Colors.lightBlue.shade50,
            padding: const EdgeInsets.all(16),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Press for alert'),
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Hello!'),
                        content: const Text('AHHHHHHHHHH'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('CLOSE'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('ALERT'),
                ),
              ],
            ),
          ),



          // TAB 2
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'wsp',
                  ),
                ),
                Image.network(
                  'https://tse4.mm.bing.net/th/id/OIP.V2cHrtVIvnST5MKxARm2OwHaEK?cb=ucfimgc2&rs=1&pid=ImgDetMain&o=7&rm=3',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),


          // TAB 3
          Container(
            color: Colors.orange.shade50,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),

            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('BUTTON YA!'),
                  ),
                );
              },
              child: Text('Click me plz'),
            ),
          ),



          // TAB 4
          Center( // ListView widget
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text('1'),
                    subtitle: Text('stuff'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('2'),
                    subtitle: Text('more stuff'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('3'),
                    subtitle: Text('dont look'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('4'),
                    subtitle: Text('ENOUGH'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// To do: Add a fourth tab with a ListView widget with at least 3 ListTile widgets in it.

//hello

