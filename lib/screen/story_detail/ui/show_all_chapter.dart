import 'dart:async';

import 'package:apptruyen/share/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/chapter_model.dart';
import '../../../share/values/style.dart';
import '../view_model/story_detail_bloc.dart';

class ShowAllChapter extends StatelessWidget {
  const ShowAllChapter(
      {super.key,
      required this.chapterController,
      required this.storyDetailBloc});
  final BehaviorSubject<List<ChapterModel>> chapterController;
  final StoryDetailBloc storyDetailBloc;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, paddingTopPlatform(context) + 20, 20,
            paddingBottomPlatform(context) + 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios)),
              const Icon(
                Icons.list_sharp,
                color: Colors.blue,
              )
            ],
          ),
          Expanded(
            child: StreamBuilder<List<ChapterModel>>(
                stream: chapterController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => storyDetailBloc.add(
                                  GetChapterDetailEvent(
                                      id: snapshot.data![index].id.toString(),
                                      context: context)),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade50),
                                padding: const EdgeInsets.all(
                                  10,
                                ),
                                child: Text(
                                  snapshot.data![index].header ?? '',
                                  style: appStyle,
                                ),
                              ),
                            );
                          });
                    }
                    return Image.asset('assets/images/empty_data.webp');
                  }
                  if (snapshot.hasError) {
                    return Image.asset('assets/images/error.webp');
                  }
                  return cupertinoLoading(color: Colors.grey);
                }),
          ),
        ]),
      ),
    );
  }
}
