import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technource_practical_round/views/splashscreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _MyAppProfilePageState createState() => _MyAppProfilePageState();
}

class _MyAppProfilePageState extends State<ProfilePage> {
  Future<Profile>? profile;

  @override
  void initState() {
    super.initState();
    profile = fetchProfile();
  }

  removevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder<Profile>(
          future: profile,
          builder: (context, abc) {
            if (abc.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                      GestureDetector(
                        onTap: () {
                          removevalue();
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new SplashScreen()));
                        },
                        child: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        radius: 60,
                        backgroundImage:
                            NetworkImage(abc.data!.profilePic.toString()),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome,",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            abc.data!.name.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            abc.data!.emailId.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            } else if (abc.hasError) {
              return Text("${abc.error}");
            }

            // By default, it show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<Profile> fetchProfile() async {
  final String ProfileURL =
      "https://mocki.io/v1/8d9f9e24-20cc-47c4-b698-bb0864137daa";
  final response = await http.get(Uri.parse(ProfileURL));

  if (response.statusCode == 200) {
    // If the call to the server was successful (returns OK), parse the JSON.
    return Profile.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load profile');
  }
}

class Profile {
  Profile({
    required this.profilePic,
    required this.name,
    required this.emailId,
  });

  String profilePic;
  String name;
  String emailId;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profilePic: json["profile_pic"],
        name: json["name"],
        emailId: json["email_id"],
      );

  Map<String, dynamic> toJson() => {
        "profile_pic": profilePic,
        "name": name,
        "email_id": emailId,
      };
}
