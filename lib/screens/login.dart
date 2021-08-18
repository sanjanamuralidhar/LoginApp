import 'package:LoginApp/Bloc/loginBloc/bloc.dart';
import 'package:LoginApp/Widget/appButton.dart';
import 'package:LoginApp/screens/mapPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    // _textIDController.text = "admin";
    // _textPassController.text = "admin";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[100],
        body: SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'LOGIN',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                child: Container(
                  height: 40,
                  // width: MediaQuery.of(context).size.width * .75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _textIDController,
                      // readOnly: true,
                      // textAlign: TextAlign.center,
                      //  obscureText: true,
                      //  obscuringCharacter: "*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'username',
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8, 20.0, 8),
                child: Container(
                  height: 40,
                  // width: MediaQuery.of(context).size.width * .75,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _textPassController,
                      // readOnly: true,
                      // textAlign: TextAlign.center,
                      obscureText: true,
                      obscuringCharacter: "*",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'password',
                          hintStyle: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, login) {
                  return BlocListener<LoginBloc, LoginState>(
                    listener: (context, loginListener) {
                      if (loginListener is LoginFail) {
                        _showMessage(loginListener.message);
                      }
                      if (loginListener is LoginSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapPage()),
                        );
                      }
                    },
                    child: AppButton(
                      onPressed: () {
                        setState(() {
                          _loginBloc.add(OnLogin(
                            username: _textIDController.text,
                            password: _textPassController.text,
                          ));
                        });
                      },
                      color: Colors.blue,
                      text: 'Login',
                      loading: login is LoginLoading,
                      disableTouchWhenLoading: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
