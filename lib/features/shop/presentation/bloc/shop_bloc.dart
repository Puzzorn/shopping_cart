import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/sync_products_usecase.dart';
import 'shop_event.dart';
import 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetProductsUseCase getProductsUseCase;
  final SyncProductsUseCase syncProductsUseCase;

  ShopBloc({
    required this.getProductsUseCase,
    required this.syncProductsUseCase,
  }) : super(ShopInitial()) {
    on<ShopProductsRefreshed>(_onShopProductsRefreshed);
  }

  Future<void> _onShopProductsRefreshed(
    ShopProductsRefreshed event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopSyncInProgress());
    try {
      await syncProductsUseCase();
      emit(ShopSyncSuccess());
    } catch (e) {
      emit(ShopSyncFailure(e.toString()));
    }
  }
}
