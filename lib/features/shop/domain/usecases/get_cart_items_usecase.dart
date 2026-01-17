import '../entities/cart_item_with_product.dart';
import '../repositories/shop_repository.dart';

class GetCartItemsUseCase {
  final ShopRepository repository;

  GetCartItemsUseCase(this.repository);

  Stream<List<CartItemWithProduct>> call() {
    return repository.getCartItems();
  }
}
