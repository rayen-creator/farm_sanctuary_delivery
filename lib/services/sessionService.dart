import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  late SharedPreferences prefs;

  late String _username;
  late String _email;
  bool _loggedIn = false;

  String get username => _username;
  String get email => _email;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    _email = prefs.getString('email') ?? '';
    _loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  Future<void> login(String username, String email) async {
    _username = username;
    _email = email;
    _loggedIn = true;
    await prefs.setString('username', _username);
    await prefs.setString('email', _email);
    await prefs.setBool('loggedIn', _loggedIn);
  }

  Future<void> logout() async {
    _username = '';
    _email = '';
    _loggedIn = false;
    await prefs.setString('username', _username);
    await prefs.setString('email', _email);
    await prefs.setBool('loggedIn', _loggedIn);
  }
}
