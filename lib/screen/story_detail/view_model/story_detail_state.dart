part of 'story_detail_bloc.dart';

abstract class StoryDetailState extends Equatable {
  const StoryDetailState();
}

class StoryDetailInitial extends StoryDetailState {
  @override
  List<Object> get props => [];
}

class GetListChapterSuccessState extends StoryDetailState {
  final List<ChapterModel> lstChapter;
  const GetListChapterSuccessState({required this.lstChapter});
  @override
  List<Object> get props => [identityHashCode(this), lstChapter];
}

class GetListChapterFailState extends StoryDetailState {
  @override
  List<Object> get props => [];
}
