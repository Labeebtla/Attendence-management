// ignore_for_file: camel_case_types

import 'package:attendence_manager/screens/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'username'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: 'password',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    checkLogin(context);
                  },
                  icon: const Icon(
                    Icons.login,
                    color: Colors.amber,
                  ),
                  label: const Text(
                    'Login',
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx1) => const homeScreen()));
                  },
                  child: const Text(
                    'skip',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ClipPath(
          clipper: TheCustomClipper(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.amber,
            ),
            child: const Center(child: Text('')),
          ))
    ]));
  }
}

class TheCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 3);
    var firstControlPoint = Offset(
        0,
        size.height /
            3.5); // adjust the height to move start of the first curve
    var firstEndPoint = Offset(
        size.width / 4.2,
        size.height / 3.5 +
            10); // adjust the width to add the end control point and height to move end of the first curve

    var secControlPoint = Offset(size.width,
        size.height / 2.8); // adjust the height to move end of the second curve
    var secEndPoint = Offset(
        size.width,
        size.height / 3 -
            40); // adjust the width to add the right first control point and height to move start of the second curve

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(
        secControlPoint.dx, secControlPoint.dy, secEndPoint.dx, secEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

void checkLogin(BuildContext ctx) {
  final username = usernameController.text;
  final password = passwordController.text;
  if (username == password) {
    //home
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (ctx1) => const homeScreen()));
  } else {
    const errorMassege = 'username password doesnot match';

    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      content: Text(errorMassege),
      duration: Duration(seconds: 3),
    ));
  }
}
