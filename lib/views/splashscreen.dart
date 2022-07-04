import 'package:flutter/material.dart';
import 'package:technource_practical_round/views/profilepage.dart';
import 'package:technource_practical_round/views/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.6),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("abda",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'hind',
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        '''Watch your favorite movies or series only one platform, You can watch it anytime anywhere.''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'hind',
                            color: Colors.white,
                            fontSize: 18))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    if (prefs.getString('email') == null &&
                        prefs.getString('password') == null) {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new SignIn()));
                    } else {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ProfilePage()));
                    }
                    // Navigator.of(context).push(new MaterialPageRoute(
                    //     builder: (BuildContext context) => new SignIn()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
