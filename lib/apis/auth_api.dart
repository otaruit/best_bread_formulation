import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:best_bread_formulation/core/failure.dart';
import 'package:best_bread_formulation/core/providers.dart';
import 'package:best_bread_formulation/core/type_defs.dart';
import 'package:best_bread_formulation/features/auth/view/signup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<User> signUp({required String email, required String password});
  FutureEither<Session> login(
      {required String email, required String password});
  Future<User?> currentUserAccount();
  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password, name: email);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? 'Some unexpected error occurred',
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  Future<User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<Session> login(
      {required String email, required String password}) async {
    try {
      final account = await _account.createEmailPasswordSession(
          email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? 'ログイン中に問題が発生しました', stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      final account = await _account.deleteSession(sessionId: 'current');
      return account;
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? 'ログアウト中に問題が発生しました', stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
