
import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import 'package:enavit/pages/main_pages/profile_page.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'my_events_page.dart';
import 'package:enavit/services/authentication_service.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final AuthenticationService _firebaseAuth = AuthenticationService();

  int selectedIndex = 0 ;

  void navigateBottomBar(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const MyEvents(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: NavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        title: const Text('Enavit'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Padding(
                padding:  EdgeInsets.only(left: 25.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                  ),
              ),
            ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                 //logo
                DrawerHeader(
                  child: Image.asset(
                    'lib/images/Denji.jpg',
                    height: 300,
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Divider(
                    color: Colors.grey[400],
                    thickness: 1,
                  ),
                  ),
                  
                  //other pages
                  const Padding(
                    padding: EdgeInsets.only(left:25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                        ),
                      title: Text(
                        'home',
                        style: TextStyle(color: Colors.white),
                      ),
                      ),
                    ),

                  const Padding(
                    padding: EdgeInsets.only(left:25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.white,
                        ),
                      title: Text(
                        'About',
                        style: TextStyle(color: Colors.white),
                      ),
                      ),
                    ),
              ],
            ), 
              
              Padding(
                padding: const EdgeInsets.only(left:25.0,bottom: 25.0),
                child: GestureDetector(
                  onTap: () {
                    _firebaseAuth.signOut(context);
                  },
                  child:  const ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                      ),
                    title: Text(
                      'logout',
                      style: TextStyle(color: Colors.white),
                    ),
                        ),
                ),
              ),
          ]
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
