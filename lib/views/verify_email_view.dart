import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({super.key});

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.black54,
  backgroundColor: Colors.lightBlue,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          const SizedBox(
            width: 250,
            child: Text(
                "We've sent an email to your account. Please check your email, including spam folder, so you can verify your account."),
          ),
          const Text(
              "If you haven't received a confirmation email yet, please press the button below."),
          TextButton(
            style: raisedButtonStyle,
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
            "We've sent another verification email. Please check your spam folder in your email for the following email: $email"),
        actions: [
          TextButton(
            onPressed: (() async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut().then(
                (value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
              );
            }),
            child: const Text("Ok"),
          )
        ],
      );
    }),
  );
}
