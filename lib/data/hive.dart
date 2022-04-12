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

  static setFirstName(String firstName) => userBox().put('firstname', firstName);
  static String? get firstName => userBox().get('firstname');

  static setLastName(String lastName) => userBox().put('lastname', lastName);
  static String? get lastName => userBox().get('lastname');

  static setEmail(String email) => userBox().put('email', email);
  static String? get customerEmail => userBox().get('email');

  static setPhone(String phone) => userBox().put('phone', phone);
  static String? get customerPhone => userBox().get('phone');

}


