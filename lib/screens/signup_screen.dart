import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter_clone/resources/auth_methods.dart';
import 'package:instagram_flutter_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout.dart';
import 'package:instagram_flutter_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter_clone/responsive/web_screen_layout.dart';
import 'package:instagram_flutter_clone/screens/login_screen.dart';
import 'package:instagram_flutter_clone/utils/colors.dart';
import 'package:instagram_flutter_clone/utils/global_variable.dart';
import 'package:instagram_flutter_clone/utils/utils.dart';
import 'package:instagram_flutter_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override 
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // signup user using auth methods
    String res = await AuthMethods().signUpUser(
      email: _emailController.text, 
      password: _passwordController.text, 
      username: _usernameController.text, 
      bio: _bioController.text, 
      file: _image!);

    // if string returns success, new user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(), 
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });

      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    // set state to display the image on the circle avatar
    setState(() {
      _image = image;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          
        ),
      ),
    );
  }
}