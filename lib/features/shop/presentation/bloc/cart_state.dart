import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_with_product.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemWithProduct> cartItems;
  final double totalPrice;
  final int totalItemsCount;

  const CartLoaded({
    required this.cartItems,
    required this.totalPrice,
    required this.totalItemsCount,
  });

  @override
  List<Object?> get props => [cartItems, totalPrice, totalItemsCount];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
