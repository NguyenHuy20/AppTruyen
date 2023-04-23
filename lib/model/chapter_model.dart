class ChapterModel {
  int? id;
  String? header;
  String? slug;
  int? viewCount;
  String? updatedDate;
  Story? story;

  ChapterModel(
      {this.id,
      this.header,
      this.slug,
      this.viewCount,
      this.updatedDate,
      this.story});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    header = json['header'];
    slug = json['slug'];
    viewCount = json['viewCount'];
    updatedDate = json['updatedDate'];
    story = json['story'] != null ? Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['header'] = header;
    data['slug'] = slug;
    data['viewCount'] = viewCount;
    data['updatedDate'] = updatedDate;
    if (story != null) {
      data['story'] = story!.toJson();
    }
    return data;
  }
}

class Story {
  int? id;
  String? slug;

  Story({this.id, this.slug});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    return data;
  }
}
