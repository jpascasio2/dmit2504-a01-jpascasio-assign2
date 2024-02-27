// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Enable Buttons'),
              Switch(
                  value: enabled,
                  onChanged: (bool onChangedValue) {
                    print('onChangedValue is $onChangedValue');
                    enabled = onChangedValue;
                    setState(() {
                      if (enabled && timesClicked == 0) {
                        msg1 = 'Click Me';
                        print('enabled is true');
                      } else {
                        msg1 = 'Clicked $timesClicked';
                        print('enabled is false');
                      }
                    });
                  })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: enabled,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        timesClicked++;
                        msg1 = 'Clicked $timesClicked';
                        print('clicked $timesClicked');
                      });
                    },
                    child: Text(msg1),
                  )),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked = 0;
                      msg1 = 'Click Me';
                    });
                  },
                  child: Text('Reset'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_2),
                        hintText: "first name",
                        helperText: "min 1, max 10",
                        suffixIcon: Icon(Icons.check_circle)),
                    maxLength: 10,
                    validator: (value) {
                      return value!.isEmpty ? "Must provide a name" : null;
                    },
                    onSaved: (value) {
                      msg1 = value!;
                    },
                  ),
                  SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Hey There! Your name is $msg1'),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                            },
                            textColor: Theme.of(context).dialogBackgroundColor
                          ),
                        ));
                      }
                    },
                    child: Text("Submit")
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
