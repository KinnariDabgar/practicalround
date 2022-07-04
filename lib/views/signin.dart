import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:technource_practical_round/views/profilepage.dart';
import 'package:technource_practical_round/views/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _emailvalidate = false;
  bool _passwordvalidate = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please SignIn into your account ",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail Address",
                          errorText:
                              _emailvalidate ? 'email Can\'t Be Empty' : null,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          errorText: _passwordvalidate
                              ? 'Password Can\'t Be Empty'
                              : null,
                          suffixIcon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Text(
                        "Forgot your Password?",
                        style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () {
                setState(() {
                  emailController.text.isEmpty
                      ? _emailvalidate = true
                      : _emailvalidate = false;
                  passwordController.text.isEmpty
                      ? _passwordvalidate = true
                      : _passwordvalidate = false;
                });
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  addStringToSF();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new ProfilePage()));
                }
              },
              child: Container(
                width: w * 0.9,
                height: h * 0.08,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: w * 0.9,
              height: h * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Sign in with google",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: w * 0.1,
            ),
            RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(color: Colors.grey[500], fontSize: 20),
                    children: [
                  TextSpan(
                    text: " Sign Up",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) => new SignUp())),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
