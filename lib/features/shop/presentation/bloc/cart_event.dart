import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartStarted extends CartEvent {}

class AddToCartClicked extends CartEvent {
  final Product product;

  const AddToCartClicked(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartClicked extends CartEvent {
  final CartItem item;

  const RemoveFromCartClicked(this.item);

  @override
  List<Object?> get props => [item];
}

class ClearCartClicked extends CartEvent {}
