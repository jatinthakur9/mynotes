import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


import 'package:mynotes/constants/routes.dart';

import '../utilities/show_error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page "),
      ),
      body: Column(
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
            decoration:
                const InputDecoration(hintText: "  Enter you password  "),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  if(user?.emailVerified??false){
                    //user is verified 
                     // ignore: use_build_context_synchronously
                     Navigator.of(context).pushNamedAndRemoveUntil(


                    notesRoute,
                    (route) => false,
                  );
                  }else{
                    //user is not verified 
                     // ignore: use_build_context_synchronously
                     Navigator.of(context).pushNamedAndRemoveUntil(


                    verifyEmailRoute,
                    (route) => false,
                  );
                  }

                 
                 
                } on FirebaseAuthException catch (e) {
                  if (e.code == "user-not-found") {
                    await showErrorDialog(
                      context,
                      "user-not-found",
                    );
                  } else if (e.code == 'wrong-password') {
                    await showErrorDialog(
                      context,
                      "wrong-password",
                    );
                  } else {
                    await showErrorDialog(
                      context,
                      "Error:${e.code}",
                    );
                  }
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
                
              },
              child: const Text('Log in  ')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("If not registered then register here")),

            
        ],
      ),
    );
  }
}

