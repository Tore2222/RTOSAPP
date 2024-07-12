import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ktmm/resources/blocs/auth_bloc.dart';
import 'package:ktmm/resources/dialog/loading_dialog.dart';
import 'package:ktmm/resources/dialog/msg_dilog.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

AuthBloc authBloc = AuthBloc();

TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passController = TextEditingController();
TextEditingController _passcheckController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

@override
void dispose() {
  authBloc.dispose();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showPassword = false;
  bool showPassword1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: const BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 200, // Độ rộng tùy chỉnh tại đây
                height: 200, // Độ cao tùy chỉnh tại đây (nếu cần)
                child: Image.asset("assets/images/smart-house.png"),
              ),
              //Image.asset("assets/images/ic_fight.png"),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 6),
                child: Text(
                  "Welcome Aboard!",
                  style: TextStyle(fontSize: 22, color: Color(0xff333333)),
                ),
              ),
              const Text(
                "Signup with iHome in simple steps",
                style: TextStyle(fontSize: 16, color: Color(0xff606470)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: StreamBuilder(
                    stream: authBloc.nameStream,
                    builder: (context, snapshot) => TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelText: "Name",
                              prefixIcon: Container(
                                  width: 50,
                                  child:
                                      Image.asset("assets/images/ic_user.png")),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              StreamBuilder(
                  stream: authBloc.phoneStream,
                  builder: (context, snapshot) => TextField(
                        controller: _phoneController,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Phone Number",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            prefixIcon: Container(
                                width: 50,
                                child:
                                    Image.asset("assets/images/ic_phone.png")),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                      )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                    stream: authBloc.emailStream,
                    builder: (context, snapshot) => TextField(
                          controller: _emailController,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Email",
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              prefixIcon: Container(
                                  width: 50,
                                  child:
                                      Image.asset("assets/images/ic_mail.png")),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              StreamBuilder(
                  stream: authBloc.passStream,
                  builder: (context, snapshot) => TextField(
                        controller: _passController,
                        obscureText: true,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: "Password",
                            prefixIcon: Container(
                                width: 50,
                                child:
                                    Image.asset("assets/images/ic_lock.png")),
                            suffixIcon: IconButton(
                          icon: Icon(showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              showPassword =
                              !showPassword; // Khi nhấn vào nút, thay đổi trạng thái của biến showPassword
                            });
                          },
                        ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffCED0D2), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)))),
                      )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                    builder: (context, snapshot) => TextField(
                      controller: _passcheckController,
                      obscureText: !showPassword1,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          prefixIcon: Container(
                              width: 50,
                              child:
                              Icon(Icons.password)),
                          suffixIcon: IconButton(
                            icon: Icon(showPassword1
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                showPassword1 =
                                !showPassword1; // Khi nhấn vào nút, thay đổi trạng thái của biến showPassword
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffCED0D2), width: 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6)))),
                    ), stream: null,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                      onPressed: _onSignUpClicked,
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: RichText(
                  text: TextSpan(
                      text: "Already a User? ",
                      style: TextStyle(color: Color(0xff606470), fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            text: "Login now",
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

_onSignUpClicked() {
    if (_passController.text == _passcheckController.text) {
      var isValid = authBloc.isValid(_nameController.text,
          _emailController.text, _passController.text, _phoneController.text);

      if (isValid) {
        // create user
        // loading dialog
        LoadingDialog.showLoadingDialog(context, 'Loading...');
        authBloc.signUp(_emailController.text, _passController.text,
            _phoneController.text, _nameController.text, () {
              LoadingDialog.hideLoadingDialog(context);
              //LoadingDialog.showLoadingDialog(context, "SignIn Success");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()));
              MsgDialog.showMsgDialog(context, "", "SignUp Succces");
            }, (msg) {
              LoadingDialog.hideLoadingDialog(context);
              MsgDialog.showMsgDialog(context, "Sign-Up ", msg);

              // show msg dialog
            });
      }
    } else {
      MsgDialog.showMsgDialog(context, "", "Invalid password");
    }
  }
}
