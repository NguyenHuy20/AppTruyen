part of 'chapter_detail_bloc.dart';

abstract class ChapterDetailState extends Equatable {
  const ChapterDetailState();
}

class ChapterDetailInitial extends ChapterDetailState {
  @override
  List<Object> get props => [];
}

class ChangeFontSizedSuccessState extends ChapterDetailState {
  final FontSize? fontSize;
  const ChangeFontSizedSuccessState({required this.fontSize});
  @override
  List<Object> get props => [
        identityHashCode(this),
      ];
}

class ChangeFontFamilySuccessState extends ChapterDetailState {
  final String fontFamily;
  const ChangeFontFamilySuccessState({required this.fontFamily});
  @override
  List<Object> get props => [identityHashCode(this), fontFamily];
}

class ChangeFontColorSuccessState extends ChapterDetailState {
  final Color colortext;
  const ChangeFontColorSuccessState({required this.colortext});
  @override
  List<Object> get props => [identityHashCode(this), colortext];
}

class ChangeBackgroundSuccessState extends ChapterDetailState {
  final String background;
  const ChangeBackgroundSuccessState({required this.background});
  @override
  List<Object> get props => [identityHashCode(this), background];
}
