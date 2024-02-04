part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

final class StartAuthen extends AuthenticationEvent{
  @override
  List<Object?> get props => [];

}

final class LoginAccount extends AuthenticationEvent {
  final String userName;
  final String password;

  LoginAccount({required this.userName, required this.password});
  
  @override
  List<Object?> get props => [userName, password];
}

final class LogoutAccount extends AuthenticationEvent{
  @override
  List<Object?> get props => [];
}
