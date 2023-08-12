import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/core/auth_exception.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_state.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';



class RootCubit extends Cubit<RootState> {
  RootCubit(this.userRepository, this.rootRepository)
      : super(
          RootState(
            user: null,
            status: Status.loading,
          ),
        );

  StreamSubscription? _streamSubscription;

  final UserRepository userRepository;
  final RootRepository rootRepository;

  Future<void> createAccount(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await rootRepository.createAccount(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      AuthExceptionHandler.handleException(error);
      emit(
        RootState(
            user: null,
            status: Status.error,
            errorMessage: error.toString(),
            errorStatus: AuthResultStatus.error),
      );
    }
  }

  Future<void> signIn(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await rootRepository.signIn(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      emit(RootState(user: null, errorStatus: AuthResultStatus.error));
    }
  }

  Future<void> signOut() async {
    await rootRepository.signOut();
  }

  Future<void> start() async {
    emit(
      RootState(
        user: null,
        status: Status.loading,
        errorMessage: '',
      ),
    );

    _streamSubscription = rootRepository.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          status: Status.success,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RootState(
            user: null,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> addUserPhoto(String imageURL) async {
    await userRepository.add(imageURL);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
