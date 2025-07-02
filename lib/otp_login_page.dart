import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
// import 'home_screen.dart';

class OtpLoginPage extends StatefulWidget {
  @override
  State<OtpLoginPage> createState() => _OtpLoginPageState();
}

class _OtpLoginPageState extends State<OtpLoginPage> {
  final mobileController = TextEditingController();
  final otpController = TextEditingController();

  bool loading = false;

  Future<void> sendOtp() async {
    setState(() {
      loading = true;
    });

    var url = Uri.parse('https://payment.vada.ir/api/auth/login-otp');

    try {
      var response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'mobile': mobileController.text,
          'package_name': 'com.vada.karvarz',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('OTP Sent!')));
        print(response.body);
      } else {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error sending OTP')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> checkOtp() async {
    setState(() {
      loading = true;
    });
    // Navigator.pushReplacementNamed(context, '/home');

    var url = Uri.parse('https://payment.vada.ir/api/auth/check-otp');

    try {
      var response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {'mobile': mobileController.text, 'token': otpController.text},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var token = data['token'];

        if (token != null) {
          // ذخیره توکن در Hive
          // var box = Hive.box('auth');
          var box = Hive.box<String>('auth');

          await box.put('token', token);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Login Successful!')));
          print('TOKEN: $token');
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        var data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'OTP Failed!')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> readToken() async {
    // var box = Hive.box('auth');
    var box = Hive.box<String>('auth');


    var token = box.get('token');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Stored token: $token')));
  }

  Future<void> logout() async {
    // var box = Hive.box('auth');
    var box = Hive.box<String>('auth');

    await box.delete('token');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Logged out')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            ElevatedButton(
              onPressed: loading ? null : sendOtp,
              child:
                  loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Send OTP'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            ElevatedButton(
              onPressed: loading ? null : checkOtp,
              child:
                  loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Verify OTP'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: readToken,
              child: Text('Read Stored Token'),
            ),
            ElevatedButton(
              onPressed: logout,
              child: Text('Logout (Delete Token)'),
            ),
          ],
        ),
      ),
    );
  }
}
