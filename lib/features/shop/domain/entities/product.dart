import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, price, imageUrl, category, description];
}
