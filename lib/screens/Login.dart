import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:farm_sanctuary_delivery/screens/Home.dart';
import 'package:farm_sanctuary_delivery/screens/Menu.dart';
import 'package:farm_sanctuary_delivery/screens/Settings.dart';
import 'package:farm_sanctuary_delivery/services/graphqlService.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GraphQLService _graphQLService = GraphQLService();

  final _FormKey = GlobalKey<FormState>();
  final logincontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  late Image background;

  @override
  void initState() {
    super.initState();
    passwordcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool _passwordVisible = false;
  bool isLoggedIn = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
        onTap: () => {FocusManager.instance.primaryFocus?.unfocus(), setState(() {})},
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    // image: background.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.asset(
                      "assets/images/Logo_farmSanctuary_delivery-removebg-preview.png",
                      height: 280,
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                        color: Colors.white.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 10, top: 20, right: 0),
                              child: Text("Welcome Back",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xff0E4F55))),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 5, top: 0, right: 0),
                              child: Text("Use your username and password to login",
                                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black)),
                            ),
                            Form(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              key: _FormKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.person),
                                            label: Text('Login'),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                          controller: logincontroller,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Login is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(Icons.lock),
                                            label: const Text('Password'),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            suffixIcon: passwordcontroller.text.isNotEmpty
                                                ? IconButton(
                                                    icon: Icon(
                                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                                      color: Theme.of(context).primaryColorDark,
                                                    ),
                                                    onPressed: () {
                                                      // Update the state i.e. toogle the state of passwordVisible variable
                                                      setState(() {
                                                        _passwordVisible = !_passwordVisible;
                                                      });
                                                    },
                                                  )
                                                : null,
                                          ),
                                          controller: passwordcontroller,
                                          obscureText: _passwordVisible,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Password is required';
                                            }
                                            return null;
                                          },
                                        ),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ElevatedButton(
                                          child: const Text("Sign in"),
                                          onPressed: () async {
                                            if (_FormKey.currentState!.validate()) {
                                              setState(() {
                                                isLoading = true; // set isLoading state to true
                                              });
                                              isLoggedIn = await _graphQLService.login(
                                                  login: logincontroller.text, password: passwordcontroller.text);

                                              print('no validate :' + isLoggedIn.toString());
                                              setState(() {
                                                isLoading = false; // set isLoading state to false
                                              });

                                              if (isLoggedIn) {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(builder: (context) => const Menu()));
                                              } else {
                                                final snackBar = SnackBar(
                                                  /// need to set following properties for best effect of awesome_snackbar_content
                                                  elevation: 0,
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: Colors.transparent,
                                                  content: AwesomeSnackbarContent(
                                                    title: 'Oops!',
                                                    message:
                                                        'Something went wrong please make sure to use the right credentials',

                                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                    contentType: ContentType.failure,
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(snackBar);
                                              }
                                            }
                                          },
                                        ),
                                      ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
