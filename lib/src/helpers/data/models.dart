class CategoryModel {
  final int id;
  final String image;
  final List<SubCategory> items;

  CategoryModel({required this.image, required this.id, required this.items});
}

class SubCategory {
  final String? image, title;
  final int? id, categoryId;
  final List<SubCategoryItem> items;

  SubCategory({
    required this.categoryId,
    required this.image,
    required this.items,
    required this.title,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'title': title,
    'image': image,
    'items': items,
  };
}

class SubCategoryItem {
  final String image, title, desc;
  final String? filePath;
  final int? id, subCategoryId;

  SubCategoryItem({
    this.subCategoryId,
    required this.image,
    this.filePath,
    required this.desc,
    required this.title,
    this.id,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'subCategoryId': subCategoryId,
    'title': title,
    'image': image,
    'filePath': filePath,
    'desc': desc,
  };
}
