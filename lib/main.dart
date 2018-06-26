// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Contacts',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  static Future getContacts() async{
    print ("inside getContacts");
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return contacts.toList();
  }

  final _suggestions = getContacts();
  final _suggestion = [];

  final _saved = [];

  final _biggerFont = const TextStyle(fontSize: 18.0);
   List<Widget> children1 = [new Text("uyfkhkch")];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Contacts'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {

        if (i.isOdd) return new Row(
          children: <Widget>[

            Flexible(
          fit: FlexFit.tight ,
          child: Container(
          height: 1.0,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          )),

        Container(
          height: 16.0,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: new Text("Recent Added",
            textAlign: TextAlign.center,
          ),),
          Flexible(
            fit: FlexFit.tight,
        child:
          Container(
            height: 1.0,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ))


          ],
        );

        final index = 0;
        _suggestions.whenComplete((){
          _suggestions.asStream().forEach((var a){
              List<Contact> b = a;
              b.forEach((ele){
               ele.phones.forEach((e)=>print(e.label));
             });

          });
        });
        return new Text('aesdfe');
      },
    );
  }

  Widget _buildRow(var pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      isThreeLine: true,
    title: new Text(
        pair.asPascalCase,
        style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),

      ),
      leading:  new CircleAvatar(
        child: new Text('A'),
      ),
      subtitle: new ButtonBar(alignment: MainAxisAlignment.start,children: <Widget>[new IconButton(icon: new Icon(Icons.phone), onPressed:  () {
      setState(
            () {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        },
      );
    }, alignment: Alignment.bottomLeft,)],),


    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Hello world'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}