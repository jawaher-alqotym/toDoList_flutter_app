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

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  final List<String> inputs = [];
  late String input ;


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
                  input=value;
                  print(input);},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a task',
                ),
              ),
            ),
            ...inputs.map((input) => ListItem(input)),
          ],)
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent.withOpacity(0.5),
        onPressed: () => setState(() {
          print("button is clicked");
          inputs.add(input);
          _count++;
        }),
        tooltip: 'Increment Counter',
        child:
          const Icon(Icons.add, color:Colors.white,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ListItem extends StatelessWidget {
  String data;
  ListItem(this.data);


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        child: Text(data),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.indigoAccent.withOpacity(0.5),),
      ),
    );
  }
}
