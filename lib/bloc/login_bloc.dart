import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class LoginBloc extends Object implements Bloc {
  final emailController = BehaviorSubject<String>();

  Function(String) get emailChanged => emailController.sink.add;

  Stream<String> get emailStream =>
      emailController.stream.transform(emailValidator);

  final passwordController = BehaviorSubject<String>();

  Function(String) get passwordChanged => passwordController.sink.add;

  Stream<String> get passwordStream =>
      passwordController.stream.transform(passwordValidator);

  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.isEmpty) {
      sink.addError("enter name");
    } else {
      sink.add(email);
    }
  });

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      sink.addError("enter password");
    } else {
      sink.add(password);
    }
  });

  Stream<bool> get loginCheck =>
      Rx.combineLatest2(emailStream, passwordStream, (email, password) => true);

  @override
  void dispose() {
    emailController.close();
    passwordController.close();
  }
}
