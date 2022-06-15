import 'package:abp_tubes_2/pages/ballroom.dart';
import 'package:abp_tubes_2/pages/hiburan.dart';
import 'package:abp_tubes_2/pages/home.dart';
import 'package:abp_tubes_2/pages/kamar.dart';
import 'package:abp_tubes_2/pages/transaksi.dart';
import 'package:flutter/material.dart';

class TubesBottomNavBar extends StatefulWidget {
  const TubesBottomNavBar({Key? key}) : super(key: key);

  @override
  _TubesBottomNavBarState createState() => _TubesBottomNavBarState();
}

class _TubesBottomNavBarState extends State<TubesBottomNavBar> {
  int _selectedIndex = 0;
  String _appBarTitle = "Murriot";

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    KamarScreen(),
    BallroomScreen(),
    HiburanScreen(),
    TransaksiScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _appBarTitle = "Murriot";
          break;
        case 1:
          _appBarTitle = "Daftar Kamar";
          break;
        case 2:
          _appBarTitle = "Daftar Ballroom";
          break;
        case 3:
          _appBarTitle = "Daftar Ballroom";
          break;
        case 4:
          _appBarTitle = "Transaksi";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.door_back_door),
            label: 'Kamar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Ballroom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'Hiburan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transaksi',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
