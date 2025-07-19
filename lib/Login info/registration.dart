import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self/Firebase/firebase_model.dart';
import 'package:self/Login%20info/login.dart';
import 'package:self/home_screendrat.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnamecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final firstnamefield = TextFormField(
      autofocus: false,
      controller: firstnamecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your name";
        }
        return null;
      },
      onSaved: (value) => firstnamecontroller.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        hintText: 'Enter your name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final phonenumber = TextFormField(
      autofocus: false,
      controller: phonecontroller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your phone number";
        }
        return null;
      },
      onSaved: (value) => phonecontroller.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        hintText: 'Enter your phone number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter your email";
        }
        if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-z]+").hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
      onSaved: (value) => emailcontroller.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordcontroller,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your password";
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
      onSaved: (value) => passwordcontroller.text = value!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Enter a strong password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final confirmpasswordField = TextFormField(
      autofocus: false,
      controller: confirmpasswordcontroller,
      obscureText: true,
      validator: (value) {
        if (value != passwordcontroller.text) {
          return 'Password does not match';
        }
        return null;
      },
      onSaved: (value) => confirmpasswordcontroller.text = value!,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    final signupbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailcontroller.text.trim(), passwordcontroller.text.trim());
        },
        child: const Text(
          'Signup',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Image.asset('assets1/logo.png', fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 30),
                  firstnamefield,
                  const SizedBox(height: 30),
                  phonenumber,
                  const SizedBox(height: 20),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 20),
                  confirmpasswordField,
                  const SizedBox(height: 20),
                  signupbutton,
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("You have an account? ", style: TextStyle(fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                        },
                        child: const Text(
                          " Sign In",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        await postDetailFireBase(); // save extra user info in Firestore
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message ?? "Signup failed");
      } catch (e) {
        Fluttertoast.showToast(msg: "Unexpected error: $e");
      }
    }
  }

  Future<void> postDetailFireBase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    if (user != null) {
      UserModel userModel = UserModel();
      userModel.uid = user.uid;
      userModel.Email = user.email;
      userModel.Name = firstnamecontroller.text;
      userModel.Phoneno = phonecontroller.text;

      await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());

      Fluttertoast.showToast(msg: 'Welcome to Goods Gaadi');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
      );
    }
  }
}
