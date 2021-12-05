import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:final_camila/components/loader_component.dart';
import 'package:final_camila/helpers/constans.dart';
import 'package:final_camila/models/token.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _emailError = '';
  bool _emailShowError = false;

  String _password = '';
  String _passwordError = '';
  bool _passwordShowError = false;

  bool _rememberme = true;
  bool _passwordShow = false;

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEB3B),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                _showButtons(),
              ],
            ),
          ),
          _showLoader
              ? LoaderComponent(text: 'Por favor espere...')
              : Container(),
        ],
      ),
    );
  }

  Widget _showButtons() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
            ],
          ),
          _showGoogleLoginButton(),
        ],
      ),
    );
  }

  // void _login() async {
  //   setState(() {
  //     _passwordShow = false;
  //   });

  //   setState(() {
  //     _showLoader = true;
  //   });

  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     setState(() {
  //       _showLoader = false;
  //     });
  //     await showAlertDialog(
  //         context: context,
  //         title: 'Error',
  //         message: 'Verifica que estes conectado a internet.',
  //         actions: <AlertDialogAction>[
  //           AlertDialogAction(key: null, label: 'Aceptar'),
  //         ]);
  //     return;
  //   }

  //   Map<String, dynamic> request = {
  //     'userName': _email,
  //     'password': _password,
  //   };

  //   var url = Uri.parse('${Constans.apiUrl}/api/Account/CreateToken');
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       'content-type': 'application/json',
  //       'accept': 'application/json',
  //     },
  //     body: jsonEncode(request),
  //   );

  //   setState(() {
  //     _showLoader = false;
  //   });

  //   if (response.statusCode >= 400) {
  //     setState(() {
  //       _passwordShowError = true;
  //       _passwordError = "Email o contraseña incorrectos";
  //     });
  //     return;
  //   }

  //   var body = response.body;

  //   var decodedJson = jsonDecode(body);
  //   var token = Token.fromJson(decodedJson);
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => HomeScreen(
  //                 token: token,
  //               )));
  // }

  Widget _showGoogleLoginButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: ElevatedButton.icon(
                onPressed: () => _loginGoogle(),
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                ),
                label: Text('Iniciar sesión con Google'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black)))
      ],
    );
  }

  void _loginGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            "925050624683-7ltluh8430694d151mcd7al7j154hvf3.apps.googleusercontent.com");
    print('holi');
    try {
      await googleSignIn.signOut();
      var user = await googleSignIn.signIn();
      print(user);
    } catch (error) {
      print('$error hola');
    }
  }

  // Future _socialLogin(Map<String, dynamic> request) async {
  //   var url = Uri.parse('${Constans.apiUrl}/api/Account/SocialLogin');
  //   var bodyRequest = jsonEncode(request);
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       'content-type': 'application/json',
  //       'accept': 'application/json',
  //     },
  //     body: bodyRequest,
  //   );

  //   setState(() {
  //     _showLoader = false;
  //   });

  //   if (response.statusCode >= 400) {
  //     await showAlertDialog(
  //         context: context,
  //         title: 'Error',
  //         message:
  //             'El usuario ya inció sesión previamente por email o por otra red social.',
  //         actions: <AlertDialogAction>[
  //           AlertDialogAction(key: null, label: 'Aceptar'),
  //         ]);
  //     return;
  //   }

  //   var body = response.body;

  //   var decodedJson = jsonDecode(body);
  //   var token = Token.fromJson(decodedJson);
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => HomeScreen(
  //                 token: token,
  //               )));
  // }
}
