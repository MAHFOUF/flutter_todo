import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/auth/login.dart';
import 'package:todo/todo/homescreen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController  _emailController=TextEditingController();
  TextEditingController  _passwordController=TextEditingController();
  TextEditingController  _confirmPasswordController=TextEditingController();
  String  _error;
  var _key=GlobalKey<FormState>();
  bool _autoValidation=false;
  bool _isLoading=false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register new Account '),

      ),
      body: _isLoading ? _loading(context) : _form(context),
    );
  }
  Widget  _form(BuildContext context){
   return SingleChildScrollView(
     child: Padding(
       padding: EdgeInsets.all(24),
       child: Form(
         autovalidate: _autoValidation ,
         key: _key,
         child: Column(
           children: <Widget>[
             TextFormField(
               controller: _emailController,
               decoration: InputDecoration(
                 hintText:'Email',
               ),
               validator: (value){
                 if(value.isEmpty){
                   return 'Email is required';
                 }
                 return null;
               },
             ),
             SizedBox(height: 24,),
             TextFormField(
               obscureText: true,
               controller: _passwordController,
               decoration: InputDecoration(
                 hintText:'Password',
               ),
               validator: (value){
                 if(value.isEmpty){
                   return 'Password is required';
                 }
                 return null;
               },
             ),
             SizedBox(height: 24,),
             TextFormField(
               obscureText: true,
               controller: _confirmPasswordController,
               decoration: InputDecoration(
                 hintText:'Confirm Password',
               ),
               validator: (value){
                 if(value.isEmpty){
                   return 'Confirmation Password is required';
                 }
                 return null;
               },
             ),
             SizedBox(height: 36,),
             Container(
               width: double.infinity,
               child:RaisedButton(
                 onPressed:_onRegisterClick,
                 child: Text('Register'),
               ) ,
             ),
             SizedBox(height:36,),
             _errorMessage(),
             Row(
               children: <Widget>[
                 Text('Have an account?'),
                 FlatButton(
                   onPressed: (){
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (context)=> LoginScreen()),
                     );
                   },
                   child: Text('Login'),
                 ),
               ],
             )

           ],
         ),
       ),
     ),
   );
  }
  Widget _loading(BuildContext context){
     return Center(
       child: CircularProgressIndicator(),
     );
  }
  void _onRegisterClick() async {
    if(!_key.currentState.validate()){
      setState(() {
        _autoValidation=true;
      });
    } else{
      setState(() {
        _isLoading=true;
        _autoValidation=false;
      });
      
      AuthResult result= await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

      if(result.user==null){
        setState(() {
          _isLoading=false;
          _error='User registration error';
        });

      } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> HomeScreen())
          );
        }
      }
    }

 Widget _errorMessage() {

    if( _error==null){
      return Container();
    }else{
      return Container(
        child: Text(_error,style: TextStyle(color: Colors.red,),),
      );
    }
  }
  }

