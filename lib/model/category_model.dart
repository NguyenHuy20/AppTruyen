
class CategoryData {
  int? id;
  String? name;
  String? slug;
  String? description;

  CategoryData({this.id, this.name, this.slug, this.description});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
    );
  }
}
