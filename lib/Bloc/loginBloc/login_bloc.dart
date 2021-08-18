import 'dart:async';

import 'package:LoginApp/Models/model_result.dart';
import 'package:LoginApp/api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Api repository;

  LoginBloc({@required this.repository});

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(event) async* {
    ///Event for login
    if (event is OnLogin) {
      ///Notify loading to UI
      yield LoginLoading();

      await Future.delayed(Duration(seconds: 1));

      ///Fetch API
      final ResultApiModel result = await Api.login(
        username: event.username,
        password: event.password,
      );

      ///Case API fail but not have token
      if (result.success) {
        ///Login API success
        // final UserModel user = UserModel.fromJson(result.data);

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          // authBloc.add(AuthenticationSave(user));

          ///Notify loading to UI
          yield LoginSuccess(result.message);
        } catch (error) {
          ///Notify loading to UI
          yield LoginFail(error.toString());
        }
      } else {
        ///Notify loading to UI
        yield LoginFail(result.message);
      }
    }

    ///Event for logout
    if (event is OnLogout) {
      yield LogoutLoading();
      try {
        ///Begin start AuthBloc Event OnProcessLogout
        // authBloc.add(AuthenticationClear());

        ///Notify loading to UI
        yield LogoutSuccess();
      } catch (error) {
        ///Notify loading to UI
        yield LogoutFail(error.toString());
      }
    }
  }
}
