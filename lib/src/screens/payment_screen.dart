import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: ListView(
        children: [
          new ListTile(
            title: new Text("Add Payment Method"),
            trailing: new Icon(Icons.payment),
            onTap: () {
              Navigator.pushNamed(context, '/AddPaymentMethodScreen');
            },
          ),
        ],
      ),
    );
  }
}
