import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './LoginField.dart';
import './LoginButton.dart';
import '../../components/LiteSpeakTitle.dart';
import './../mainpage/MainPage.dart';

import 'package:keyboard_visibility/keyboard_visibility.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  _LoginPage();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  // The segment is modification of code from firebase_auth package doc
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _handleSignIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
    } catch (e) {
      return null;
    }
  }

  TabController _controller;
  KeyboardVisibilityNotification _keyboardVisibility =
      KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState = false;
  void disposeKeyboardListner() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  LoginField username = LoginField(
    "Username",
    isPasswordField: false,
    validator: (value) {
      if (value.isEmpty)
        return 'Email can\'t be epmty.';
      else
        return null;
    },
    onSaved: (value) {
      value = value.trim();
    },
    useDefaultLabelColor: false,
  );
  LoginField password = LoginField(
    "Password",
    isPasswordField: true,
    useDefaultLabelColor: false,
  );
  LoginField signupField = LoginField(
    "BITS Mail",
    useDefaultLabelColor: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(98, 189, 227, 1),
      body: Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: _keyboardState
                  ? 2
                  : 4, // flex value 4 when no keyboard otherwise 2
              child: Center(
                child: LiteSpeakTitle(45.0, isAnimated: true),
              ),
            ),
            //
            Container(
              child: TabBar(
                controller: _controller,
                unselectedLabelColor: Colors.tealAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.teal,
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(50),
                ),
                tabs: <Widget>[
                  Tab(
                    text: "Signin",
                  ),
                  Tab(
                    text: "Signup",
                  ),
                ],
              ),
              // margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
            //
            Expanded(
              flex: 3,
              child: Center(
                // padding: EdgeInsets.all(2.0),
                child: TabBarView(
                  controller: _controller,
                  children: [
                    // sign in
                    // tab
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: Column(
                        children: <Widget>[
                          username,
                          SizedBox(height: 30),
                          password,
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              LoginButton(
                                () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MainPage(),
                                  //   ),
                                  // );
                                  _handleSignIn();
                                },
                              ),
                              LoginButton(
                                () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MainPage(),
                                  //   ),
                                  // );
                                },
                                loginText: "Login via Google",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // sign up
                    // tab
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
                      child: Column(
                        children: <Widget>[
                          signupField,
                          SizedBox(height: 30),
                          LoginButton(
                            () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => MainPage(),
                              //   ),
                              // );
                            },
                            loginText: "Next",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
