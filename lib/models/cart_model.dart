import './models.dart';

class CartModel {
  int? id;
  ProductModel? product;
  int? quantity;

  CartModel({this.id, this.product, this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null
        ? new ProductModel.fromJson(json['product'])
        : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }

  double getTotalPrice() {
    return product!.price! * quantity!;
  }
}
