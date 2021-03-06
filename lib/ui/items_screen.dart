import 'package:flutter/material.dart';
import '../dbhelper.dart';
import '../models/list_items.dart';
import '../models/shopping_list.dart';
import 'list_item_dialog.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList shoppingList;

  ItemsScreen(this.shoppingList);

  @override
  _ItemsScreenState createState() => _ItemsScreenState(this.shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {
  final ShoppingList shoppingList;

  _ItemsScreenState(this.shoppingList);

  DbHelper helper;
  List<ListItem> items;
  ItemDialog dialog;

  @override
  void initState() {
    dialog = ItemDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(this.shoppingList.id);
    return Scaffold(
        appBar: AppBar(
          title: Text(shoppingList.name),
        ),
        body: ListView.builder(
            itemCount: (items != null) ? items.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index].name),
                subtitle: Text('''Quantity: ${items[index].quantity} - Note:
                    ${items[index].note}'''),
                onTap: () {},
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          dialog.buildDialog(context, items[index], false),
                    );
                  },
                ),
              );
            }));
  }

  Future showData(int idList) async {
    await helper.openDb();
    items = await helper.getItems(idList);
    setState(() {
      items = items;
    });
  }
}
