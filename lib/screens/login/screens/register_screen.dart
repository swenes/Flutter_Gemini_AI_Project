import 'package:err_detector_project/screens/login/utils/helpers/snackbar_helper.dart';
import 'package:err_detector_project/services/login_service.dart';
import 'package:flutter/material.dart';
import '../components/app_text_form_field.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserService _userService = UserService();

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
        AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const GradientBackground(
              children: [
                Text(AppStrings.register1, style: AppTheme.titleLarge),
                SizedBox(height: 6),
                Text(AppStrings.createYourAccount, style: AppTheme.bodySmall),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTextFormField(
                      key: const Key('name'),
                      autofocus: true,
                      labelText: AppStrings.name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterName
                            : value.length < 4
                                ? AppStrings.invalidName
                                : null;
                      },
                      controller: nameController,
                    ),
                    AppTextFormField(
                      key: const Key('email'),
                      labelText: AppStrings.email,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterEmailAddress
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          key: const Key('password'),
                          obscureText: passwordObscure,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () =>
                                  passwordNotifier.value = !passwordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                passwordObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: confirmPasswordNotifier,
                      builder: (_, confirmPasswordObscure, __) {
                        return AppTextFormField(
                          labelText: AppStrings.confirmPassword,
                          controller: confirmPasswordController,
                          obscureText: confirmPasswordObscure,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseReEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? passwordController.text ==
                                            confirmPasswordController.text
                                        ? null
                                        : AppStrings.passwordNotMatched
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants.
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () => confirmPasswordNotifier.value =
                                  !confirmPasswordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                confirmPasswordObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () async {
                                  bool isExist =
                                      await _userService.isUserExists(
                                    emailController.text,
                                  );

                                  if (isExist) {
                                    SnackbarHelper.showSnackBar(
                                      AppStrings.userExist,
                                    );
                                  } else {
                                    _userService.registerUser(
                                        emailController.text,
                                        passwordController.text);
                                    SnackbarHelper.showSnackBar(
                                      AppStrings.registrationComplete,
                                    );
                                    nameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                    confirmPasswordController.clear();
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushNamed(context, '/loginPage');
                                  }
                                }
                              : null,
                          child: const Text(AppStrings.register2),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.iHaveAnAccount,
                  style: AppTheme.bodySmall.copyWith(color: Colors.black),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/loginPage'),
                  child: const Text(AppStrings.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
