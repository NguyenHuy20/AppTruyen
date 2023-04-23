class StoryDetailModel {
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
  List<Raters>? raters;
  List<Ratings>? ratings;
  List<Categories>? categories;
  List<Bookmarks>? bookmarks;
  List<Comments>? comments;
  int? rateCount;
  int? rateAvg;
  Favorite? favorite;
  String? latestUpdatedDate;

  StoryDetailModel(
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
      this.deletedAt,
      this.raters,
      this.ratings,
      this.categories,
      this.bookmarks,
      this.comments,
      this.rateCount,
      this.rateAvg,
      this.favorite,
      this.latestUpdatedDate});

  StoryDetailModel.fromJson(Map<String, dynamic> json) {
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
    if (json['raters'] != null) {
      raters = <Raters>[];
      json['raters'].forEach((v) {
        raters!.add(new Raters.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['bookmarks'] != null) {
      bookmarks = <Bookmarks>[];
      json['bookmarks'].forEach((v) {
        bookmarks!.add(new Bookmarks.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    rateCount = json['rateCount'];
    rateAvg = json['rateAvg'];
    favorite = json['favorite'] != null
        ? new Favorite.fromJson(json['favorite'])
        : null;
    latestUpdatedDate = json['latestUpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (raters != null) {
      data['raters'] = raters!.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (bookmarks != null) {
      data['bookmarks'] = bookmarks!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['rateCount'] = rateCount;
    data['rateAvg'] = rateAvg;
    if (favorite != null) {
      data['favorite'] = favorite!.toJson();
    }
    data['latestUpdatedDate'] = latestUpdatedDate;
    return data;
  }
}

class Raters {
  int? id;
  String? email;
  String? name;
  List<String>? roles;
  String? avatarFilePath;
  bool? isEmailConfirmed;
  String? updatedDate;
  dynamic deletedAt;

  Raters(
      {this.id,
      this.email,
      this.name,
      this.roles,
      this.avatarFilePath,
      this.isEmailConfirmed,
      this.updatedDate,
      this.deletedAt});

  Raters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    roles = json['roles'].cast<String>();

    avatarFilePath = json['avatarFilePath'];
    isEmailConfirmed = json['isEmailConfirmed'];
    updatedDate = json['updatedDate'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['roles'] = roles;

    data['avatarFilePath'] = avatarFilePath;
    data['isEmailConfirmed'] = isEmailConfirmed;
    data['updatedDate'] = updatedDate;
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class Ratings {
  int? id;
  int? value;

  Ratings({this.id, this.value});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;
  String? description;

  Categories({this.id, this.name, this.slug, this.description});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['description'] = description;
    return data;
  }
}

class Bookmarks {
  int? id;
  String? updatedDate;

  Bookmarks({this.id, this.updatedDate});

  Bookmarks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['updatedDate'] = updatedDate;
    return data;
  }
}

class Comments {
  int? id;
  String? content;
  Null? parentId;
  String? updatedDate;
  Null? deletedAt;
  List<Replies>? replies;
  Raters? user;

  Comments(
      {this.id,
      this.content,
      this.parentId,
      this.updatedDate,
      this.deletedAt,
      this.replies,
      this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    parentId = json['parentId'];
    updatedDate = json['updatedDate'];
    deletedAt = json['deletedAt'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
    user = json['user'] != null ? new Raters.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['content'] = content;
    data['parentId'] = parentId;
    data['updatedDate'] = updatedDate;
    data['deletedAt'] = deletedAt;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Replies {
  int? id;
  String? content;
  int? parentId;
  String? updatedDate;
  Null? deletedAt;
  Raters? user;

  Replies(
      {this.id,
      this.content,
      this.parentId,
      this.updatedDate,
      this.deletedAt,
      this.user});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    parentId = json['parentId'];
    updatedDate = json['updatedDate'];
    deletedAt = json['deletedAt'];

    user = json['user'] != null ? new Raters.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['content'] = content;
    data['parentId'] = parentId;
    data['updatedDate'] = updatedDate;
    data['deletedAt'] = deletedAt;

    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Favorite {
  int? count;
  bool? isFavorite;

  Favorite({this.count, this.isFavorite});

  Favorite.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
