import 'package:flutter/material.dart';
import 'package:simple_tracker/store/DisplayW.dart';

import 'authenticate.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent[400],
        title: Text("Sign In"),
      ),
      body: Container(
        padding:EdgeInsets.all(20),
        color: Colors.redAccent[100],
        child: Center(
          child: RaisedButton(
            child: Text("Sign In Anonymously"),
            onPressed: ()async{
                dynamic result =await _authService.signInAnony();
                if(result==null){
                  print("error signing in");
                }
                else{
                  print("user sign in successfull");
                  Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context)=>WeightsApp())
                  );
                  print(result);
                }
          },
          ),
        ),
      ),
    );
  }
}
