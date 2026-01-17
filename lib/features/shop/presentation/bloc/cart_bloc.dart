import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cart_items_usecase.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  CartBloc({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
  }) : super(CartLoading()) {
    on<LoadCartStarted>(_onLoadCartStarted);
    on<AddToCartClicked>(_onAddToCartClicked);
    on<RemoveFromCartClicked>(_onRemoveFromCartClicked);
    on<ClearCartClicked>(_onClearCartClicked);
  }

  Future<void> _onLoadCartStarted(
    LoadCartStarted event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    await emit.forEach(
      getCartItemsUseCase(),
      onData: (cartItems) {
        double totalPrice = 0;
        int totalItems = 0;

        for (var item in cartItems) {
          totalPrice += item.product.price * item.cartItem.quantity;
          totalItems += item.cartItem.quantity;
        }

        return CartLoaded(
          cartItems: cartItems,
          totalPrice: totalPrice,
          totalItemsCount: totalItems,
        );
      },
      onError: (error, stackTrace) => CartError(error.toString()),
    );
  }

  Future<void> _onAddToCartClicked(
    AddToCartClicked event,
    Emitter<CartState> emit,
  ) async {
    try {
      await addToCartUseCase(event.product);
    } catch (e) {
      // Error handling is simplified; real apps might emit a temporary error state or show a snackbar via listener
    }
  }

  Future<void> _onRemoveFromCartClicked(
    RemoveFromCartClicked event,
    Emitter<CartState> emit,
  ) async {
    try {
      await removeFromCartUseCase(event.item);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onClearCartClicked(
    ClearCartClicked event,
    Emitter<CartState> emit,
  ) async {
    // Optional: Implement if repository supports it.
    // For now, no-op or iterate to delete (inefficient, better to have repo method).
  }
}
