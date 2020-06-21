import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './LoginField.dart';
import './LoginButton.dart';
import '../../components/LiteSpeakTitle.dart';

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
        print("keyboard state changed: " + _keyboardState.toString());
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  // The segment is modification of code from firebase_auth package doc
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String firebaseAuthError = "";

  Future<FirebaseUser> _handleSignupUser(String email, String password) async {
    AuthResult result;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((res) => result = res);
    } catch (e) {
      if (e is PlatformException) {
        firebaseAuthError = e.message.toString();
        throw e;
      }
    }

    return result.user;
  }

  Future<FirebaseUser> _handleEmailSignIn(String email, String password) async {
    FirebaseUser user;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((auth) => user = auth.user)
          .catchError((onError) => throw onError);
    } catch (e) {
      if (e is PlatformException) {
        firebaseAuthError = e.message.toString();
        throw e;
      }
    }
    return user;
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
  final List<String> emailDomains = ["@goa.bits-pilani.ac.in"];
  int emailDomainsIndex = 0;

  // code picked up from api.flutter.dev
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(firebaseAuthError),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                // unselectedLabelColor: Colors.tealAccent,
                unselectedLabelColor: Theme.of(context).accentColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  // color: Colors.teal,
                  color: Theme.of(context).buttonColor,
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
                          Row(
                            children: <Widget>[
                              Expanded(child: username),
                              Expanded(
                                child: Center(
                                  child: Text(emailDomains[emailDomainsIndex]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          password,
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              LoginButton(
                                () async {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MainPage(),
                                  //   ),
                                  // );
                                  String _email = username.controller.text +
                                      emailDomains[emailDomainsIndex];
                                  String _password = password.controller.text;
                                  bool success = true;
                                  await _handleEmailSignIn(_email, _password)
                                      .catchError((e) {
                                    print('Error caught at signin: ' +
                                        e.toString());
                                    success = false;
                                    _showMyDialog();
                                  });
                                  return success;
                                },
                                processCompletionMessage:
                                    "Signed in successfully!",
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
                          Row(
                            children: <Widget>[
                              Expanded(child: username),
                              Expanded(
                                child: Center(
                                  child: Text(emailDomains[emailDomainsIndex]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          password,
                          SizedBox(height: 30),
                          LoginButton(
                            () async {
                              String _email = username.controller.text +
                                  emailDomains[emailDomainsIndex];
                              String _password = password.controller.text;
                              bool success = true;
                              await _handleSignupUser(_email, _password)
                                  .catchError((e) {
                                print(
                                    'Error caught at signup: ' + e.toString());
                                success = false;
                                _showMyDialog();
                              });
                              return success;
                            },
                            loginText: "Signup",
                            processCompletionMessage: "Signed up successfully!",
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
