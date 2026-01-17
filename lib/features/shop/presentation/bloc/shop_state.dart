import 'package:equatable/equatable.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopSyncInProgress extends ShopState {}

class ShopSyncSuccess extends ShopState {}

class ShopSyncFailure extends ShopState {
  final String message;
  const ShopSyncFailure(this.message);

  @override
  List<Object> get props => [message];
}
