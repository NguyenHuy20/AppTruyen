part of 'category_detail_bloc.dart';

abstract class CategoryDetailState extends Equatable {
  const CategoryDetailState();
}

class CategoryDetailInitial extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class GetListStorySuccessState extends CategoryDetailState {
  final List<StoryByCategory> lstStory;
  const GetListStorySuccessState({required this.lstStory});
  @override
  List<Object> get props => [identityHashCode(this), lstStory];
}

class GetListStoryFailState extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class PagingStorySuccessState extends CategoryDetailState {
  final List<StoryByCategory> lstStory;
  const PagingStorySuccessState({required this.lstStory});
  @override
  List<Object> get props => [identityHashCode(this), lstStory];
}

class PagingStoryFailState extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class LostPagingStoryState extends CategoryDetailState {
  @override
  List<Object> get props => [];
}

class GetDetailStorySuccessState extends CategoryDetailState {
  final StoryDetailModel model;
  const GetDetailStorySuccessState({required this.model});
  @override
  List<Object> get props => [];
}

class GetDetailStoryFailState extends CategoryDetailState {
  @override
  List<Object> get props => [];
}
