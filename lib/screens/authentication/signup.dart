import 'package:flutter/material.dart';
import 'package:movilfinalapp/base/model.dart';
import 'package:movilfinalapp/base/view.dart';
import 'package:movilfinalapp/models/user.dart';
import 'package:movilfinalapp/shared/constants.dart';
import 'package:movilfinalapp/shared/loading.dart';
import 'package:movilfinalapp/viewmodels/signup_vm.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Form state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/kiwi.jpg'),
              )),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  key: _scaffoldKey,
                  appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      title: Text('Sign up and enjoy!',
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))),
                  body: Container(
                      margin: EdgeInsets.only(top: 140.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          emailField(),
                          SizedBox(
                            height: 20.0,
                          ),
                          passwordField(),
                          SizedBox(height: 20.0),
                          signUpButton(model),
                          SizedBox(height: 10.0),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 50.0,
                            child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(color: Colors.black)),
                                onPressed: () => widget.toggleView(),
                                child: Text('Sign in')),
                          ),
                          model.state == ViewState.Busy ? Loading() : SizedBox()
                        ]),
                      ))),
            ));
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
          hintText: 'Email',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: appColor, width: 5.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.red[400], width: 5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.red[200], width: 5.0),
          )),
      validator: (val) {
        if (val.isEmpty) {
          return 'Email cannot be empty';
        }
        return null;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.greenAccent, width: 5.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: appColor, width: 5.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.red[400], width: 5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.red[200], width: 5.0),
          )),
      validator: (val) {
        if (val.isEmpty) {
          return 'Password cannot be empty';
        }
        if (val.length < 6) {
          return 'Password cannot have less than 6 characters';
        }
        return null;
      },
    );
  }

  Widget signUpButton(SignUpViewModel model) {
    return ButtonTheme(
      minWidth: 150.0,
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.black)),
        color: appColor,
        child: Text('Sign up', style: TextStyle(color: Colors.black)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              User user = await model.signUp(
                  emailController.text, passwordController.text);
            } catch (error) {
              final snackbar = SnackBar(
                content: Text(error.message),
                backgroundColor: Colors.red,
              );
              _scaffoldKey.currentState.showSnackBar(snackbar);
            }
          }
        },
      ),
    );
  }
}
