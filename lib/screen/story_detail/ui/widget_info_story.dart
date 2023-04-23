import 'package:apptruyen/share/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../model/story_detail_model.dart';
import '../../../share/values/style.dart';

class WidgetinfoStory extends StatelessWidget {
  const WidgetinfoStory({super.key, required this.data});
  final StoryDetailModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade50),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Tác giả: ${data.author}',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Tác giả: ${data.categoryList}',
          style: appStyle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Chương: 16',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Trạng thái: ${data.status}',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Đọc: 10',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Đề cử: ',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Đánh giá: ${data.rateCount} lượt',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Đăng: ${convertTime(data.uploadDate ?? '')}',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          'Cập nhật: ${convertTime(data.latestUpdatedDate ?? '')}',
          style: appStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ]),
    );
  }
}
