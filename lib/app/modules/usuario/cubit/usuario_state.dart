import 'package:firebase_auth/firebase_auth.dart';

class UsuarioState {
  String? error;
  bool success = false;
  bool isLoading = false;
  final List<User> usuarios;

  UsuarioState({
    this.error,
    this.success = false,
    this.isLoading = false,
    this.usuarios = const [],
  });

  UsuarioState copyWith({
    String? error,
    bool? success,
    bool? isLoading,
    List<User>? usuarios,
  }) {
    return UsuarioState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      success: success ?? this.success,
      usuarios: usuarios ?? this.usuarios,
    );
  }
}
