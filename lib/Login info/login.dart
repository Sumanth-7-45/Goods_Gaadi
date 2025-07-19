import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:self/Login%20info/registration.dart';
import 'package:self/home_screendrat.dart';
//import 'package:flutter/rendering.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey =GlobalKey <FormState> ();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  final _auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
  final emailField =TextFormField(
    autofocus: false,
    controller: emailcontroller,
    keyboardType: TextInputType.emailAddress,
    validator:(value) {
      if (value!.isEmpty){
        return("Please Enter your E-mail");
      }
      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
        return ("Please enter a valid e-mail");
      }
      return null;
    },
    onSaved: (value){
      emailcontroller.text= value!;
    },
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.mail,color: Colors.grey),
      contentPadding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        hintText: ' E-mail',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      )
    ),
  );
  final passwordField =TextFormField(
    autofocus: false,
    controller: passwordcontroller,
    obscureText: true,
    validator: (value){
      RegExp regex = new RegExp(r'^.{6,}$');
      if(value!.isEmpty){
        return("Please Enter your password ");
      }
      if(!regex.hasMatch(value))
        {
          return("Please Enter a valid password");
        }
    },
    onSaved: (value){
      passwordcontroller.text= value!;
    },
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key,color: Colors.grey,),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        )
    ),
  );

  final loginbutton = Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(30),
    color: Colors.blue,
    child: MaterialButton(
    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: (){
signIn(emailcontroller.text, passwordcontroller.text);
      },
    child: const Text('login',style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),textAlign: TextAlign.center,),),

  );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child:  Container(
             color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 150,
                  child: Image.asset('assets1/logo.png',fit: BoxFit.contain)
                  ),
                 const SizedBox(height: 30),
                  emailField,
                 const  SizedBox(height:20),
                  passwordField,
                  const SizedBox(height:20),
                  loginbutton,
                  const SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      const Text("Don't have an account? ",style: TextStyle(fontSize: 15),),
                      GestureDetector(
                        child: const Text("SignUP",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15),),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                        },
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
  void signIn(String email,String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid)=>{
            Fluttertoast.showToast(msg: "Login Sucessful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()))
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: 'Enter Your Valid e-mail or password');

      });
    }
  }
}
