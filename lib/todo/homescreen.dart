import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'newtodo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:_newToDo,
      ),
      body: _conTent(context),
    );
  }

 Widget _conTent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: StreamBuilder(
          stream: Firestore.instance.collection('todos').orderBy('done').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
               return _error(context, 'No connection is made');
                break;
              case ConnectionState.waiting:
               return Center(child: CircularProgressIndicator(),);
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if(snapshot.hasError){
                  return _error(context,snapshot.error.toString());
                }
                if(!snapshot.hasData){
                  return _error(context,'No Data');
                }
                return _drawScreen(context, snapshot.data);
                break;

            }
          },
      ),
    );

  }

  void _newToDo() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>NewToDo()));
  }

  Widget _error(BuildContext context, String message) {
    return Center(
      child: Text(message,
      style: TextStyle(
        color: Colors.red,
      ),
      ),
    );
  }

  Widget _drawScreen(BuildContext context, QuerySnapshot data) {
    return ListView.builder(
        itemCount: data.documents.length,
        itemBuilder: (BuildContext context, int position){
        return Card(
          child: ListTile(
            trailing: IconButton(
                onPressed: (){
                  Firestore.instance.collection('todos').document(data.documents[position].documentID).delete();
                },
                icon: Icon(
                Icons.delete,
                color:Colors.red[300]
            ),
            ),
            title: Text(data.documents[position]['body'],
            style: TextStyle(
              decoration:data.documents[position]['done'] ? TextDecoration.lineThrough: TextDecoration.none,
            ),
            ),
            leading: IconButton(
              onPressed: (){
                 Firestore.instance.collection('todos').document(data.documents[position].documentID).updateData({
                   'done':true
                 });
              },
              icon: Icon(
                Icons.assignment_turned_in,
                color: data.documents[position]['done'] ? Colors.teal:Colors.grey.shade300,
              ),
            ),

          ),
        );
        },
    );
  }
  
}
