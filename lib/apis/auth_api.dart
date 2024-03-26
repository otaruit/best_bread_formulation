import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:best_bread_formulation/core/core.dart';
import 'package:best_bread_formulation/core/providers.dart';
import 'package:best_bread_formulation/core/type_defs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  FutureEither<model.User?> signUp(
      {required String email, required String password});
  FutureEither<model.Session> login(
      {required String email, required String password});
  Future<model.User?> currentUserAccount();
  FutureEitherVoid logout();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<model.User?> signUp(
      {required String email, required String password}) async {
    try {
      final user = await _account.create(
          userId: ID.unique(), email: email, password: password);
      return right(user);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }


@override
  Future<model.User?> currentUserAccount() async {
    try {
      final user = await _account.get();
      return user;
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.Session> login(
      {required String email, required String password}) async {
    try {
      final account = await _account.createEmailPasswordSession(
          email: email, password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          e.message ?? 'ログイン中に問題が発生しました', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }

  @override
  FutureEitherVoid logout() async {
    try {
      final account = await _account.deleteSession(sessionId: 'current');
      return account;
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
         e.message ?? 'ログアウト中に問題が発生しました', stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
