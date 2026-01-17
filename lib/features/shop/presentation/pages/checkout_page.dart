import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import 'package:shopping_cart/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_dimens.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.checkout)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildShippingSection(l10n),
              const SizedBox(height: AppDimens.spacingL),
              _buildOrderSummarySection(l10n),
              const SizedBox(height: AppDimens.spacingL),
              _buildPlaceOrderButton(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShippingSection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.shippingAddress,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To: ${state.user.username}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimens.spacingXS),
                      Text(state.user.address ?? l10n.noAddress),
                      const SizedBox(height: AppDimens.spacingXS),
                      Text(state.user.email),
                    ],
                  );
                } else {
                  return Text(l10n.signInToSeeAddress);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummarySection(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.orderSummary,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return Column(
                    children: [
                      ...state.cartItems.map(
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(l10n.qty(item.cartItem.quantity)),
                          trailing: Text(
                            '\$${(item.product.price * item.cartItem.quantity).toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.total,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${state.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Text(l10n.cartEmpty);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context, AppLocalizations l10n) {
    return ElevatedButton(
      onPressed: () {
        // Mock Place Order
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.orderPlaced)));
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingM),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(l10n.placeOrder),
    );
  }
}
