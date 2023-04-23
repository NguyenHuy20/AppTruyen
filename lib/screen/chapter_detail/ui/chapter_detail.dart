import 'package:apptruyen/model/chapter_detail_model.dart';
import 'package:apptruyen/screen/chapter_detail/view_model/chapter_detail_bloc.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../model/chapter_model.dart';
import 'widget_dialog_style_text.dart';

class ChapterDetailScreen extends StatefulWidget {
  const ChapterDetailScreen(
      {super.key,
      required this.data,
      required this.lstChapter,
      required this.model});
  final ChapterDetailModel data;
  final List<ChapterModel> lstChapter;
  final ChapterModel model;

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  late ChapterDetailBloc chapterDetailBloc;
  late ChapterDetailModel currentDataChapter = widget.data;
  int index = 0;
  int currentChapter = 0;
  @override
  void initState() {
    super.initState();
    currentChapter = widget.data.id ?? 0;
    chapterDetailBloc = BlocProvider.of<ChapterDetailBloc>(context);
    index = widget.lstChapter.indexOf(widget.model);
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
          if (state is ScrollNextChapterSuccessState) {
            setState(() {
              currentDataChapter = state.data;
            });
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
                      child: PageView.builder(
                          onPageChanged: (int page) {
                            if (page < index) {
                              // PageView is scrolled to the left
                              setState(() {
                                index = page;
                              });
                              ChapterModel element =
                                  widget.lstChapter.elementAt(index);
                              chapterDetailBloc.add(ScrollNextChapterEvent(
                                  context: context, id: element.id.toString()));
                              return;
                            }
                            setState(() {
                              index = page;
                            });
                            ChapterModel element =
                                widget.lstChapter.elementAt(index);
                            chapterDetailBloc.add(ScrollNextChapterEvent(
                                context: context, id: element.id.toString()));
                          },
                          controller: PageController(initialPage: index),
                          itemCount: widget.lstChapter.length,
                          itemBuilder: (context, index) {
                            return contentChapter(currentDataChapter);
                          }))
                ]),
              ),
            ],
          ),
        ));
  }

  Widget contentChapter(ChapterDetailModel data) =>
      BlocBuilder<ChapterDetailBloc, ChapterDetailState>(
          builder: (context, state) {
        if (state is ShowLoadingState) {
          return cupertinoLoading(color: Colors.grey);
        }
        if (state is ScrollNextChapterFailState) {
          return Image.asset('assets/images/error.webp');
        }
        return ListView(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: false,
            children: [
              Text(
                data.header ?? '',
                style: titleStyle.copyWith(
                  color: chapterDetailBloc.colorText,
                ),
                textAlign: TextAlign.center,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: data.body!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Html(
                    data: data.body![index],
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
            ]);
      });
}
