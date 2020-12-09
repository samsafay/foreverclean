import 'dart:async';

class ValidatorMixin {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.length > 2) {
        sink.add(name);
      } else {
        sink.addError('Name must be longer than 3 characters');
      }
    },
  );
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 3) {
        sink.add(password);
      } else {
        sink.addError('Password must be longer than 4 characters');
      }
    },
  );

  final validateBarCode = StreamTransformer<String, String>.fromHandlers(
    handleData: (barCode, sink) {
      if (barCode == "http://en.m.wikipedia.org") {
        sink.add(barCode);
      } else {
        sink.addError('barcode is different');
      }
    },
  );
}
