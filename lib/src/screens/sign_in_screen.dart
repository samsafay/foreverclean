import 'package:flutter/material.dart';
import '../blocs/login_provider.dart';
import '../screens/map_screen.dart';

class SignInScreen extends StatelessWidget {
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

  _preAuth(bloc, context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN IN'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              _emailInput(bloc),
              _passwordInput(bloc),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Center(
                  child: Text('Forgot Your Password?'),
                ),
              ),
              _submit(bloc),
              Padding(
                padding: const EdgeInsets.only(
                  left: 60.0,
                  top: 10.0,
                  bottom: 10.0,
                  right: 60.0,
                ),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                    ),
                    FlatButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/SignUpScreen');
                      },
                      padding: EdgeInsets.only(right: 30.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _emailInput(bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'you@example.com',
              border: OutlineInputBorder(),
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  _passwordInput(bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
            onChanged: bloc.changePassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  _submit(bloc) {
    return StreamBuilder(
      stream: bloc.submitSignInValid,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 130.0,
          ),
          child: MaterialButton(
            onPressed: snapshot.hasData ? bloc.signInSubmit : null,
            child: Text('Sign In'),
            height: 40.0,
            color: Colors.amber,
          ),
        );
      },
    );
  }
}
