class ChapterDetailModel {
  int? id;
  String? header;
  String? slug;
  List<String>? body;
  int? viewCount;
  String? uploadDate;
  String? updatedDate;
  dynamic deletedAt;
  Story? story;

  ChapterDetailModel(
      {this.id,
      this.header,
      this.slug,
      this.body,
      this.viewCount,
      this.uploadDate,
      this.updatedDate,
      this.deletedAt,
      this.story});

  ChapterDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    header = json['header'];
    slug = json['slug'];
    body = json['body'].cast<String>();
    viewCount = json['viewCount'];
    uploadDate = json['uploadDate'];
    updatedDate = json['updatedDate'];
    deletedAt = json['deletedAt'];
    story = json['story'] != null ? Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['header'] = header;
    data['slug'] = slug;
    data['body'] = body;
    data['viewCount'] = viewCount;
    data['uploadDate'] = uploadDate;
    data['updatedDate'] = updatedDate;
    data['deletedAt'] = deletedAt;
    if (story != null) {
      data['story'] = story!.toJson();
    }
    return data;
  }
}

class Story {
  int? id;
  String? title;
  String? author;
  String? slug;
  List<String>? description;
  String? poster;
  List<String>? categoryList;
  String? status;
  String? uploadDate;
  String? updatedDate;
  dynamic deletedAt;

  Story(
      {this.id,
      this.title,
      this.author,
      this.slug,
      this.description,
      this.poster,
      this.categoryList,
      this.status,
      this.uploadDate,
      this.updatedDate,
      this.deletedAt});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    slug = json['slug'];
    description = json['description'].cast<String>();
    poster = json['poster'];
    categoryList = json['categoryList'].cast<String>();
    status = json['status'];
    uploadDate = json['uploadDate'];
    updatedDate = json['updatedDate'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['slug'] = slug;
    data['description'] = description;
    data['poster'] = poster;
    data['categoryList'] = categoryList;
    data['status'] = status;
    data['uploadDate'] = uploadDate;
    data['updatedDate'] = updatedDate;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
