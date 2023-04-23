import 'dart:ui';

import 'package:apptruyen/screen/story_detail/view_model/story_detail_bloc.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/chapter_model.dart';
import '../../../model/story_detail_model.dart';
import '../../../share/widget/flushbar_custom.dart';
import 'widget_chapter.dart';
import 'widget_info_story.dart';

class StoryDetailScreen extends StatefulWidget {
  const StoryDetailScreen({super.key, required this.data});
  final StoryDetailModel data;
  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  late StoryDetailBloc storyDetailBloc;
  late BehaviorSubject<List<ChapterModel>> chapterController =
      BehaviorSubject<List<ChapterModel>>();
  @override
  void initState() {
    super.initState();
    storyDetailBloc = BlocProvider.of<StoryDetailBloc>(context)
      ..add(GetChapterStoryEvent(slug: widget.data.slug ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryDetailBloc, StoryDetailState>(
      listener: (context, state) {
        if (state is GetListChapterSuccessState) {
          chapterController.add(state.lstChapter);
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, paddingTopPlatform(context) + 20,
                20, paddingBottomPlatform(context) + 10),
            child: Column(children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50),
                child: Column(children: [
                  SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipOval(
                          child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.data.poster ?? "",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CupertinoActivityIndicator(
                          radius: 10,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.data.title ?? '',
                    style: titleStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              WidgetinfoStory(
                data: widget.data,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (chapterController.hasValue &&
                      chapterController.value.isNotEmpty) {
                    storyDetailBloc.add(GetChapterDetailEvent(
                        id: chapterController.value.first.id.toString(),
                        context: context));
                    return;
                  }
                  showFlushBar(context,
                      msg: 'Chưa có chương mới', status: FLUSHBAR_ERROR);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue),
                  child: Text(
                    'Đọc truyện',
                    style: titleStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.data.description!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      widget.data.description![index],
                      style: appStyle,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              WidgetChapter(
                slug: widget.data.slug ?? '',
                chapterController: chapterController,
                storyDetailBloc: storyDetailBloc,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade50),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bình luận mới nhất',
                          style: appStyle,
                        ),
                        Text(
                          'Xem tất cả',
                          style: appStyle.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ])),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade100),
                  child: Text(
                    'Quay lại',
                    style: appStyle.copyWith(color: Colors.blue),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
