import 'package:authetication/custombutton/round_button.dart';
import 'package:authetication/posts/postscreen.dart';
import 'package:authetication/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationID;
  const VerifyCodeScreen({Key? key, required this.verificationID})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verifyCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              "Enter Your OTP",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: verifyCodeController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.brown,
                  ),
                ),
                prefixIcon: Icon(Icons.phone_android_outlined),
                hintText: 'Enter Your 6 Digit Code',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter OTP';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Get OTP',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: verifyCodeController.text.toString(),
                  );

                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostScreen(),
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(
                      e.toString(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
