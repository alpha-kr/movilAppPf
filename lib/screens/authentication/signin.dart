import 'package:flutter/material.dart';
import 'package:movilfinalapp/base/model.dart';
import 'package:movilfinalapp/base/view.dart';
import 'package:movilfinalapp/models/user.dart';
import 'package:movilfinalapp/shared/constants.dart';
import 'package:movilfinalapp/shared/loading.dart';
import 'package:movilfinalapp/viewmodels/signin_vm.dart';
import 'package:transparent_image/transparent_image.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Form state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          Container(color: Colors.green),
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/kiwi.jpg'),
          ))),
          Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                title: Text('Sign in now!',
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))),
            backgroundColor: Colors.transparent,
            body: Container(
                margin: EdgeInsets.only(top: 140.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      emailField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      passwordField(),
                      SizedBox(height: 20.0),
                      signInButton(model),
                      SizedBox(height: 10.0),
                      SizedBox(height: 10.0),
                      ButtonTheme(
                        minWidth: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () => widget.toggleView(),
                            child: Text('Sign up',
                                style: TextStyle(fontSize: 18.0))),
                      ),
                      SizedBox(height: 10.0),
                      model.state == ViewState.Busy ? Loading() : SizedBox()
                    ]),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
          hintText: 'Email',
          prefixIcon: Icon(Icons.email),
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
          prefixIcon: Icon(Icons.vpn_key),
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

  Widget signInButton(SignInViewModel model) {
    return ButtonTheme(
      minWidth: 150.0,
      height: 50.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: appColor,
        child: Text('Sign in',
            style: TextStyle(color: Colors.black, fontSize: 18.0)),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              User user = await model.signIn(
                  emailController.text, passwordController.text);
            } catch (error) {
              print(error.toString());
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
