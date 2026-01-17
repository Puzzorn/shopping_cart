import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_state.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_bloc.dart';
import '../../domain/entities/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'package:shopping_cart/l10n/generated/app_localizations.dart';
import '../../../../core/theme/app_dimens.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ShopBloc>().add(ShopProductsRefreshed());
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(l10n.discover),
              floating: true,
              centerTitle: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              titleTextStyle: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              actions: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.push('/cart');
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.black,
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        int count = 0;
                        if (state is CartLoaded) {
                          count = state.totalItemsCount;
                        }
                        if (count == 0) return const SizedBox.shrink();
                        return Positioned(
                          right: AppDimens.spacingS,
                          top: AppDimens.spacingS,
                          child: Container(
                            padding: const EdgeInsets.all(AppDimens.spacingXS),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: AppDimens.iconSmall,
                              minHeight: AppDimens.iconSmall,
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(width: AppDimens.spacingS),
              ],
            ),
            StreamBuilder<List<Product>>(
              stream: sl<ShopRepository>().getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return SliverPadding(
                    padding: const EdgeInsets.all(AppDimens.spacingM),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = products[index];
                        return ProductCard(product: product);
                      }, childCount: products.length),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65, // Adjusted for taller cards
                            crossAxisSpacing: AppDimens.spacingM,
                            mainAxisSpacing: AppDimens.spacingM,
                          ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(l10n.error(snapshot.error.toString())),
                    ),
                  );
                }
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
