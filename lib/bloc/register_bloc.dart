import 'dart:async';
import 'dart:math';

import 'package:firebase_database/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Object implements Bloc {
  final firstNameController = BehaviorSubject<String>();

  Function(String) get firstNameChanged => firstNameController.sink.add;

  Stream<String> get firstNameStream =>
      firstNameController.stream.transform(firstNameValidate);

  final firstNameValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (firstName, sink) {
    if (firstName.isEmpty) {
      sink.addError("Enter Name");
    } else {
      sink.add(firstName);
    }
  });

  final lastNameController = BehaviorSubject<String>();

  Function(String) get lastNameChanged => lastNameController.sink.add;

  Stream<String> get lastNameStream =>
      lastNameController.stream.transform(lastNameValidator);

  final lastNameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastName, sink) {
    if (lastName.isEmpty) {
      sink.addError("Enter Last name");
    } else {
      sink.add(lastName);
    }
  });

  final emailController = BehaviorSubject<String>();

  Function(String) get emailChanged => emailController.sink.add;

  Stream<String> get emailStream =>
      emailController.stream.transform(emailValidator);

  final emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Please enter a valid email');
    }
  });

  final passwordController = BehaviorSubject<String>();

  Function(String) get passwordChanged => passwordController.sink.add;

  Stream<String> get passwordStream =>
      passwordController.stream.transform(passwordValidator);

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isEmpty) {
      sink.addError("enter password");
    } else if (password.length < 6) {
      sink.addError("length must be 6");
    } else {
      sink.add(password);
    }
  });

  final cnfPasswordController = BehaviorSubject<String>();

  Function(String) get cnfPasswordChanged => cnfPasswordController.sink.add;

  Stream<String> get cnfPasswordStream => cnfPasswordController.stream
          .transform(passwordValidator)
          .doOnData((String cnf) {
        if (0 != passwordController.value.compareTo(cnf)) {
          cnfPasswordController.addError("password does not match");
        }
      });

  Stream<bool> get registerCheck => Rx.combineLatest4(
      firstNameStream,
      lastNameStream,
      emailStream,
      passwordStream,
      (firstName, lastName, email, password) => true);

  @override
  void dispose() {
    firstNameController.close();
    lastNameController.close();
    emailController.close();
    passwordController.close();
    cnfPasswordController.close();
  }
}
