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
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
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
                              ? passwordVisibleIcon = Icon(Icons.visibility_off)
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
                defaultButton(
                    text: "login",
                    function: () {
                      print(emailController.text);
                      print(passwordController.text);
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
    );
  }
}
