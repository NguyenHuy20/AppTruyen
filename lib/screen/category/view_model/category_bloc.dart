import 'dart:convert';

import 'package:apptruyen/repo/category_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/category_model.dart';
import '../../../core/environment_config.dart';
import 'package:http/http.dart' as http;

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryData> lstCategory = [];
  CategoryBloc() : super(CategoryInitial()) {
    on<GetAllCategoryEvent>(_getAllCategory);
  }
  final categoryRepo = CategoryRepo();
  Future<void> _getAllCategory(
      GetAllCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      var response = await categoryRepo.getCategory();
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        lstCategory =
            responseData.map((data) => CategoryData.fromJson(data)).toList();
        emit(GetListCategorySuccessState(lstCateGory: lstCategory));
        return;
      }
      emit(GetListCategoryFailState());
    } catch (ex) {
      emit(GetListCategoryFailState());
    }
  }
}
