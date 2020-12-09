import 'package:flutter/material.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Payment Method'),
      ),
      body: ListView(
        children: [
          new ListTile(
            title: new Text("Credit Card"),
            // trailing: new Icon(Icons.credit_card),
            leading: new Icon(Icons.credit_card),
            onTap: () {
              Navigator.pushNamed(context, '/AddCardScreen');
            },
          ),
        ],
      ),
    );
  }
}
