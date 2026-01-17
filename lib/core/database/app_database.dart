import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Products, CartItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedData();
      },
    );
  }

  Future<void> _seedData() async {
    await batch((batch) {
      batch.insertAll(products, [
        ProductsCompanion.insert(
          name: 'Smartphone X',
          price: 999.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Phone',
          category: 'Electronics',
          description: const Value('High-end smartphone with amazing camera.'),
        ),
        ProductsCompanion.insert(
          name: 'Laptop Pro',
          price: 1299.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Laptop',
          category: 'Electronics',
          description: const Value('Powerful laptop for professionals.'),
        ),
        ProductsCompanion.insert(
          name: 'Wireless Headphones',
          price: 199.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Headphone',
          category: 'Accessories',
          description: const Value('Noise-cancelling wireless headphones.'),
        ),
        ProductsCompanion.insert(
          name: 'Smart Watch',
          price: 299.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Watch',
          category: 'Electronics',
          description: const Value('Stay connected with this smart watch.'),
        ),
        ProductsCompanion.insert(
          name: 'Running Shoes',
          price: 89.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Shoes',
          category: 'Fashion',
          description: const Value('Comfortable running shoes for daily use.'),
        ),
        ProductsCompanion.insert(
          name: 'Leather Jacket',
          price: 150.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Jacket',
          category: 'Fashion',
          description: const Value('Stylish leather jacket.'),
        ),
        ProductsCompanion.insert(
          name: 'Coffee Maker',
          price: 49.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Coffee',
          category: 'Home',
          description: const Value('Brew delicious coffee at home.'),
        ),
        ProductsCompanion.insert(
          name: 'Desk Chair',
          price: 120.0,
          imageUrl: 'https://placehold.co/400x400/png?text=Chair',
          category: 'Home',
          description: const Value('Ergonomic desk chair.'),
        ),
      ]);
    });
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
