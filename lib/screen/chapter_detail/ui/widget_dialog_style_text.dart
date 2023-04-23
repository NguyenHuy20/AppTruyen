import 'package:apptruyen/screen/chapter_detail/view_model/chapter_detail_bloc.dart';
import 'package:apptruyen/share/values/shadow.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class WidgetDialogStyleText extends StatefulWidget {
  WidgetDialogStyleText(
      {super.key,
      this.fontSize,
      required this.bgImage,
      required this.colorText,
      required this.fontFamily,
      required this.chapterDetailBloc});
  late FontSize? fontSize;
  late String fontFamily;
  late Color colorText;
  late String bgImage;
  final ChapterDetailBloc chapterDetailBloc;
  @override
  State<WidgetDialogStyleText> createState() => _WidgetDialogStyleTextState();
}

class _WidgetDialogStyleTextState extends State<WidgetDialogStyleText> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChapterDetailBloc, ChapterDetailState>(
        listener: (context, state) {
          if (state is ChangeFontSizedSuccessState) {
            setState(() {
              widget.fontSize = state.fontSize;
            });
            return;
          }
          if (state is ChangeFontFamilySuccessState) {
            setState(() {
              widget.fontFamily = state.fontFamily;
            });
            return;
          }
          if (state is ChangeFontColorSuccessState) {
            setState(() {
              widget.colorText = state.colortext;
            });
            return;
          }
          if (state is ChangeBackgroundSuccessState) {
            setState(() {
              widget.bgImage = state.background;
            });
            return;
          }
        },
        child: Container(
            height: MediaQuery.of(context).orientation != Orientation.portrait
                ? MediaQuery.of(context).size.height / 1.4
                : MediaQuery.of(context).size.height / 2,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                Text(
                  'Cỡ chữ:',
                  style: appStyle,
                ),
                Wrap(
                  spacing: 20,
                  children: [
                    fontSizedOption(content: 'Normal', size: null),
                    fontSizedOption(content: 'Big', size: const FontSize(25)),
                  ],
                ),
                Text(
                  'Font chữ:',
                  style: appStyle,
                ),
                Wrap(
                  spacing: 20,
                  children: [
                    fontFamilyOption(fontFamily: 'Roboto'),
                    fontFamilyOption(fontFamily: 'SVN-Poppins'),
                  ],
                ),
                Text(
                  'Màu chữ:',
                  style: appStyle,
                ),
                Wrap(
                  spacing: 20,
                  children: [
                    colorTextOption(color: Colors.black, colorName: 'Đen'),
                    colorTextOption(color: Colors.white, colorName: 'Trắng'),
                  ],
                ),
                Text(
                  'Hình nền:',
                  style: appStyle,
                ),
                Wrap(
                  spacing: 20,
                  direction: Axis.horizontal,
                  children: [
                    bgOption(bgUrl: ''),
                    bgOption(bgUrl: 'assets/images/bg_1.jpg'),
                    bgOption(bgUrl: 'assets/images/bg_2.jpg'),
                    bgOption(bgUrl: 'assets/images/bg_3.jpg'),
                  ],
                )
              ],
            )));
  }

  Widget fontSizedOption({required FontSize? size, required content}) =>
      GestureDetector(
        onTap: () =>
            widget.chapterDetailBloc.add(ChangeFontSizeEvent(fontSize: size)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: widget.fontSize != size ? Colors.white : Colors.red),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: shadow),
          child: Text(content),
        ),
      );

  Widget fontFamilyOption({required String fontFamily}) => GestureDetector(
        onTap: () => widget.chapterDetailBloc
            .add(ChangeFontFamilyEvent(fontFamily: fontFamily)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: widget.fontFamily != fontFamily
                      ? Colors.white
                      : Colors.red),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: shadow),
          child: Text(fontFamily),
        ),
      );
  Widget colorTextOption({required Color color, required String colorName}) =>
      GestureDetector(
        onTap: () => widget.chapterDetailBloc
            .add(ChangeFontColorEvent(colorText: color)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: widget.colorText != color ? Colors.white : Colors.red),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: shadow),
          child: Text(colorName),
        ),
      );

  Widget bgOption({required String bgUrl}) => GestureDetector(
        onTap: () => widget.chapterDetailBloc
            .add(ChangeBackgroundEvent(background: bgUrl)),
        child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 2,
                    color: widget.bgImage != bgUrl ? Colors.white : Colors.red),
                borderRadius: BorderRadius.circular(50),
                boxShadow: bgUrl == '' ? shadow : null),
            child: bgUrl != ''
                ? ClipOval(
                    child: Image.asset(
                      bgUrl,
                      fit: BoxFit.fill,
                    ),
                  )
                : const Center(
                    child: Text('None'),
                  )),
      );
}
