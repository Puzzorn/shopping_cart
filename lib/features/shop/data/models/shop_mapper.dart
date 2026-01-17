import '../../../../core/database/app_database.dart' as db;
import '../../domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

extension ProductMapper on db.Product {
  Product toDomain() {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
      description: description,
    );
  }
}

extension CartItemMapper on db.CartItem {
  CartItem toDomain() {
    return CartItem(id: id, productId: productId, quantity: quantity);
  }
}
