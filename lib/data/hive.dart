import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String _userDb = "userData";


Future loadHive() async {
  var path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  await Hive.openBox(_userDb);
}


class LocalX {

  static Box<dynamic> userBox() {
    return Hive.box(_userDb);
  }

  static setId(int customerId) => userBox().put('id', customerId);
  static int? get customerId => userBox().get('id');

  static setFullName(String fullName) => userBox().put('fullname', fullName);
  static String? get fullName => userBox().get('fullname');

  static setOrganization(String organization) => userBox().put('organization', organization);
  static String? get organization => userBox().get('organization');

  static setEmail(String email) => userBox().put('email', email);
  static String? get email => userBox().get('email');

  static setPhone(String phone) => userBox().put('phone', phone);
  static String? get phone => userBox().get('phone');

  static setAddressType(String addressType) => userBox().put('addressType', addressType);
  static String? get addressType => userBox().get('addressType');

  static setAddress(String address) => userBox().put('address', address);
  static String? get address => userBox().get('address');

  static setLocality(String locality) => userBox().put('locality', locality);
  static String? get locality => userBox().get('locality');

  static setCity(String city) => userBox().put('city', city);
  static String? get city => userBox().get('city');

  static setPincode(String pincode) => userBox().put('pincode', pincode);
  static String? get pincode => userBox().get('pincode');

}


