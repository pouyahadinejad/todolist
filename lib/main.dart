import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data.dart';
import 'package:todolist/edit.dart';

const taskBoxName = 'tasks';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: primaryVariantColor),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primaryTextColor = Color(0xff1D2830);
    final secondaryTextColor = Color(0xffAFBED0);
    const Color primaryColor = Color(0xff794CFF);
    const Color primaryVariantColor = Color(0xff5C0AFF);
    const normalPriority = Color(0xffF09819);
    const lowPriority = Color(0xff3BE1F1);
    const higtPriority = primaryColor;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: secondaryTextColor),
          iconColor: secondaryTextColor,
          border: InputBorder.none,
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          primaryContainer: primaryVariantColor,
          background: Color(0xffF3F5F8),
          onSurface: primaryTextColor,
          onBackground: primaryTextColor,
          secondary: primaryColor,
          onSecondary: primaryColor,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

const Color primaryColor = Color(0xff794CFF);
const Color primaryVariantColor = Color(0xff5C0AFF);
const normalPriority = Color(0xffF09819);
const lowPriority = Color(0xff3BE1F1);
const higtPriority = primaryColor;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TaskEntity>(taskBoxName);
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // appBar: AppBar(title: Text('ToDoList')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(task: TaskEntity()),
            ),
          );
        },
        label: Row(
          children: [
            Text('Add New Task'),
            SizedBox(width: 3),
            Icon(CupertinoIcons.add),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    themeData.colorScheme.primary,
                    themeData.colorScheme.primaryContainer,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'To Do List',
                          style: themeData.textTheme.headlineMedium!.apply(
                            color: themeData.colorScheme.onPrimary,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.share,
                          color: themeData.colorScheme.onPrimary,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 38,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: themeData.colorScheme.onPrimary,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1)),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.search),
                          label: Text('Search Task ...'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<TaskEntity>>(
                valueListenable: box.listenable(),
                builder: (context, box, child) {
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: box.values.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Today',
                                  style: themeData.textTheme.headlineSmall!
                                      .apply(fontSizeFactor: 0.9),
                                ),
                                Container(
                                  width: 70,
                                  height: 3,
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(1.5),
                                  ),
                                ),
                              ],
                            ),
                            MaterialButton(
                              color: Color(0xffEAEFF5),
                              textColor: Color(0xffAFBED0),
                              elevation: 0,
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text('Delete All'),
                                  SizedBox(width: 4),
                                  Icon(CupertinoIcons.delete_solid, size: 18),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        final TaskEntity task = box.values.toList()[index - 1];
                        return TaskItem(task: task);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  static const double height = 84;
  const TaskItem({super.key, required this.task});

  final TaskEntity task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final priorityColor;
    switch (widget.task.priority) {
      case Priority.low:
        priorityColor = lowPriority;

      case Priority.normal:
        priorityColor = normalPriority;

      case Priority.high:
        priorityColor = higtPriority;
    }
    return InkWell(
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.only(left: 16),
        height: TaskItem.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeData.colorScheme.surface,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Row(
          children: [
            MyCheckBox(value: widget.task.isCompleted),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                widget.task.name,
                style: TextStyle(
                  fontSize: 24,
                  decoration:
                      widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                ),
              ),
            ),
            Container(
              width: 5,
              height: TaskItem.height,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCheckBox extends StatelessWidget {
  final bool value;
  const MyCheckBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      // padding: EdgeInsets.only(left: 16, right: 16),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: !value ? Border.all(color: Color(0xffAFBED0), width: 2) : null,
        color: value ? primaryColor : null,
      ),
      child:
          value
              ? Icon(
                CupertinoIcons.check_mark,
                size: 16,
                color: themeData.colorScheme.onPrimary,
              )
              : null,
    );
  }
}
