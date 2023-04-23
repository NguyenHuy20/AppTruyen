part of 'chapter_detail_bloc.dart';

abstract class ChapterDetailEvent extends Equatable {
  const ChapterDetailEvent();
  @override
  List<Object> get props => [];
}

class ShowDialogEditTextEvent extends ChapterDetailEvent {
  final BuildContext context;
  final FontSize? fontSize;
  final String fontFamily;
  final Color colorText;
  final String bgImage;
  final ChapterDetailBloc chapterDetailBloc;
  const ShowDialogEditTextEvent(
      {required this.context,
      required this.bgImage,
      required this.colorText,
      required this.fontFamily,
      required this.chapterDetailBloc,
      this.fontSize});
  @override
  List<Object> get props => [];
}

class ChangeFontSizeEvent extends ChapterDetailEvent {
  final FontSize? fontSize;
  const ChangeFontSizeEvent({required this.fontSize});
  @override
  List<Object> get props => [];
}

class ChangeFontFamilyEvent extends ChapterDetailEvent {
  final String fontFamily;
  const ChangeFontFamilyEvent({required this.fontFamily});
  @override
  List<Object> get props => [];
}

class ChangeFontColorEvent extends ChapterDetailEvent {
  final Color colorText;
  const ChangeFontColorEvent({required this.colorText});
  @override
  List<Object> get props => [];
}

class ChangeBackgroundEvent extends ChapterDetailEvent {
  final String background;
  const ChangeBackgroundEvent({required this.background});
  @override
  List<Object> get props => [];
}
