import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_notes/controllers/user_controller.dart';
import 'package:student_notes/models/my_user.dart';
import 'package:student_notes/utils/my_utils.dart';
import 'package:student_notes/views/login_page.dart';
import 'package:student_notes/views/pages_container.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserController userController = UserController();
  bool isObscured = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void obscPsw() {
    setState(() => isObscured = !isObscured);
  }

  void saveUserToFirebase() async {
    MyUser userTosave = MyUser(
      name: nameController.text,
      email: emailController.text,
      password: MyUtils().hashPswd(passwordController.text),
    );

    await userController.createUser(userTosave);

    nameController.clear();
    emailController.clear();
    passwordController.clear();

    Get.back();

    Get.snackbar(
      'Information',
      "Inscription réussie",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds:1 )
    );

    Future.delayed(Duration(seconds: 1), () {
  Get.to(() => PagesContainer());
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBEEFF),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "BIENVENUE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Saisissez votre nom SVP'
                        : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Saisissez votre email SVP';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Adresse email invalide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: obscPsw,
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Saisissez votre mot de passe SVP'
                        : null,
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF2FB98B),
                      ),
                      child: Text(
                        "S'inscrire",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        saveUserToFirebase();
                        
                      } else {
                        Get.snackbar(
                          'Information',
                          "Formulaire invalide",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Déja inscrit?", style: TextStyle(fontSize: 12),),
                      SizedBox(width: 4),
                      InkWell(
                        child: Text("Connectez vous", style: TextStyle(color:Color(0xFF0A5CFF), fontSize: 12),
                        ),
                        onTap: () {
                          Get.to(() => LoginPage());
                        },
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
}
