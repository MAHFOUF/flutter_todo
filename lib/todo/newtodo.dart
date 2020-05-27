import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewToDo extends StatefulWidget {
  @override
  _NewToDoState createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  var _key = GlobalKey<FormState>();
  TextEditingController _todoController = TextEditingController();
  bool _autoValidation = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _todoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New ToDo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _saveTodo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _isLoading ? _loading(context) : _form(context),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _todoController,
                decoration: InputDecoration(
                    hintText: 'Enter Todo'
                ),
              ),

            ],
          )),
    );
  }

  Widget _loading(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _saveTodo() async {
    if (!_key.currentState.validate()) {
      setState(() {
        _autoValidation = true;
      });
    } else {
      setState(() {
        _isLoading = true;
      });

      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance.collection('todos').document().setData({
          'body': _todoController.text,
          'done':false,
          'user_id': user.uid,
        }).then((_) {
          Navigator.of(context).pop();
        });
      });
    }
  }
}

