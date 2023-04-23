class StoryByCategory {
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

  StoryByCategory(
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

  StoryByCategory.fromJson(Map<String, dynamic> json) {
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
