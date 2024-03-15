import 'package:hive/hive.dart';

class UserService {
  Future<void> registerUser(String email, String password) async {
    final userBox = await Hive.openBox('users');
    userBox.put(email, password);
  }

  Future<bool> isUserExists(String email) async {
    final userBox = await Hive.openBox('users');
    return userBox.containsKey(email);
  }

  Future<bool> loginUser(String email, String password) async {
    final userBox = await Hive.openBox('users');
    final savedPassword = userBox.get(email);
    return savedPassword == password;
  }

  Future<Map<String, String>> getAllUsersData() async {
    final userBox = await Hive.openBox('users');
    return userBox.toMap().cast<String, String>();
  }
}
