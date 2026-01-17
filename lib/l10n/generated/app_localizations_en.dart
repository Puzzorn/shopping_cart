// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shopping Cart';

  @override
  String get discover => 'Discover';

  @override
  String get cart => 'Your Cart';

  @override
  String get checkout => 'Checkout';

  @override
  String get accountSettings => 'Account & Settings';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get switchTheme => 'Switch between Light and Dark themes';

  @override
  String get signOut => 'Sign Out';

  @override
  String get shippingAddress => 'Shipping Address';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get total => 'Total';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get orderPlaced => 'Order Placed Successfully!';

  @override
  String get cartEmpty => 'Your cart is empty.';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String addedToCart(String product) {
    return '$product added to cart';
  }

  @override
  String get signInToSeeAddress => 'Please login to see shipping address.';

  @override
  String get noAddress => 'No address provided';

  @override
  String get languageThai => 'Thai Language';

  @override
  String get statusActive => 'Active';

  @override
  String get actionSwitchToThai => 'Switch to Thai';

  @override
  String get loginTitle => 'Login';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Please enter username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Please enter password';

  @override
  String get loginButton => 'Login';

  @override
  String qty(int quantity) {
    return 'Qty: $quantity';
  }

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description available.';

  @override
  String get addToCartButton => 'Add to Cart';

  @override
  String get navShop => 'Shop';

  @override
  String get navCart => 'Cart';

  @override
  String get navProfile => 'Profile';
}
