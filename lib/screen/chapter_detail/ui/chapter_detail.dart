import 'package:apptruyen/model/chapter_detail_model.dart';
import 'package:apptruyen/screen/chapter_detail/view_model/chapter_detail_bloc.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'widget_dialog_style_text.dart';

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen({super.key, required this.data});
  final ChapterDetailModel data;
  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  late ChapterDetailBloc chapterDetailBloc;

  @override
  void initState() {
    super.initState();
    chapterDetailBloc = BlocProvider.of<ChapterDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChapterDetailBloc, ChapterDetailState>(
        listener: (context, state) {
          if (state is ChangeFontSizedSuccessState) {
            setState(() {
              chapterDetailBloc.fontSize = state.fontSize;
            });
            return;
          }
          if (state is ChangeFontFamilySuccessState) {
            setState(() {
              chapterDetailBloc.fontFamily = state.fontFamily;
            });
            return;
          }
          if (state is ChangeFontColorSuccessState) {
            setState(() {
              chapterDetailBloc.colorText = state.colortext;
            });
            return;
          }
          if (state is ChangeBackgroundSuccessState) {
            setState(() {
              chapterDetailBloc.bgImage = state.background;
            });
            return;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              chapterDetailBloc.bgImage != ''
                  ? Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                chapterDetailBloc.bgImage,
                              ),
                              fit: BoxFit.fill)))
                  : const SizedBox(),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20,
                    paddingTopPlatform(context) + 20,
                    20,
                    paddingBottomPlatform(context) + 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios)),
                      IconButton(
                          onPressed: () => chapterDetailBloc.add(
                              ShowDialogEditTextEvent(
                                  chapterDetailBloc: chapterDetailBloc,
                                  context: context,
                                  bgImage: chapterDetailBloc.bgImage,
                                  colorText: chapterDetailBloc.colorText,
                                  fontFamily: chapterDetailBloc.fontFamily,
                                  fontSize: chapterDetailBloc.fontSize)),
                          icon: const Icon(Icons.settings)),
                    ],
                  ),
                  Expanded(
                      child: ListView(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: false,
                          children: [
                        Text(
                          widget.data.header ?? '',
                          style: titleStyle.copyWith(
                            color: chapterDetailBloc.colorText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: widget.data.body!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Html(
                              data: widget.data.body![index],
                              style: {
                                "html": Style(
                                  fontFamily: chapterDetailBloc.fontFamily,
                                  fontSize: chapterDetailBloc.fontSize,
                                  color: chapterDetailBloc.colorText,
                                ),
                              },
                            );
                          },
                        ),
                        Text(
                          '--- Hết ---',
                          style: titleStyle.copyWith(
                            color: chapterDetailBloc.colorText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]))
                ]),
              ),
            ],
          ),
        ));
  }
}
