import 'package:flutter/material.dart';
import 'package:udemy2/shared/components/components.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;
  Icon passwordVisibleIcon = Icon(Icons.visibility);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  DefaultFormField(
                    controller: emailController,
                    prefixIcon: Icon(Icons.email),
                    text: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "The email address must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  DefaultFormField(
                    controller: passwordController,
                    text: "Password",
                    isPassword: !isPasswordVisible,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: passwordVisibleIcon,
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                          isPasswordVisible
                              ? passwordVisibleIcon = Icon(Icons.visibility_off)
                              : passwordVisibleIcon = Icon(Icons.visibility);
                          ;
                        });
                      },
                    ),
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DefaultButton(
                      text: "login",
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don\'t have an account?"),
                      TextButton(onPressed: () {}, child: Text("Register Now"))
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
