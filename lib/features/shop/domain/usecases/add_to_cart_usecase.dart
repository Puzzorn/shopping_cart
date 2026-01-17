import '../entities/product.dart';
import '../repositories/shop_repository.dart';

class AddToCartUseCase {
  final ShopRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(Product product) async {
    await repository.addToCart(product);
  }
}
