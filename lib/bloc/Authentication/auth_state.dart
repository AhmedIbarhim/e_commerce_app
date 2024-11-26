part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}
final class RegisterSuccess extends AuthState {
  late bool status;
  late String message;
  String? token;
  RegisterSuccess({required this.status, required this.message, this.token});
}
final class RegisterError extends AuthState {}


final class LoginLoading extends AuthState {}
final class LoginSuccess extends AuthState {
  late bool status;
  late String message;
  String? token;
  LoginSuccess({required this.status, required this.message, this.token});
}
final class LoginError extends AuthState {}

class GetProfileLoading extends AuthState {}
class GetProfileSuccess extends AuthState {}
class GetProfileError extends AuthState {}


class UpdateProfileLoading extends AuthState {}
final class UpdateProfileSuccess extends AuthState {}
class UpdateProfileError extends AuthState {}
