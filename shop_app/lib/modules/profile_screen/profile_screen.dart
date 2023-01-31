import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/update_profile_screen/update_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit/shop_state.dart';

import '../../shared/cubit/shop_cubit/shop_cubit.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login&register/login_screen/shoplogin_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        String userImage ='https://cdn-icons-png.flaticon.com/512/1077/1077012.png';
        if(cubit.userModel !=null) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          CircleAvatar(
                            radius: 70.0,
                            backgroundImage: NetworkImage(userImage),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: TextButton(
                              child: const Text('Edit',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateScreen(
                                              userImage: userImage,
                                              emailController: emailController,
                                              nameController: nameController,
                                              phoneController: phoneController),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defulttextformfiled(
                          controller: nameController,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          text: "Name",
                          prefixIcon: const Icon(Icons.person)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defulttextformfiled(
                          controller: emailController,
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          text: "Email",
                          prefixIcon: const Icon(Icons.email)),
                      const SizedBox(
                        height: 10.0,
                      ),
                      defulttextformfiled(
                          controller: phoneController,
                          readOnly: true,
                          keyboardType: TextInputType.name,
                          text: "Phone",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.phone)),
                      const SizedBox(
                        height: 10.0,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                                onPressed: () {
                                  CacheHelper.removeData(key: 'token')
                                      ?.then((value) {
                                    if (value!) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                            const ShopLoginScreen(),
                                          ),
                                              (route) => true);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.power_settings_new,
                                ),
                                label: const Text(
                                  'Sign Out',
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else
          {
            return const Center(child: CircularProgressIndicator(),);
          }

      },
    );
  }
}
