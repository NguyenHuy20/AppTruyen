import 'package:apptruyen/screen/category/ui/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

import '../../share/utils/utils.dart';
import '../../share/values/style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, paddingTopPlatform(context) + 20, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Trang chủ',
              style: titleStyle.copyWith(color: Colors.blue),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: TitleScrollNavigation(
            barStyle: TitleNavigationBarStyle(
              style: appStyle.copyWith(
                  color: Colors.blue, fontWeight: FontWeight.w600),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
              spaceBetween: 40,
            ),
            titles: const [
              "Cập nhật",
              "Danh mục",
              "Đã full",
              "Sáng tác",
              "Của bạn",
            ],
            pages: [
              commingSoonScreen(),
              const CategoryScreen(),
              commingSoonScreen(),
              commingSoonScreen(),
              commingSoonScreen(),
            ],
          ))
        ]),
      ),
    );
  }

  Widget commingSoonScreen() => Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/coming_soon.webp'),
                fit: BoxFit.fill)),
      );
}
