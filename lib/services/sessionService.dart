import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  late SharedPreferences prefs;

  String _id = "";
  String _login = "";
  bool _loggedIn = false;

  String? get id => _id;
  String? get login => _login;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('id') ?? '';
    _login = prefs.getString('login') ?? '';
    _loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  Future<void> signin(String id, String login) async {
    _id = id;
    _login = login;
    _loggedIn = true;
    await prefs.setString('id', _id);
    await prefs.setString('login', _login);
    await prefs.setBool('loggedIn', _loggedIn);
  }

  Future<void> signout() async {
    _id = '';
    _login = '';
    _loggedIn = false;
    await prefs.setString('id', _id);
    await prefs.setString('login', _login);
    await prefs.setBool('loggedIn', _loggedIn);
  }
}
