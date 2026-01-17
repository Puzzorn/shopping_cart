// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'ช้อปปิ้ง';

  @override
  String get discover => 'สินค้า';

  @override
  String get cart => 'ตะกร้า';

  @override
  String get checkout => 'ไปชำระเงิน';

  @override
  String get accountSettings => 'บัญชีและการตั้งค่า';

  @override
  String get settings => 'การตั้งค่า';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get switchTheme => 'สลับระหว่างโหมดสว่างและมืด';

  @override
  String get signOut => 'ออกจากระบบ';

  @override
  String get shippingAddress => 'ที่อยู่จัดส่ง';

  @override
  String get orderSummary => 'สรุปคำสั่งซื้อ';

  @override
  String get total => 'รวมเป็นเงิน';

  @override
  String get placeOrder => 'ยืนยันคำสั่งซื้อ';

  @override
  String get orderPlaced => 'คำสั่งซื้อสำเร็จ!';

  @override
  String get cartEmpty => 'ตะกร้าว่างเปล่า';

  @override
  String error(String message) {
    return 'เกิดข้อผิดพลาด: $message';
  }

  @override
  String addedToCart(String product) {
    return 'เพิ่ม $product ลงในตะกร้าแล้ว';
  }

  @override
  String get signInToSeeAddress => 'กรุณาเข้าสู่ระบบเพื่อดูที่อยู่จัดส่ง';

  @override
  String get noAddress => 'ไม่ได้ระบุที่อยู่';

  @override
  String get languageThai => 'ภาษาไทย';

  @override
  String get statusActive => 'ใช้งานอยู่';

  @override
  String get actionSwitchToThai => 'สลับเป็นภาษาไทย';

  @override
  String get loginTitle => 'เข้าสู่ระบบ';

  @override
  String get usernameLabel => 'ชื่อผู้ใช้';

  @override
  String get usernameHint => 'กรุณากรอกชื่อผู้ใช้';

  @override
  String get passwordLabel => 'รหัสผ่าน';

  @override
  String get passwordHint => 'กรุณากรอกรหัสผ่าน';

  @override
  String get loginButton => 'เข้าสู่ระบบ';

  @override
  String qty(int quantity) {
    return 'จำนวน: $quantity';
  }

  @override
  String get description => 'รายละเอียด';

  @override
  String get noDescription => 'ไม่มีรายละเอียด';

  @override
  String get addToCartButton => 'เพิ่มลงตะกร้า';

  @override
  String get navShop => 'ร้านค้า';

  @override
  String get navCart => 'ตะกร้า';

  @override
  String get navProfile => 'โปรไฟล์';
}
