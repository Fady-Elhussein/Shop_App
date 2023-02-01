import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget defultButton({
  double width = double.infinity,
  required Function? function(),
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
Widget defulttextformfiled(
        {required controller,
        required keyboardType,
        bool obscureText = false,
         String? text,
        Icon? prefixIcon,
        Color? inputTextStyleColor,
        IconButton? suffixIcon,
       required bool readOnly,
        String? Function(String?)? validator,
        Function(String?)? onFieldSubmitted}) =>
    TextFormField(
      cursorColor: Colors.blue,
      readOnly:readOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        labelText: text,
        contentPadding: const EdgeInsets.all(25.0),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
      ),
    );

void showToast({
  required BuildContext context,
  required String msg,
  ToastStates? state,
}) =>
    Fluttertoast.showToast(
      textColor: Colors.black,
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      fontSize: 16,
      backgroundColor: chooseToastColor(state!),
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

List<BottomNavigationBarItem> bottomNavBar = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "Home",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.apps),
    label: "categories",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.favorite),
    label: "favorite",
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: "Profile",
  ),
];

Widget loadingAnimation() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
              size: 40, color: Colors.black),
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Loading...',
          style: TextStyle(),
        ),
      ],
    );
