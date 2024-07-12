
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ktmm/resources/dialog/msg_dilog.dart';

import 'login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      MsgDialog.showMsgDialog(
          context, "", 'Password reset link sent! Check your email');
    } on FirebaseAuthException catch (e) {
      print(e);
      MsgDialog.showMsgDialog(context, "", e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
        title: const Text("Forgot Password?",
            style: TextStyle(
                fontWeight: FontWeight.bold, // Chữ in đậm
                fontSize: 20,
                color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Color(0xff333333), // Đặt màu cho nút back là trắng
          onPressed: () {
            // Xử lý sự kiện khi nhấn nút back
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width *
                2 /
                3, // Chiều rộng của container
            height: MediaQuery.of(context).size.height *
                3 /
                8, // Chiều cao của container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/forget_password.png'),
                // Đường dẫn đến ảnh
                fit: BoxFit.cover, // Đặt chế độ hiển thị ảnh
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Text("Enter your email",
                style: TextStyle(
                    fontWeight: FontWeight.bold, // Chữ in đậm
                    fontSize: 20,
                    color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: TextField(
              controller: _emailController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Container(
                      width: 50,
                      child: Image.asset("assets/images/ic_mail.png")),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                  onPressed: passwordReset,
                  child: Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
