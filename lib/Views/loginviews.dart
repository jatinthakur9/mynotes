import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: "  Enter you email "),
        ),
        TextField(
          controller: _password,
          obscureText: false,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: "  Enter you password  "),
        ),
        TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == "user-not-found") {
                  print("User not found ");
                } else if (e.code == 'wrong-password') {
                  print("Wrong password");
                }
                 else {
                  print(e.code);
                }
              }
            },
            child: const Text('Log in  ')),
            TextButton(onPressed: () {
              
            },
            
            child:const  Text("If not registered then register here"))
      ],
    );
  }
}
