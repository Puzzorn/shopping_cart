import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get appTitle;

  /// Title for the product list page
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discover;

  /// Title for the cart page
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get cart;

  /// Title for the checkout page
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// Title for the account page
  ///
  /// In en, this message translates to:
  /// **'Account & Settings'**
  String get accountSettings;

  /// Section header for settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for dark mode toggle
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Subtitle for theme toggle
  ///
  /// In en, this message translates to:
  /// **'Switch between Light and Dark themes'**
  String get switchTheme;

  /// Label for sign out button
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Section header for shipping address
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// Section header for order summary
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// Label for total price
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Label for place order button
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// Success message after placing order
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully!'**
  String get orderPlaced;

  /// Message shown when cart is empty
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty.'**
  String get cartEmpty;

  /// Error message with a placeholder
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// Message shown when product is added to cart
  ///
  /// In en, this message translates to:
  /// **'{product} added to cart'**
  String addedToCart(String product);

  /// Message shown when user is not logged in on checkout
  ///
  /// In en, this message translates to:
  /// **'Please login to see shipping address.'**
  String get signInToSeeAddress;

  /// Fallback text for missing address
  ///
  /// In en, this message translates to:
  /// **'No address provided'**
  String get noAddress;

  /// Label for the Thai language toggle
  ///
  /// In en, this message translates to:
  /// **'Thai Language'**
  String get languageThai;

  /// Status text when a setting is active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// Action text to switch to Thai language
  ///
  /// In en, this message translates to:
  /// **'Switch to Thai'**
  String get actionSwitchToThai;

  /// Title for login page
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Label for username input
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// Validation error for username
  ///
  /// In en, this message translates to:
  /// **'Please enter username'**
  String get usernameHint;

  /// Label for password input
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Validation error for password
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get passwordHint;

  /// Label for login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Quantity label
  ///
  /// In en, this message translates to:
  /// **'Qty: {quantity}'**
  String qty(int quantity);

  /// Product description header
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Fallback text for empty description
  ///
  /// In en, this message translates to:
  /// **'No description available.'**
  String get noDescription;

  /// Label for add to cart button
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCartButton;

  /// Navigation label for Shop
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// Navigation label for Cart
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// Navigation label for Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
