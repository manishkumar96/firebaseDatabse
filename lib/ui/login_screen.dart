import 'package:firebase_database/bloc/login_bloc.dart';
import 'package:firebase_database/firebase/firebase_methods.dart';
import 'package:firebase_database/resource_helper/color_helper.dart';
import 'package:firebase_database/resource_helper/dimens_helper.dart';
import 'package:firebase_database/resource_helper/string_helper.dart';
import 'package:firebase_database/ui/home_screen.dart';
import 'package:firebase_database/ui/sign_up_screen.dart';
import 'package:firebase_database/widget/plain_text.dart';
import 'package:firebase_database/widget/text_field_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  void dispose() {
    loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(DimensHelper.twenty),
                    child: Column(
                      children: <Widget>[
                        email(),
                        password(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: loginButton()),
                            Expanded(child: registerButton()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: const Center(
          child: Text(
        StringHelper.login,
        style: TextStyle(
            color: ColorHelper.colorBlack, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  email() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder(
          stream: loginBloc.emailStream,
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
                        text: StringHelper.email,
                        textAlign: TextAlign.start,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFieldScreen(
                      obscure: false,
                      onChangedValue: loginBloc.emailChanged,
                      textEditingController: emailEditingController,
                      errorText: snapshot.error,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  password() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder(
          stream: loginBloc.passwordStream,
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
                        text: StringHelper.password,
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFieldScreen(
                      textEditingController: passwordEditingController,
                      onChangedValue: loginBloc.passwordChanged,
                      errorText: snapshot.error,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  loginButton() {
    return StreamBuilder(
        stream: loginBloc.loginCheck,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              if (snapshot.hasData) {
                userLogin();
                print("user login");
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: DimensHelper.twenty),
              child: const PlainText(
                text: StringHelper.login,
                textAlign: TextAlign.center,
                textStyle:
                    TextStyle(fontSize: 20.0, color: ColorHelper.colorBlack),
              ),
            ),
          );
        });
  }

  registerButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
      },
      child: Container(
        margin: const EdgeInsets.only(top: DimensHelper.twenty),
        child: const PlainText(
          text: StringHelper.register,
          textAlign: TextAlign.center,
          textStyle: TextStyle(fontSize: 20.0, color: ColorHelper.colorBlack),
        ),
      ),
    );
  }

  void userLogin() {
    logIn(emailEditingController.text.toString(),
            passwordEditingController.text.toString())
        .then((user) {
      if (user != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successful")));
        Navigator.push(context, MaterialPageRoute(builder: (_) =>const HomeScreen()));      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
    });
  }
}
