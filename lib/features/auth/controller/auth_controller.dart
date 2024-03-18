import 'package:appwrite/models.dart' as model;
import 'package:best_bread_formulation/apis/auth_api.dart';
import 'package:best_bread_formulation/apis/user_api.dart';
import 'package:best_bread_formulation/core/utils.dart';
import 'package:best_bread_formulation/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
      authAPI: ref.watch(authAPIProvider), userAPI: ref.watch(userAPIProvider));
});

final currentUserAccountProvider = FutureProvider<model.User?>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;

  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) {
      showSnackBar(context, l.message);
      Navigator.push(context, HomeView.route());
    }, (r) => null);
    // UserModel userModel;
    // if (res != null) {
    //   userModel = UserModel(
    //     email: email,
    //     name: email,
    //     uid: res.$id.toString(),
    //   );
    //   final res2 = await _userAPI.saveUserData(userModel);
    //   res2.fold((l) => showSnackBar(context, l.message), (r) {
    //     showSnackBar(context, "登録完了！");
    //     Navigator.push(context, LoginView.route());
    //   });
    // }
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(email: email, password: password);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      showSnackBar(context, "ログインに成功しました！");
      Navigator.push(context, HomeView.route());
    });
  }

  Future<void> logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {});
  }
}
