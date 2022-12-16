import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({super.key});

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const Text('Send Email Verification'),
          TextButton(
            // style: raisedButtonStyle,
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification().then(
                (value) async {
                  await emailVerificationDialog(
                    context,
                    user.email,
                  );
                },
              );
            },
            child: const Text('Send Email Verification'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}

Future<void> emailVerificationDialog(BuildContext context, email) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text("Verification Email Sent"),
        content: Text(
            "Please check your spam folder in your email for the following email: $email"),
        actions: [
          TextButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child: const Text("Ok"),
          )
        ],
      );
    }),
  );
}
