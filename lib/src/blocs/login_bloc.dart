import 'package:rxdart/rxdart.dart';
import 'validator_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Object with ValidatorMixin {
  final _auth = FirebaseAuth.instance;
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // add data to stream
  get user => _auth.onAuthStateChanged;
  get name => _nameController.stream.transform(validateName);
  get email => _emailController.stream.transform(validateEmail);
  get password => _passwordController.stream.transform(validatePassword);
  get userInfo => _auth.currentUser;

  get submitSignUpValid =>
      Observable.combineLatest3(name, email, password, (n, e, p) => true);
  get submitSignInValid =>
      Observable.combineLatest2(email, password, (e, p) => true);
  // change data
  get changeName => _nameController.sink.add;
  get changeEmail => _emailController.sink.add;
  get changePassword => _passwordController.sink.add;

  // ToDo: catch error
  signUpSubmit() async {
    try {
      final validName = _nameController.value;
      final validEmail = _emailController.value;
      final validPassword = _passwordController.value;

      await _auth.createUserWithEmailAndPassword(
        email: validEmail,
        password: validPassword,
      );

      UserUpdateInfo info = new UserUpdateInfo();
      info.displayName = validName;
      info.photoUrl =
          'https://scontent.fyyz1-1.fna.fbcdn.net/v/t1.0-1/c1.158.466.466/s160x160/58947_10151535268563135_1889777217_n.jpg?_nc_cat=0&oh=6b5d55e8205ff3179f2e184825c11e45&oe=5C313514';
      await _auth.updateProfile(info);
    } catch (e) {
      print(e);
    }
  }

  signInSubmit() async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    //for nw testing
    try {
      await _auth.signInWithEmailAndPassword(
        email: validEmail,
        password: validPassword,
      );
    } catch (e) {
      print(e);
    }
  }

  signOut() async {
    await _auth.signOut();
    print('you are signed out!');
  }

  dispose() {
    _nameController.close();
    _emailController.close();
    _passwordController.close();
  }
}
