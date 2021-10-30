import 'package:firebase_database/bloc/register_bloc.dart';
import 'package:firebase_database/firebase/firebase_methods.dart';
import 'package:firebase_database/resource_helper/color_helper.dart';
import 'package:firebase_database/resource_helper/dimens_helper.dart';
import 'package:firebase_database/resource_helper/string_helper.dart';
import 'package:firebase_database/ui/home_screen.dart';
import 'package:firebase_database/widget/plain_text.dart';
import 'package:firebase_database/widget/text_field_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final cnfPasswordEditingController = TextEditingController();
  late RegisterBloc registerBloc;

  @override
  void initState() {
    super.initState();
    registerBloc = RegisterBloc();
  }

  @override
  void dispose() {
    super.dispose();
    registerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(DimensHelper.twenty),
            child: Column(
              children: <Widget>[
                firstName(),
                lastName(),
                email(),
                password(),
                cnfPassword(),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: const Center(
          child: Text(
        StringHelper.signUp,
        style: TextStyle(
            color: ColorHelper.colorBlack, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: ColorHelper.colorBlack,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  firstName() {
    return StreamBuilder(
        stream: registerBloc.firstNameStream,
        builder: (context, snapshot) {
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DimensHelper.ten),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: PlainText(
                      text: StringHelper.firstName,
                      textAlign: TextAlign.start,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFieldScreen(
                    obscure: false,
                    onChangedValue: registerBloc.firstNameChanged,
                    textEditingController: firstNameEditingController,
                    //errorText: snapshot.error,
                    validator: (_) {
                      return snapshot.hasError ? null : "Enter First Name";
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  lastName() {
    return StreamBuilder(
        stream: registerBloc.lastNameStream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensHelper.ten),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: PlainText(
                        text: StringHelper.lastName,
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFieldScreen(
                      obscure: false,
                      onChangedValue: registerBloc.lastNameChanged,
                      textEditingController: lastNameEditingController,
                      errorText: snapshot.error,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  email() {
    return StreamBuilder(
        stream: registerBloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensHelper.ten),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: PlainText(
                        text: StringHelper.email,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFieldScreen(
                      obscure: false,
                      onChangedValue: registerBloc.emailChanged,
                      textEditingController: emailEditingController,
                      errorText: snapshot.error,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  password() {
    return StreamBuilder<Object>(
        stream: registerBloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensHelper.ten),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: PlainText(
                        text: StringHelper.password,
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFieldScreen(
                      obscure: false,
                      onChangedValue: registerBloc.passwordChanged,
                      textEditingController: passwordEditingController,
                      errorText: snapshot.error,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  cnfPassword() {
    return StreamBuilder(
        stream: registerBloc.cnfPasswordStream,
        builder: (context, snapshot) {
          return Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DimensHelper.ten),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: PlainText(
                        text: StringHelper.confirmPassword,
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFieldScreen(
                      obscure: false,
                      onChangedValue: registerBloc.cnfPasswordChanged,
                      textEditingController: cnfPasswordEditingController,
                      errorText: snapshot.error,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  button() {
    return StreamBuilder(
        stream: registerBloc.registerCheck,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              if (snapshot.hasData) {
                print("register user button");
                registerUser();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: DimensHelper.twenty),
              child: const PlainText(
                text: StringHelper.register,
                textStyle:
                    TextStyle(fontSize: 20.0, color: ColorHelper.colorBlack),
              ),
            ),
          );
        });
  }

  void registerUser() {
    createAccount(
            firstNameEditingController.text.toString(),
            lastNameEditingController.text.toString(),
            emailEditingController.text.toString(),
            passwordEditingController.text.toString())
        .then((user) {
          if(user != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("register user Successful")));
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          }
          else{
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("register user failed")));
          }
    });
  }
}
