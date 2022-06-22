import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pap_projeto/Administrador/Lista/lista_pedidos.dart';
import 'package:pap_projeto/Administrador/Login/pic_login.dart';

import '../../settings/profile_pic.dart';

class loginpage extends StatelessWidget {


  static Future<User?> loginUsingEmailPassword({required String Email, required String Password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: Email, password: Password);
        user = userCredential.user;
        }
        on FirebaseAuthException catch(e){
            if(e.code == "administrador não encontrado"){
              print("Nenhum administrador encontrado com esse email");
          }
        }
    return user;
      }


  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
        body: Container(
          margin: EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pic_login(),
              SizedBox(height: 20),
              Text(
                "Administração",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(height: 22),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: Icon(Icons.key_rounded),
                  ),
                  obscureText: true,
                ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(Email: _emailController.text, Password: _passwordController.text, context: context);
                  print(user);
                  if(user!=null)
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => pedidos()));
                  }
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 132),
                ),
              ),
            ],
          ),
        ),
    );
  }
}