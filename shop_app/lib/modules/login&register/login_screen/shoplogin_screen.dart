import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/const/constants.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login&register/register_screen/register_screen.dart';
import 'package:shop_app/shared/cubit/shop_login_cubit/shop_login_cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/components.dart';
import '../../../shared/cubit/shop_login_cubit/shop_login_states.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool passwordvisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => ShopLoginCubit()),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) // true ب  status  لو ال
            {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then(
                (value) {
                  token = state.loginModel.data?.token;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopLayout(),
                      ),
                      (route) => false);
                },
              );
              showToast(
                  context: context,
                  msg: state.loginModel.message!,
                  state: ToastStates.success);
            } else {
              showToast(
                  context: context,
                  msg: state.loginModel.message!,
                  state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defulttextformfiled(
                          controller: emailcontroller,
                          readOnly: false,
                          keyboardType: TextInputType.emailAddress,
                          text: 'Email Address',
                          prefixIcon: const Icon(Icons.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defulttextformfiled(
                          readOnly: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required.';
                            }
                            return null;
                          },
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          text: "Password",
                          prefixIcon: const Icon(Icons.password),
                          obscureText: passwordvisable,
                          onFieldSubmitted: (value) {
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
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
                        state is! ShopLoginLoadingState
                            ? defultButton(
                                width: double.infinity,
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                  }
                                  return null;
                                },
                                text: 'Login',
                              )
                            : const Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\tt  have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ));
                              },
                              child: const Text(
                                'Register Now',
                              ),
                            ),
                          ],
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
        },
      ),
    );
  }
}
