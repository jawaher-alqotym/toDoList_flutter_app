// lib/main

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}


void removeItem(item){
  print(inputs);
  inputs.remove(item);
  print(inputs);

}

final List<String> inputs = [];
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late String input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.withOpacity(0.5),
        title: const Text('To Do'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              onChanged: (String value) {
                input = value;
                //print(input);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a task',
              ),
            ),
          ),
          ...inputs.map((input) => ListItem(input)),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent.withOpacity(0.5),
        onPressed: () => setState(() {
          //print("button is clicked");
          inputs.add(input);
        }),
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ListItem extends StatefulWidget {
  String data;
  ListItem(this.data);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.indigoAccent.withOpacity(0.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.data,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(child: Container(
                height: 60.0,
                width: 60.0,
              ),),
              Expanded(
                child: SizedBox(
                  height: 65,
                  width: 65,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                        Icons.edit,
                        color: Colors.grey ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(24),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                  height: 65,
                  width: 65,
                    child: ElevatedButton(
                    onPressed: () {
                      print(widget.data);
                      removeItem(widget.data);
                    },
                       child: const Icon(
                       Icons.delete,
                       color: Colors.redAccent ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.all(24),
                  ),
                ),
               ),
              ),
            ],
          ),
      ),
    );
  }
}
