import 'package:flutter/material.dart';
import 'package:statetest/Appstate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var con = TextEditingController();

  var state = appState.state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          appState.rebuilder(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(child: Text(state.todo.length.toString() + ' items' , style: TextStyle(fontSize: 20),)),
              )),
        ],
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: appState.rebuilder(() => ListView.builder(
                  itemBuilder: (context, index) {
                    return SingleToDoItem(
                      val: state.todo[index],
                    );
                  },
                  itemCount: state.todo.length,
                )),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onSubmitted: (x) {
                      state.todo.add(x);
                      appState.notify();
                      con.clear();
                    },
                    controller: con,
                    decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Write down'),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  state.todo.add(con.text);
                  con.clear();
                  appState.notify();
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}

class SingleToDoItem extends StatelessWidget {
  final String val;
  const SingleToDoItem({
    Key key,
    this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(val),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          appState.state.todo.remove(val);
          appState.notify();
        },
      ),
    );
  }
}
