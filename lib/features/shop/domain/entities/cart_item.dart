import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final int productId;
  final int quantity;

  const CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, productId, quantity];
}
