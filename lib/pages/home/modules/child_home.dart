import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


class ChildHome extends StatefulWidget {
  @override
  State<ChildHome> createState() => _ChildHomeState();
}

class _ChildHomeState extends State<ChildHome> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  late FocusNode myFocusNode2;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  focusNode: myFocusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入一些文本';
                    }

                    return null;
                  },
                ),
              ),
              ElevatedButton(
                child: Text('提交'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final directory = await getApplicationDocumentsDirectory();
                    // print(_formKey.currentState!.context.toString());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(directory.path)),
                    );
                  }
                },
              )
            ]),
          ),
          Column(
            children: [
              TextField(
                focusNode: myFocusNode2,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
                onChanged: (value) {
                  print(value);
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('data:'),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: null,
                      // autofocus: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print(textController.text);
                      textController.clear();
                      // myFocusNode.requestFocus();
                      // myFocusNode2.requestFocus();
                    },
                    child: Text('提交'),
                    // style: ButtonStyle(),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(onPressed: () {}, child: Text('重置')),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
