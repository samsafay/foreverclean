import 'package:flutter/material.dart';

class AddCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: ListView(
        children: [
          new ListTile(
            title: new Text("Card Number"),
            // trailing: new Icon(Icons.credit_card),
            leading: new Icon(Icons.credit_card),
            onTap: () {
              Navigator.popAndPushNamed(context, '/PaymentScreen');
            },
          ),
        ],
      ),
    );
  }
}
