import 'dart:convert';
import 'package:apptruyen/screen/story_detail/ui/story_detail_screen.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/story_by_category_model.dart';
import '../../../model/story_detail_model.dart';
import '../../../repo/category_repo.dart';
import '../../../repo/story_repo.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  List<StoryByCategory> lstStory = [];
  int pageIndex = 0;
  bool endPage = false;
  CategoryDetailBloc() : super(CategoryDetailInitial()) {
    on<GetAllStoryEvent>(_getAllStory);
    on<PagingStoryByCategoryEvent>(_pagingStory);
    on<GetStoryDetailEvent>(_getDetailStory);
  }
  final categoryRepo = CategoryRepo();
  final storyRepo = StoryRepo();

  Future<void> _getDetailStory(
      GetStoryDetailEvent event, Emitter<CategoryDetailState> emit) async {
    try {
      showLoading(event.context, true);
      var response = await storyRepo.getStoryDetail(event.id);
      showLoading(event.context, false);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final StoryDetailModel storyDetail =
            StoryDetailModel.fromJson(responseData);
        goToScreen(
            event.context,
            StoryDetailScreen(
              data: storyDetail,
            ),
            type: ToScreenType.nomal);
        return;
      }
      emit(GetDetailStoryFailState());
    } catch (ex) {
      emit(GetDetailStoryFailState());
    }
  }

  Future<void> _getAllStory(
      GetAllStoryEvent event, Emitter<CategoryDetailState> emit) async {
    try {
      var response = await categoryRepo.getStoryByCategory(event.id);
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        lstStory =
            responseData.map((data) => StoryByCategory.fromJson(data)).toList();
        emit(GetListStorySuccessState(lstStory: lstStory));
        return;
      }
      emit(GetListStoryFailState());
    } catch (ex) {
      emit(GetListStoryFailState());
    }
  }

  Future<void> _pagingStory(PagingStoryByCategoryEvent event,
      Emitter<CategoryDetailState> emit) async {
    if (endPage == false) {
      try {
        pageIndex++;
        var response =
            await categoryRepo.pagingStoryByCategory(event.id, pageIndex);
        if (response.statusCode == 200) {
          if (response.body == '') {
            endPage = true;
            emit(LostPagingStoryState());
            return;
          }
          List<dynamic> responseData = jsonDecode(response.body);
          responseData
              .map((data) => StoryByCategory.fromJson(data))
              .toList()
              .forEach((element) {
            lstStory.add(element);
          });
          emit(PagingStorySuccessState(lstStory: lstStory.toList()));
          return;
        }
        emit(PagingStoryFailState());
      } catch (ex) {
        emit(PagingStoryFailState());
      }
    }
  }
}
