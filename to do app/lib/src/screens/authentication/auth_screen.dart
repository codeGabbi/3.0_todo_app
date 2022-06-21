import 'package:chat_app_demo/service_locators.dart';
import 'package:chat_app_demo/src/controllers/auth_controller.dart';
import 'package:chat_app_demo/src/controllers/navigation/navigation_service.dart';
import 'package:chat_app_demo/src/screens/authentication/registration_screen.dart';
import 'package:chat_app_demo/src/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  static const String route = 'auth-screen';

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCon = TextEditingController(),
      _passCon = TextEditingController();
  final AuthController _authController = locator<AuthController>();

  String prompts = '';

  @override
  void initState() {
    _authController.addListener(handleLogin);
    super.initState();
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    _authController.removeListener(handleLogin);
    super.dispose();
  }

  handleLogin() {
    if (_authController.currentUser != null) {
      locator<NavigationService>().pushReplacementNamed(HomeScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          if (_authController.working) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Login',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                backgroundColor: Colors.black,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Image.asset('assets/images/todo.png',
                              height: 120, width: 200),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'To-Doh',
                            style: GoogleFonts.montserrat(
                              fontSize: 40,
                              color: const Color(0xff000912),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              onChanged: () {
                                _formKey.currentState?.validate();
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 6.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      hintText: 'Email',
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    controller: _emailCon,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    autofocus: false,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.black,
                                      contentPadding: const EdgeInsets.only(
                                          left: 14.0, bottom: 6.0, top: 8.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      hintText: 'Password',
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    controller: _passCon,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _authController.error?.message ?? '',
                          style: GoogleFonts.montserrat(color: Colors.red),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            onPressed:
                                (_formKey.currentState?.validate() ?? false)
                                    ? () {
                                        _authController.login(
                                            _emailCon.text.trim(),
                                            _passCon.text.trim());
                                      }
                                    : null,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                primary:
                                    (_formKey.currentState?.validate() ?? false)
                                        ? Colors.black
                                        : Colors.grey),
                            child: Text(
                              'Log-in',
                              style: GoogleFonts.montserrat(fontSize: 25),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegistrationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Register here',
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
