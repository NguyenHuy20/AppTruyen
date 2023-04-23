part of 'story_detail_bloc.dart';

abstract class StoryDetailEvent extends Equatable {
  const StoryDetailEvent();
  @override
  List<Object> get props => [];
}

class GetChapterStoryEvent extends StoryDetailEvent {
  final String slug;
  const GetChapterStoryEvent({required this.slug});
  @override
  List<Object> get props => [];
}

class GetChapterDetailEvent extends StoryDetailEvent {
  final BuildContext context;
  final List<ChapterModel> lstChapter;
  final ChapterModel model;
  const GetChapterDetailEvent(
      {required this.context, required this.lstChapter, required this.model});
  @override
  List<Object> get props => [];
}
