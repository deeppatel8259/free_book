import 'package:flutter/material.dart';
import 'package:free_book/Screens/location_screen.dart';
import 'package:open_mail_app/open_mail_app.dart';


class EmailVerificationScreen extends StatelessWidget {
  static const String id = 'email-ver';
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Verify Email',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Text(
              'Check your email to verify your registered Email',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  child: Text('Verify Email'),
                      onPressed: () async {
                        // Android: Will open mail app or show native picker.
                        // iOS: Will open mail app if single mail app found.
                        var result = await OpenMailApp.openMailApp();

                        // If no mail apps found, show error
                        if (!result.didOpen && !result.canOpen) {
                          showNoMailAppsDialog(context);

                          // iOS: if multiple mail apps found, show dialog to select.
                          // There is no native intent/default app system in iOS so
                          // you have to do it yourself.
                        } else if (!result.didOpen && result.canOpen) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MailAppPickerDialog(
                                mailApps: result.options,
                              );
                            },
                          );
                        }
                        Navigator.pushReplacementNamed(context, LocationScreen.id);
                      },
                ))
              ],
            )
          ],
        ),
      )),
    );
  }
  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
