import 'package:authetication/custombutton/round_button.dart';
import 'package:authetication/screens/verify_code.dart';
import 'package:authetication/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Phone Authentication",
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
              "Enter Your Phone Number",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: phoneNumberController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.brown,
                  ),
                ),
                prefixIcon: Icon(Icons.phone_android_outlined),
                hintText: '+91 1234567890',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Password';
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
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(
                        e.toString(),
                      );
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyCodeScreen(
                            verificationID: verificationId,
                          ),
                        ),
                      );
                      setState(
                        () {
                          loading = false;
                        },
                      );
                    },
                    codeAutoRetrievalTimeout: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(
                        e.toString(),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
