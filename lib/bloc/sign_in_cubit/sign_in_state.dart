part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class Appcreatedbstate extends SignInState {}

final class Appinsertdbstate extends SignInState {}

final class Appgetdbstate extends SignInState {}

final class Appdeletedbstate extends SignInState {}
