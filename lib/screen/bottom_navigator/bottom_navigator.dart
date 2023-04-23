import 'dart:io';

import 'package:apptruyen/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../share/values/style.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static final List<Widget> _lstWidgets = <Widget>[
    const HomeScreen(),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/coming_soon.webp'),
              fit: BoxFit.fill)),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/coming_soon.webp'),
              fit: BoxFit.fill)),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/coming_soon.webp'),
              fit: BoxFit.fill)),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/coming_soon.webp'),
              fit: BoxFit.fill)),
    ),
  ];
  Widget iconUnActive(
    IconData icon,
  ) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Icon(
          icon,
        ));
  }

  Widget iconActive(
    IconData icon,
  ) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Icon(
          icon,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          body: _lstWidgets.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: appStyle,
            unselectedLabelStyle: appStyle,
            items: [
              BottomNavigationBarItem(
                  icon: iconUnActive(Icons.home),
                  activeIcon: iconActive(Icons.home),
                  label: 'Trang chủ'),
              BottomNavigationBarItem(
                  icon: iconUnActive(Icons.search),
                  activeIcon: iconActive(Icons.search),
                  label: 'Tìm kiếm'),
              BottomNavigationBarItem(
                  icon: iconUnActive(Icons.book),
                  activeIcon: iconActive(Icons.book),
                  label: 'Kệ sách'),
              BottomNavigationBarItem(
                  icon: iconUnActive(Icons.chat),
                  activeIcon: iconActive(Icons.chat),
                  label: 'Cộng đồng'),
              BottomNavigationBarItem(
                  icon: iconUnActive(Icons.people),
                  activeIcon: iconActive(Icons.people),
                  label: 'Cài đặt'),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      content: const Text('Bạn có muốn thoát ứng dụng?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => exit(0),
          child: const Text('Đồng ý'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child:
              const Text('Đóng', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
