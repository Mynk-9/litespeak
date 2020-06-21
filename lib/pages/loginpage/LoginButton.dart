import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final Future<bool> Function() clickResultFunction;
  final String loginText;
  final String processCompletionMessage;
  final String processFailMessage;

  LoginButton(this.clickResultFunction,
      {this.loginText = "Login",
      this.processCompletionMessage = "Operation Complete!",
      this.processFailMessage = "Error!"});

  @override
  _LoginButtonState createState() => _LoginButtonState(clickResultFunction,
      loginText: loginText,
      processCompletionMessage: processCompletionMessage,
      processFailMessage: processFailMessage);
}

class _LoginButtonState extends State<LoginButton> {
  final Future<bool> Function() clickResultFunction;
  final String loginText;
  final String processCompletionMessage;
  final String processFailMessage;

  String _buttonText;

  _LoginButtonState(this.clickResultFunction,
      {this.loginText, this.processCompletionMessage, this.processFailMessage});

  bool _processing = false;
  void toggleProcessingState() {
    setState(() {
      _processing = !_processing;
    });
  }

  void setProcessMessage({bool success = false}) {
    setState(() {
      if (success)
        _buttonText = processCompletionMessage;
      else
        _buttonText = processFailMessage;
    });
  }

  void autoResetter() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _buttonText = loginText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async { 
        // bool result;
        toggleProcessingState();
        await clickResultFunction().then((result) {
          if (result == true) {
            // success
            toggleProcessingState();
            setProcessMessage(success: true);
          } else {
            toggleProcessingState();
            setProcessMessage(success: false);
          }
        }).catchError((e) => print("Error at signup -- " + e.toString()));
        autoResetter();
      },
      child: _processing
          ? Transform.scale(scale: 0.5, child: CircularProgressIndicator())
          : Text(
              _buttonText == null ? loginText : _buttonText,
              style: TextStyle(),
            ),
      // splashColor: Colors.tealAccent,
      // color: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
