import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String?
  address; // Simplifying address for now, can be specific object later

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.address,
  });

  @override
  List<Object?> get props => [id, username, email, address];
}
