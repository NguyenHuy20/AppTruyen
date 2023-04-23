import 'dart:async';

import 'package:apptruyen/model/story_by_category_model.dart';
import 'package:apptruyen/share/values/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../share/utils/utils.dart';
import '../view_model/category_detail_bloc.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen(
      {super.key, required this.id, required this.categoryName});
  final int id;
  final String categoryName;
  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late CategoryDetailBloc categoryDetailBloc;
  StreamController<List<StoryByCategory>> storyStreamController =
      StreamController<List<StoryByCategory>>();
  final ScrollController _scrollController = ScrollController();
  bool endPage = false;

  @override
  void initState() {
    super.initState();
    categoryDetailBloc = BlocProvider.of<CategoryDetailBloc>(context)
      ..add(GetAllStoryEvent(id: widget.id.toString()));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        categoryDetailBloc
            .add(PagingStoryByCategoryEvent(id: widget.id.toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryDetailBloc, CategoryDetailState>(
        listener: (context, state) {
          if (state is GetListStorySuccessState) {
            setState(() => endPage = false);
            storyStreamController.add(state.lstStory);
            return;
          }
          if (state is GetDetailStoryFailState) {
            storyStreamController.addError('');
            return;
          }
          if (state is PagingStorySuccessState) {
            storyStreamController.add(state.lstStory);
            return;
          }
          if (state is LostPagingStoryState) {
            setState(() => endPage = true);
            return;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
                20, paddingTopPlatform(context) + 20, 20, 0),
            child: Column(children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    widget.categoryName,
                    style: titleStyle.copyWith(color: Colors.blue),
                  )
                ],
              ),
              Expanded(
                  child: StreamBuilder<List<StoryByCategory>>(
                      stream: storyStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data!.isNotEmpty
                              ? RefreshIndicator(
                                  color: Colors.blue,
                                  onRefresh: () async {
                                    categoryDetailBloc.add(GetAllStoryEvent(
                                        id: widget.id.toString()));
                                  },
                                  child: loadMore(
                                      _scrollController,
                                      ListView(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          children:
                                              snapshot.data!.map((element) {
                                            return storyCard(element);
                                          }).toList()),
                                      endPage))
                              : Image.asset('assets/images/empty_data.webp');
                        }
                        if (snapshot.hasError) {
                          return Image.asset('assets/images/error.webp');
                        }
                        return cupertinoLoading(color: Colors.grey);
                      }))
            ]),
          ),
        ));
  }

  Widget storyCard(StoryByCategory data) => GestureDetector(
        onTap: () => categoryDetailBloc
            .add(GetStoryDetailEvent(id: data.id.toString(), context: context)),
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade50),
          child: Row(children: [
            SizedBox(
                height: 80,
                width: 80,
                child: ClipOval(
                    child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: data.poster ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const CupertinoActivityIndicator(
                    radius: 10,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ))),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? '',
                    style: appStyle.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data.author ?? '',
                    style: littleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Trạng thái: ${data.status}',
                    style: littleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Cập nhật ${data.updatedDate != null ? convertTime(data.updatedDate!) : ''}',
                    style: littleStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ]),
        ),
      );
}
