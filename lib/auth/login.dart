import 'package:flutter/material.dart';
import 'package:todo/auth/registre.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(36),
            child: Column(
            children: <Widget>[
              TextFormField(
               decoration: InputDecoration(
                 hintText: 'Your Email'
               ),
        ),
              SizedBox(height:24,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              SizedBox(height: 48,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                    onPressed:(){

                    },
                    child: Text('Login'),

                ),
              ),
              SizedBox(height: 48,
              ),
              Row(
                children: <Widget>[
                  Text('Dont have an account?'),
                  FlatButton(
                      onPressed: (){Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context)=> RegisterScreen())
                      );
                      },

                      child: Text('Register'),
                  ),
                ],
              ),
        ],
        ),
        ),
      ),
    );
  }
}
