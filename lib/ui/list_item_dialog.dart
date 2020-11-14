import 'package:flutter/material.dart';
import 'package:shopping_list/dbhelper.dart';
import '../models/list_items.dart';

class ItemDialog {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtQuantity = TextEditingController();
  final TextEditingController txtNote = TextEditingController();

  Widget buildDialog(
      BuildContext context,
      ListItem list,
      bool isNew,
      ) {
    DbHelper helper = DbHelper();
  }
}

