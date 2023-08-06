import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo/Models/todo.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo/Widgets/app_bar.dart';
import 'package:todo/Widgets/todo_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int done = 0;
  int incomplete = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;
  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(
          id: todo['id'],
          title: todo['title'],
          desc: todo['desc'],
          isDone: todo['isDone'],
          date: todo['date'],
        );
        if (todo['isDone']) {
          done += 1;
        }
        myTodos.add(t);
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  void delete_todo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + "/" + id));
      setState(() {
        myTodos = [];
      });
      fetchData();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PieChart(dataMap: {
              "Complete": done.toDouble(),
              "Incomplete": (myTodos.length - done).toDouble()
            }),
            isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: myTodos.map((e) {
                      return TodoContainer(
                          onPress: () => delete_todo(e.id.toString()),
                          id: e.id,
                          title: e.title,
                          desc: e.desc,
                          isDone: e.isDone);
                    }).toList(),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  color: Color.fromARGB(255, 60, 59, 83),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "Add your todo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
                );
              });
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
