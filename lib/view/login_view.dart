import 'package:flutter/material.dart';
import 'package:mvvm_with_provider/res/components/round_button.dart';
import 'package:mvvm_with_provider/utils/routes/routes_name.dart';
import 'package:mvvm_with_provider/utils/utils.dart';
import 'package:mvvm_with_provider/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              focusNode: emailFocusNode,
              onFieldSubmitted: (value) => Utils.fieldFocusChange(
                  context, emailFocusNode, passwordFocusNode),
            ),
            ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePassword.value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_open_outlined),
                    suffixIcon: InkWell(
                      onTap: () {
                        _obsecurePassword.value = !_obsecurePassword.value;
                      },
                      child: _obsecurePassword.value
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility),
                    ),
                  ),
                  focusNode: passwordFocusNode,
                );
              },
            ),
            SizedBox(height: height * 0.055),
            RoundButton(
                title: "Login",
                loading: authViewModel.loading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(context, "PLease enter email!");
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        context, "Please enter password");
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        context, "Please enter 6 digit password");
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    print(data);
                    authViewModel.loginApi(data, context);
                  }
                }),
            SizedBox(height: height * 0.025),
            InkWell(
              onTap: () => Navigator.pushNamed(context, RoutesName.singUp),
              child: const Text("Don't have an account? Sign Up", style: TextStyle(decoration: TextDecoration.underline, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
