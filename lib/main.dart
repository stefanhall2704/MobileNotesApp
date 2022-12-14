import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'My Notes',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(),
    ),
  );
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final currentUser = FirebaseAuth.instance.currentUser;
              // if (currentUser == null) {
              //   return const LoginView();
              // } else if (currentUser.emailVerified == false) {
              //   return const VerifiyEmailView();
              // } else if (currentUser.emailVerified == true) {
              //   return const HomePage();
              // } else {
              //   return const RegistrationView();
              // }
              // if (currentUser?.emailVerified ?? false) {
              //   return const Text('Verified');
              // } else {
              //   return const VerifiyEmailView();
              // }
              return const LoginView();
            default:
              return const Text(
                'Thanks for your Patience!',
              );
          }
        },
      ),
    );
  }
}

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({super.key});

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Send Email Verification'),
        TextButton(
          style: raisedButtonStyle,
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text('Send Email Verification'),
        )
      ],
    );
  }
}
