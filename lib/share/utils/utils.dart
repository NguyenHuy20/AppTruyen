import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/style.dart';

double paddingTopPlatform(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

double paddingBottomPlatform(BuildContext context) {
  return MediaQuery.of(context).viewPadding.bottom;
}

Future goToScreen(BuildContext context, Widget screen,
    {int milliseconds = 100,
    String? routeName,
    ToScreenType type = ToScreenType.fade}) async {
  if (type == ToScreenType.fade) {
    return await Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: milliseconds),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return screen;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          settings: RouteSettings(name: routeName ?? "")),
    );
  }

  if (type == ToScreenType.remove) {
    return await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => screen),
        (Route<dynamic> route) => false);
  }

  if (type == ToScreenType.replacement) {
    return await Navigator.pushReplacement(context,
        MaterialPageRoute<void>(builder: (BuildContext context) => screen));
  }

  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

enum ToScreenType { nomal, fade, replacement, remove }

Widget loadMore(
    ScrollController scrollController, Widget widget, bool isEndPage) {
  return ListView(
    padding: EdgeInsets.zero,
    controller: scrollController,
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: false,
    children: [
      widget,
      isEndPage
          ? Center(
              child: Text("Đã xem hết danh sách",
                  style: appStyle.copyWith(color: Colors.grey, fontSize: 12)))
          : const SizedBox()
    ],
  );
}

Widget cupertinoLoading({Color color = Colors.white}) => ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop,
      ),
      child: const CupertinoActivityIndicator(),
    );

Widget loadingWidget({Color color = Colors.white}) => ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop,
      ),
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );

void showLoading(BuildContext context, bool turn, {Color? color}) async {
  return turn
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: loadingWidget(color: color ?? Colors.grey),
              ),
            );
          })
      : Navigator.pop(context);
}

String convertTime(String timeString) {
  DateTime dateTime = DateTime.parse(timeString);
  dateTime = dateTime.toLocal(); // chuyển đổi thành thời gian địa phương
  DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
  String formatted = formatter.format(dateTime);
  return formatted;
}
