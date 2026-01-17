import 'package:drift/drift.dart';
import 'package:dio/dio.dart';
import '../../../core/database/app_database.dart';
import '../domain/repositories/shop_repository.dart';
import '../domain/entities/product.dart' as dom;
import '../domain/entities/cart_item.dart' as dom;
import '../domain/entities/cart_item_with_product.dart' as dom;
import 'models/shop_mapper.dart';

class ShopRepositoryImpl implements ShopRepository {
  final AppDatabase _db;
  final Dio _dio;

  ShopRepositoryImpl(this._db, this._dio);

  @override
  Stream<List<dom.Product>> getProducts() {
    return _db.select(_db.products).watch().map((rows) {
      return rows.map((row) => row.toDomain()).toList();
    });
  }

  @override
  Stream<List<dom.CartItemWithProduct>> getCartItems() {
    final query = _db.select(_db.cartItems).join([
      innerJoin(
        _db.products,
        _db.products.id.equalsExp(_db.cartItems.productId),
      ),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return dom.CartItemWithProduct(
          cartItem: row.readTable(_db.cartItems).toDomain(),
          product: row.readTable(_db.products).toDomain(),
        );
      }).toList();
    });
  }

  @override
  Future<void> addToCart(dom.Product product) async {
    final cartItem = await (_db.select(
      _db.cartItems,
    )..where((tbl) => tbl.productId.equals(product.id))).getSingleOrNull();

    if (cartItem != null) {
      await _db
          .update(_db.cartItems)
          .replace(cartItem.copyWith(quantity: cartItem.quantity + 1));
    } else {
      await _db
          .into(_db.cartItems)
          .insert(
            CartItemsCompanion.insert(
              productId: product.id,
              quantity: const Value(1),
            ),
          );
    }
  }

  @override
  Future<void> removeFromCart(dom.CartItem item) async {
    if (item.quantity > 1) {
      // Need to find the Drift object or just update by ID.
      // Since 'item' is a Domain object, we don't have the 'copyWith' from Drift.
      // Easiest is to just issue an update query.

      await (_db.update(_db.cartItems)..where((tbl) => tbl.id.equals(item.id)))
          .write(CartItemsCompanion(quantity: Value(item.quantity - 1)));
    } else {
      await (_db.delete(
        _db.cartItems,
      )..where((tbl) => tbl.id.equals(item.id))).go();
    }
  }

  @override
  Future<void> syncProducts() async {
    try {
      final response = await _dio.get('/products');
      final List<dynamic> data = response.data;

      await _db.batch((batch) {
        // Optional: clear old products if needed, but upsert is better for offline-first
        // batch.deleteWhere(_db.products, (row) => const Constant(true));

        for (final item in data) {
          batch.insert(
            _db.products,
            ProductsCompanion.insert(
              id: Value(item['id']),
              name: item['title'],
              price: (item['price'] as num).toDouble(),
              imageUrl: item['image'],
              description: Value(item['description'] as String?),
              category: item['category'] as String,
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
    } catch (e) {
      // Handle error (e.g., no internet), just return to use local data
      // debugPrint('Sync failed: $e');
      rethrow;
    }
  }
}
