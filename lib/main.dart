import 'package:flutter/material.dart';
import 'dbhelper.dart';
import './models/list_items.dart';
import './models/shopping_list.dart';
import './ui/items_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoppping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Shopping List'),
          ),
          body: ShList()),
    );
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  List<ShoppingList> shoppingList;

  @override
  Widget build(BuildContext context) {
    showData();
    return ListView.builder(
      itemCount: (shoppingList != null) ? shoppingList.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(shoppingList[index].name),
          leading: CircleAvatar(child: Text(shoppingList[index].priority.toString()),),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){},
            ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemsScreen(shoppingList[index])),
            );},
        );
      },
    );
  }

  Future showData() async {
    DbHelper helper = DbHelper();
    await helper.openDb();
    shoppingList = await helper.getLists();
    setState(() {
      shoppingList = shoppingList;
    });
  }
}
