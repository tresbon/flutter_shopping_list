import 'package:flutter/material.dart';
import '../dbhelper.dart';
import '../models/shopping_list.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    return AlertDialog(
      title: Text((isNew) ? 'Create' : 'Edit'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
        ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
                controller: txtName,
                decoration: InputDecoration(
                    hintText: 'Shopping List Name',
                  labelText: "Product",
                  icon: Icon(Icons.shopping_cart),
                )
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Shopping List Priority (1-3)',
                labelText: 'Priority',
                icon: Icon(Icons.north),
              ),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: (){
                list.name = txtName.text;
                list.priority = int.parse(txtPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },),

          ],
        ),
      ),
    );
  }
}
