import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  late SharedPreferences prefs;

  String _agentfullName = "";
  String _login = "";
  bool _loggedIn = false;

  String? get agentfullName => _agentfullName;
  String? get login => _login;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    _agentfullName = prefs.getString('agentfullName') ?? '';
    _login = prefs.getString('login') ?? '';
    _loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  Future<void> signin(String agentfullName, String login) async {
    _agentfullName = agentfullName;
    _login = login;
    _loggedIn = true;
    await prefs.setString('agentfullName', _agentfullName);
    await prefs.setString('login', _login);
    await prefs.setBool('loggedIn', _loggedIn);
  }

  Future<void> signout() async {
    _agentfullName = '';
    _login = '';
    _loggedIn = false;
    await prefs.setString('agentfullName', _agentfullName!);
    await prefs.setString('login', _login!);
    await prefs.setBool('loggedIn', _loggedIn);
  }
}
