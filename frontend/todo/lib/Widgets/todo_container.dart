import 'package:flutter/material.dart';

class TodoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final Function onPress;

  const TodoContainer(
      {super.key,
      required this.id,
      required this.title,
      required this.desc,
      required this.isDone,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 57, 72, 102),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  IconButton(
                    onPressed: () => onPress(),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 25,
                    ),
                  )
                ],
              ),
              SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(desc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
