import 'package:flutter/material.dart';
import '../blocs/login_provider.dart';
import '../screens/map_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    return StreamBuilder(
      stream: bloc.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MapScreen();
        }
        return _preAuth(bloc, context);
      },
    );
  }

  Widget _preAuth(bloc, context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/infiniti.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignUpScreen');
                    },
                    minWidth: 200.0,
                    child: Text('Create Account'),
                    height: 42.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 107.0,
                              right: 10.0,
                            ),
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          'Or',
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 107.0,
                              left: 10.0,
                            ),
                            child: Container(
                              height: 1.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignInScreen');
                    },
                    minWidth: 200.0,
                    child: Text('Sign In'),
                    height: 40.0,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
