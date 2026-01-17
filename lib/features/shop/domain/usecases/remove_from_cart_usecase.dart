import '../entities/cart_item.dart';
import '../repositories/shop_repository.dart';

class RemoveFromCartUseCase {
  final ShopRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(CartItem item) async {
    await repository.removeFromCart(item);
  }
}
