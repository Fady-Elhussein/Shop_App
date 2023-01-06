import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var conformpasswordcontroller = TextEditingController();
  var fnameController = TextEditingController();
  var snameController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool passwordvisable = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(  
        leading: const BackButton(
        color: Colors.black, 
      ),      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  defulttextformfiled(
                    controller: fnameController,
                     keyboardType: TextInputType.name,
                      text: 'First Name', 
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'First Name is required.';
                      }
                      return null;
                    },
                      prefixIcon: const Icon(Icons.people),
                        ),
                   const SizedBox(
                    height: 40.0,
                  ),
                  defulttextformfiled(
                    controller: snameController,
                     keyboardType: TextInputType.name,
                      text: 'Second Name', 
                      validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Second Name is required.';
                      }
                      return null;
                    },
                      prefixIcon: const Icon(Icons.people),
                        ),
                   const SizedBox(
                    height: 40.0,
                  ),
                  defulttextformfiled(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    text: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email Address is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  defulttextformfiled(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required.';
                      }
                      return null;
                    },
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    text: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    obscureText: passwordvisable,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (passwordvisable == true) {
                              passwordvisable = false;
                            } else {
                              passwordvisable = true;
                            }
                          });
                        },
                        icon: passwordvisable
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility)),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  defulttextformfiled(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Conform password ';
                      }
                      return null;
                    },
                    prefixIcon:const Icon(Icons.lock) ,
                    controller: conformpasswordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    text: "Conform Password",
                    obscureText: passwordvisable,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  defultButton(
                    width: double.infinity,
                    function: () {
                      if (formkey.currentState!.validate()) {
                        print(emailcontroller.text);
                        print(passwordcontroller.text);
                      }
                    },
                    text: 'Register',
                  ),
            
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Design By :'),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Husseiny',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}