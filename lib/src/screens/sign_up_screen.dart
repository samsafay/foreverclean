import 'package:flutter/material.dart';
import '../blocs/login_provider.dart';
import '../screens/map_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = LoginProvider.of(context);

    return StreamBuilder(
      stream: bloc.user,
      builder: (context, snapshot) =>
          snapshot.hasData ? MapScreen() : _preAuth(bloc, context),
    );
  }

  _nameInput(bloc) {
    return StreamBuilder(
      stream: bloc.name,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: TextField(
            onChanged: bloc.changeName,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
              errorText: snapshot.error,
            ),
          ),
        );
      },
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
      stream: bloc.submitSignUpValid,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 130.0,
          ),
          child: RaisedButton(
            onPressed: snapshot.hasData ? bloc.signUpSubmit : null,
            child: Text('Sign Up'),
            color: Colors.blue,
          ),
        );
      },
    );
  }

  _preAuth(bloc, context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              _nameInput(bloc),
              _emailInput(bloc),
              _passwordInput(bloc),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: Text(
                      'By signing up, I accept the TERMS & PRIVACY POLICY'),
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
                      'Aleready have an account?',
                    ),
                    FlatButton(
                      child: Text('Sign In'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/SignInScreen');
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
}
