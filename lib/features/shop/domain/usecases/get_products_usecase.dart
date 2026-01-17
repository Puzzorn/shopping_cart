import '../entities/product.dart';
import '../repositories/shop_repository.dart';

class GetProductsUseCase {
  final ShopRepository repository;

  GetProductsUseCase(this.repository);

  Stream<List<Product>> call() {
    return repository.getProducts();
  }
}
