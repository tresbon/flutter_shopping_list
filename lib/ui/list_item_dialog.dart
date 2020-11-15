import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/dbhelper.dart';
import '../models/list_items.dart';

class ItemDialog {
  final TextEditingController listID = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtQuantity = TextEditingController();
  final TextEditingController txtNote = TextEditingController();

  Widget buildDialog(
      BuildContext context,
      ListItem list,
      bool isNew,
      ) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      listID.text = list.idList.toString();
      txtName.text = list.name;
      txtQuantity.text = list.quantity;
      txtNote.text = list.note;
    }

    return AlertDialog(
      title: Text((isNew) ? 'Create item' : 'Update item'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: listID,
              keyboardType: TextInputType.numberWithOptions(),
              maxLength: 2,
              decoration: InputDecoration(
                hintText: 'ListId',
                labelText: 'Shopping list ID',

              ),
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: 'Product name',
                labelText: 'Product name',
              ),
            ),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(
                hintText: 'Quantity',
                labelText: 'Quantity',
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                hintText: 'Note',
                labelText: 'Note',
              ),
            ),
            RaisedButton(onPressed: () {
              list.idList = int.parse(listID.text);
              list.note = txtNote.text;
              list.quantity = txtQuantity.text;
              list.name = txtName.text;
            },
            child: Text('Save'),)
          ],
        ),
      ),
    );

  }
}

