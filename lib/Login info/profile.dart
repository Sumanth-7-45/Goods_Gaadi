import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self/Firebase/firebase_model.dart';
import 'package:self/Login%20info/login.dart';
class logout extends StatefulWidget {
  const logout({super.key});

  @override
  State<logout> createState() => _logState();
}

class _logState extends State<logout> {
  User? user= FirebaseAuth.instance.currentUser;
  UserModel logged =UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value) {
      this.logged = UserModel.fromMap(value.data());
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets1/logo.png',fit: BoxFit.contain,),
            Material(
                elevation: 10,
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,

                  onPressed: (){
                    logout(context);
                  },
                  child: const Text('Log Out',style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),textAlign: TextAlign.center,
                  ),)
            ),
          ],
        ),
      ),
    );
  }
  Future<void> logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
  }
}

