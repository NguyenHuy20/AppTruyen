import 'dart:convert';

import 'package:apptruyen/model/chapter_detail_model.dart';
import 'package:apptruyen/model/chapter_model.dart';
import 'package:apptruyen/repo/story_repo.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/story_detail_model.dart';
import '../../chapter_detail/ui/chapter_detail.dart';

part 'story_detail_event.dart';
part 'story_detail_state.dart';

class StoryDetailBloc extends Bloc<StoryDetailEvent, StoryDetailState> {
  List<ChapterModel> lstChapter = [];
  StoryDetailBloc() : super(StoryDetailInitial()) {
    on<GetChapterStoryEvent>(_getChapterStory);
    on<GetChapterDetailEvent>(_getChapterDetail);
  }
  final storyRepo = StoryRepo();

  Future<void> _getChapterStory(
      GetChapterStoryEvent event, Emitter<StoryDetailState> emit) async {
    try {
      var response = await storyRepo.getAllChapter(event.slug);
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        lstChapter =
            responseData.map((data) => ChapterModel.fromJson(data)).toList();
        emit(GetListChapterSuccessState(lstChapter: lstChapter));
        return;
      }
      emit(GetListChapterFailState());
    } catch (ex) {
      emit(GetListChapterFailState());
    }
  }

  Future<void> _getChapterDetail(
      GetChapterDetailEvent event, Emitter<StoryDetailState> emit) async {
    try {
      showLoading(event.context, true);
      var response =
          await storyRepo.getChapterDetail(event.model.id.toString());
      showLoading(event.context, false);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final ChapterDetailModel chapterDetail =
            ChapterDetailModel.fromJson(responseData);
        goToScreen(
            event.context,
            ChapterDetailScreen(
              model: event.model,
              data: chapterDetail,
              lstChapter: event.lstChapter,
            ),
            type: ToScreenType.nomal);
        return;
      }
      emit(GetListChapterFailState());
    } catch (ex) {
      emit(GetListChapterFailState());
    }
  }
}
