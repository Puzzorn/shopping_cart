import '../repositories/shop_repository.dart';

class SyncProductsUseCase {
  final ShopRepository repository;

  SyncProductsUseCase(this.repository);

  Future<void> call() async {
    await repository.syncProducts();
  }
}
