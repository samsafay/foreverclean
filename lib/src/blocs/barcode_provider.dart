import 'package:flutter/material.dart';
import 'bar_code_bloc.dart';

class BarCodeProvider extends InheritedWidget {
  final bloc = BarCodeBloc();

  BarCodeProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static BarCodeBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BarCodeProvider)
            as BarCodeProvider)
        .bloc;
  }
}
