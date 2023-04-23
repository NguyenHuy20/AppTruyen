part of 'category_detail_bloc.dart';

abstract class CategoryDetailEvent extends Equatable {
  const CategoryDetailEvent();
  @override
  List<Object> get props => [];
}

class GetAllStoryEvent extends CategoryDetailEvent {
  final String id;
  const GetAllStoryEvent({required this.id});
  @override
  List<Object> get props => [];
}

class PagingStoryByCategoryEvent extends CategoryDetailEvent {
  final String id;
  const PagingStoryByCategoryEvent({required this.id});
  @override
  List<Object> get props => [];
}

class GetStoryDetailEvent extends CategoryDetailEvent {
  final BuildContext context;
  final String id;
  const GetStoryDetailEvent({required this.id, required this.context});
  @override
  List<Object> get props => [];
}
