import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import 'screens.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'login_screen';

  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 45.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),

                CustomTextButton(
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.indigoAccent,
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      User? user =
                      await authService.loginWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text);

                      if (user != null) {
                        print(user.uid);
                        print(user.isAnonymous);

                        Navigator.pushReplacementNamed(
                            context, NavigatorScreen.id);
                      }
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('OR'),
                ),
                CustomTextButton(
                  child: const Text(
                    'Continue as Guest',
                    textAlign: TextAlign.center,
                  ),
                  color: const Color(0xFF6ebfc2),
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    UserCredential userCredential =
                        await auth.signInAnonymously();

                    if (userCredential.user != null) {
                      print(userCredential.user!.uid);
                      print(userCredential.user!.isAnonymous);

                      Navigator.pushReplacementNamed(
                          context, NavigatorScreen.id);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextButton(
                  child: const Text(
                    'Create an Account',
                    textAlign: TextAlign.center,
                  ),
                  color: const Color(0xFF6ebfc2),
                  onPressed: () =>
                      Navigator.pushNamed(context, SignUpScreen.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final Color _color;
  final Function _onPressed;
  final Widget _child;

  const CustomTextButton({
    Key? key,
    required Color color,
    required Function onPressed,
    required Widget child,
  })  : _color = color,
        _onPressed = onPressed,
        _child = child,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: _child,
        style: ElevatedButton.styleFrom(
          primary: _color,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          side: BorderSide(
            color: _color,
          ),
        ),
        onPressed: _onPressed as void Function()?,
      ),
    );
  }
}
