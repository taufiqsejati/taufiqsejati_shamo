import 'package:shamo/models/category_model.dart';
import 'package:shamo/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  double? price;
  String? description;
  String? tags;
  int? categoriesId;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel? category;
  List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.tags,
    this.categoriesId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.galleries,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = double.parse(json['price'].toString());
    description = json['description'];
    tags = json['tags'];
    categoriesId = json['categories_id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    category = json['category'] != null
        ? new CategoryModel.fromJson(json['category'])
        : null;
    if (json['galleries'] != null) {
      galleries = <GalleryModel>[];
      json['galleries'].forEach((v) {
        galleries!.add(new GalleryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['tags'] = this.tags;
    data['categories_id'] = this.categoriesId;
    data['created_at'] = this.createdAt.toString();
    data['updated_at'] = this.updatedAt.toString();
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.galleries != null) {
      data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UninitializedProductModel extends ProductModel {}
