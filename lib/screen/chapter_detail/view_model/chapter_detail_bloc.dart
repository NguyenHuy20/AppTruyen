import 'dart:convert';

import 'package:apptruyen/share/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/style.dart';

import '../../../model/chapter_detail_model.dart';
import '../../../model/chapter_model.dart';
import '../../../repo/story_repo.dart';
import '../ui/widget_dialog_style_text.dart';

part 'chapter_detail_event.dart';
part 'chapter_detail_state.dart';

class ChapterDetailBloc extends Bloc<ChapterDetailEvent, ChapterDetailState> {
  FontSize? fontSize;
  String fontFamily = 'Roboto';
  Color colorText = Colors.black;
  String bgImage = '';
  ChapterDetailBloc() : super(ChapterDetailInitial()) {
    on<ShowDialogEditTextEvent>(_showDilogEditText);
    on<ChangeFontSizeEvent>(_changeFontSized);
    on<ChangeFontFamilyEvent>(_changeFontFamily);
    on<ChangeFontColorEvent>(_changeFontColor);
    on<ChangeBackgroundEvent>(_changeBackground);
    on<ScrollNextChapterEvent>(_scrollNextChapter);
  }
  final storyRepo = StoryRepo();

  Future<void> _showDilogEditText(
      ShowDialogEditTextEvent event, Emitter<ChapterDetailState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => Dialog(
            insetPadding: const EdgeInsets.all(10.0),
            child: WidgetDialogStyleText(
              chapterDetailBloc: event.chapterDetailBloc,
              fontSize: event.fontSize,
              colorText: event.colorText,
              fontFamily: event.fontFamily,
              bgImage: event.bgImage,
            )));
  }

  Future<void> _scrollNextChapter(
      ScrollNextChapterEvent event, Emitter<ChapterDetailState> emit) async {
    try {
      emit(ShowLoadingState());
      var response = await storyRepo.getChapterDetail(event.id);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final ChapterDetailModel chapterDetail =
            ChapterDetailModel.fromJson(responseData);
        emit(ScrollNextChapterSuccessState(data: chapterDetail));
        return;
      }
      emit(ScrollNextChapterFailState());
    } catch (ex) {
      emit(ScrollNextChapterFailState());
    }
  }

  Future<void> _changeFontSized(
      ChangeFontSizeEvent event, Emitter<ChapterDetailState> emit) async {
    fontSize = event.fontSize;
    emit(ChangeFontSizedSuccessState(fontSize: event.fontSize));
  }

  Future<void> _changeFontFamily(
      ChangeFontFamilyEvent event, Emitter<ChapterDetailState> emit) async {
    fontFamily = event.fontFamily;
    emit(ChangeFontFamilySuccessState(fontFamily: event.fontFamily));
  }

  Future<void> _changeFontColor(
      ChangeFontColorEvent event, Emitter<ChapterDetailState> emit) async {
    colorText = event.colorText;
    emit(ChangeFontColorSuccessState(colortext: event.colorText));
  }

  Future<void> _changeBackground(
      ChangeBackgroundEvent event, Emitter<ChapterDetailState> emit) async {
    bgImage = event.background;
    emit(ChangeBackgroundSuccessState(background: event.background));
  }
}
