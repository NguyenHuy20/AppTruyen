import 'dart:async';

import 'package:apptruyen/model/chapter_model.dart';
import 'package:apptruyen/screen/story_detail/ui/show_all_chapter.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../view_model/story_detail_bloc.dart';

class WidgetChapter extends StatelessWidget {
  const WidgetChapter(
      {super.key,
      required this.chapterController,
      required this.slug,
      required this.storyDetailBloc});
  final String slug;
  final BehaviorSubject<List<ChapterModel>> chapterController;
  final StoryDetailBloc storyDetailBloc;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Các chương mới nhất',
                  style: appStyle,
                ),
                GestureDetector(
                  onTap: () => goToScreen(
                      context,
                      ShowAllChapter(
                        chapterController: chapterController,
                        storyDetailBloc: storyDetailBloc,
                      ),
                      type: ToScreenType.nomal),
                  child: Text(
                    'Xem tất cả',
                    style: appStyle.copyWith(color: Colors.blue),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<ChapterModel>>(
                  stream: chapterController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => storyDetailBloc.add(
                                    GetChapterDetailEvent(
                                        id: snapshot.data![index].id.toString(),
                                        context: context)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 8),
                                  child: Text(
                                    snapshot.data![index].header ?? '',
                                    style: appStyle,
                                  ),
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: Text('Chưa có chương mới'),
                      );
                    }
                    return cupertinoLoading(color: Colors.grey);
                  }),
            )
          ],
        ));
  }
}
