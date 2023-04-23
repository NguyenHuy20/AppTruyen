import 'package:apptruyen/screen/category/view_model/category_bloc.dart';
import 'package:apptruyen/screen/category_detail/view_model/category_detail_bloc.dart';
import 'package:apptruyen/screen/chapter_detail/view_model/chapter_detail_bloc.dart';
import 'package:apptruyen/screen/story_detail/view_model/story_detail_bloc.dart';
import 'package:apptruyen/share/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base.dart';
import 'screen/bottom_navigator/bottom_navigator.dart';

void main() {
  runApp(MyApp.runWidget());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truyen Full',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: black,
        platform: TargetPlatform.iOS,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).size.height > 850 ? 1.1 : 1),
          child: child!,
        );
      },
      home: const BottomNavigator(),
    );
  }

  static Widget runWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider(
          create: (context) => CategoryDetailBloc(),
        ),
        BlocProvider(
          create: (context) => StoryDetailBloc(),
        ),
        BlocProvider(
          create: (context) => ChapterDetailBloc(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
