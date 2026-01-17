import '../entities/product.dart';
import '../entities/cart_item.dart';
import '../entities/cart_item_with_product.dart';

abstract class ShopRepository {
  Stream<List<Product>> getProducts();
  Stream<List<CartItemWithProduct>> getCartItems();
  Future<void> addToCart(Product product);
  Future<void> removeFromCart(CartItem item);
  Future<void> syncProducts();
}
