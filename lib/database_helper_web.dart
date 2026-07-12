import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  static const String _usersKey = 'users_db';

  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final rawUsers = prefs.getString(_usersKey);

    if (rawUsers == null || rawUsers.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    final decoded = jsonDecode(rawUsers);
    if (decoded is! List) {
      return <Map<String, dynamic>>[];
    }

    return decoded
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  Future<int> registerUser(Map<String, dynamic> user) async {
    final users = await _loadUsers();
    final email = (user['email'] ?? '').toString().trim();

    final existingIndex = users.indexWhere(
      (existingUser) =>
          (existingUser['email'] ?? '').toString().trim() == email,
    );

    if (existingIndex != -1) {
      return 0;
    }

    final nextId = users.isEmpty
        ? 1
        : ((users.last['id'] as int?) ?? users.length) + 1;

    users.add({
      'id': nextId,
      'name': (user['name'] ?? '').toString(),
      'email': email,
      'password': (user['password'] ?? '').toString(),
    });

    await _saveUsers(users);
    return nextId;
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final users = await _loadUsers();
    final trimmedEmail = email.trim();

    for (final user in users) {
      if ((user['email'] ?? '').toString().trim() == trimmedEmail &&
          (user['password'] ?? '').toString() == password) {
        return user;
      }
    }

    return null;
  }
}
