import 'dart:async';

import 'package:apptruyen/model/category_model.dart';
import 'package:apptruyen/screen/category/view_model/category_bloc.dart';
import 'package:apptruyen/screen/category_detail/ui/category_detail_screen.dart';
import 'package:apptruyen/share/utils/utils.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryBloc categoryBloc;
  StreamController<List<CategoryData>> categoryStreamContrller =
      StreamController<List<CategoryData>>();
  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context)
      ..add(GetAllCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is GetListCategorySuccessState) {
            categoryStreamContrller.add(state.lstCateGory);
            return;
          }
          if (state is GetListCategoryFailState) {
            categoryStreamContrller.addError('');
            return;
          }
        },
        child: StreamBuilder<List<CategoryData>>(
            stream: categoryStreamContrller.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 50,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardCategory(snapshot.data![index]);
                    },
                  );
                }
                return Image.asset('assets/images/empty_data.webp');
              }
              if (snapshot.hasError) {
                return Image.asset('assets/images/error.webp');
              }
              return cupertinoLoading(color: Colors.grey);
            }));
  }

  Widget cardCategory(CategoryData data) => GestureDetector(
        onTap: () => goToScreen(
            context,
            CategoryDetailScreen(
                id: data.id ?? 0, categoryName: data.name ?? ''),
            type: ToScreenType.nomal),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50),
          child: Center(
            child: Text(
              data.name ?? '',
              style:
                  appStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}
