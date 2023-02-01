import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_state.dart';
import '../../../shared/components/components.dart';
import '../../shared/cubit/shop_cubit/shop_cubit.dart';

class UpdateScreen extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String userImage;

  UpdateScreen(
      {super.key,
        required this.nameController,
        required this.emailController,
        required this.phoneController,
        required this.userImage});

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is ShopSuccessUpdateProfileState) {
            showToast(context: context, msg: 'UpDate Done Successfully',state: ToastStates.success);
          }
          if (state is ShopErrorUpdateProfileState) {
            showToast(context: context, msg: 'Error on UpDate Try Later',state: ToastStates.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateProfileState)
                          const LinearProgressIndicator(
                            color: Colors.blue,
                            backgroundColor: Colors.green,
                          ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 70.0,
                              backgroundImage: NetworkImage(userImage),
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defulttextformfiled(
                          readOnly: false,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          text: 'Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required.';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.people),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        defulttextformfiled(
                          readOnly: false,
                          controller: emailController,
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
                          readOnly: false,
                          controller: phoneController,
                          keyboardType: TextInputType.name,
                          text: 'Phone',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone is required.';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        const SizedBox(
                          height: 25.0,
                        ),
                        defultButton(
                          width: double.infinity,
                          function: () {
                            if (formkey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                            }

                          },
                          text: 'Update',
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