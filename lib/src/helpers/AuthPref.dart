import 'package:shared_preferences/shared_preferences.dart';

class AuthPref {
  final String key = 'auth_user';

  void saveAuth(User user) async {
    final pref = await SharedPreferences.getInstance();
    final model =
        '${user.firstName}!*&${user.lastname}!*&${user.path}!*&${user.id}';
    await pref.setString(key, model);
  }

  Future<User?> getAuth() async {
    final pref = await SharedPreferences.getInstance();
    String? user = pref.getString(key);
    if (user != null) {
      try {
        List<String> list = user.split('!*&');
        return User(
            firstName: list[0], lastname: list[1], path: list[2], id: list[3]);
      } catch (e) {}
    }
    return null;
  }

  Future<void> removeAuth() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}

class User {
  final String firstName;
  final String lastname;
  final String path;
  final String id;

  const User({
    required this.firstName,
    required this.lastname,
    required this.path,
    required this.id,
  });
}
