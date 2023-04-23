part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class GetListCategorySuccessState extends CategoryState {
  final List<CategoryData> lstCateGory;
  const GetListCategorySuccessState({required this.lstCateGory});
  @override
  List<Object> get props => [identityHashCode(this), lstCateGory];
}

class GetListCategoryFailState extends CategoryState {
  @override
  List<Object> get props => [];
}
