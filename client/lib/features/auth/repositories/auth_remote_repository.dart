// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, unused_import

import 'dart:convert';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/view/pages/Validate.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> Create_User({
    required String first_name,
    required String last_name,
    required String role,
    required String age,
    required String email,
    required String password,
    required String validate_code,
    required String gender,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://5c0d-212-34-22-101.ngrok-free.app/auth/',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'first_name': first_name,
            'last_name': last_name,
            'role': role,
            'age': age,
            'email': email,
            'password': password,
            'validate_code': validate_code,
            'gender': gender
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  /* Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final respone = await http.post(
        Uri.parse(
          'https://8ede-212-34-13-105.ngrok-free.app/auth/token',
        ),
        headers: {
          'Content-Type':
              'application/x-www-form-urlencoded', // Correct content type
        },
        body: {
          'username': email, // Pass email as username
          'password': password,
        },
      );
      
    } catch (e) {
      print(e);
    }
  } */

  Future<http.Response> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('https://5c0d-212-34-22-101.ngrok-free.app/auth/token'),
      headers: {
        'Content-Type':
            'application/x-www-form-urlencoded', // Correct content type
      },
      body: {
        'username': email, // Pass email as username
        'password': password,
      },
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }

  /*  Future<void> Validate({
    required String email,
  }) async {
    try {
      final respone = await http.post(
        Uri.parse(
          'https://5c0d-212-34-22-101.ngrok-free.app/auth/validate',
        ),
        headers: {
          'Content-Type': 'application/json', // Correct content type
        },
        body: jsonEncode(
          {
            'email': email, // Pass email as username
          },
        ),
      );
      print(respone.statusCode);
      print(respone.body);
    } catch (e) {
      print(e);
    }
  } */
  Future<http.Response> Validate({required String email}) async {
    final response = await http.post(
      Uri.parse('https://5c0d-212-34-22-101.ngrok-free.app/auth/validate'),
      headers: {
        'Content-Type': 'application/json', // Correct content type
      },
      body: jsonEncode(
        {
          'email': email, // Pass email as username
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
    return response;
  }

  Future<http.Response> passValidate({required String email}) async {
    final response = await http.post(
        Uri.parse(
            'https://5c0d-212-34-22-101.ngrok-free.app/auth/PassValidate'),
        headers: {
          'Content-Type': 'application/json', // Correct content type
        },
        body: jsonEncode(
          {
            'email': email, // Pass email as username
          },
        ));
    return response;
  }

  Future<void> ValidateCode({
    required String email,
    required String validate_code,
    required String new_password,
  }) async {
    try {
      final respone = await http.post(
        Uri.parse(
          'https://5c0d-212-34-22-101.ngrok-free.app/auth/validateCode',
        ),
        headers: {
          'Content-Type': 'application/json', // Correct content type
        },
        body: jsonEncode(
          {
            'email': email, // Pass email as username
            'validate_code': validate_code,
            'new_password': new_password
          },
        ), 
      );
      print(respone.statusCode);
      print(respone.body);
    } catch (e) {
      print(e);
    }
  }
}
