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
  Icon passwordVisibleIcon = Icon(Icons.remove_red_eye);
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
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'The email address must not be empty.';
                  //     }
                  //     return null;
                  //   },
                  //   controller: emailController,
                  //   keyboardType: TextInputType.emailAddress,
                  //   onFieldSubmitted: (value) {
                  //     print(value);
                  //   },
                  //   onChanged: (value) {
                  //     print(value);
                  //   },
                  //   decoration: InputDecoration(
                  //     labelText: 'Email Address',
                  //     border: OutlineInputBorder(),
                  //     prefixIcon: Icon(Icons.email),
                  //   ),
                  // ),
                  DefaultFormField(
                    controller: emailController,
                    text: "Email",
                    validate: (p0) {
                      if (p0!.isEmpty) {
                        return "email is empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: passwordVisibleIcon,
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                            // if (isPasswordVisible) {
                            //   passwordVisibleIcon = Icon(Icons.visibility_off);
                            // } else {
                            //   passwordVisibleIcon = Icon(Icons.visibility);
                            // }
                            isPasswordVisible
                                ? passwordVisibleIcon =
                                    Icon(Icons.visibility_off)
                                : passwordVisibleIcon = Icon(Icons.visibility);
                            ;
                          });
                        },
                      ),
                    ),
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
