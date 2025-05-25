import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data.dart';
import 'package:todolist/main.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskEntity task;

  EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,

        title: Text('Edit task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final task = TaskEntity();
          task.name = _controller.text;
          task.priority = widget.task.priority;
          if (task.isInBox) {
            task.save();
          } else {
            final Box<TaskEntity> box = Hive.box(taskBoxName);
            box.add(task);
          }
          Navigator.of(context).pop();
        },
        label: Row(
          children: [
            Text('save changes'),
            SizedBox(width: 7),
            Icon(CupertinoIcons.check_mark, size: 18),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    onTap: () {
                      setState(() {
                        widget.task.priority = Priority.high;
                      });
                    },

                    label: 'High',
                    color: primaryColor,
                    isSelected: widget.task.priority == Priority.high,
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    onTap: () {
                      setState(() {
                        widget.task.priority = Priority.normal;
                      });
                    },
                    label: 'Normal',
                    color: Color(0xffF09819),
                    isSelected: widget.task.priority == Priority.normal,
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  flex: 1,
                  child: PriorityCheckBox(
                    onTap: () {
                      setState(() {
                        widget.task.priority = Priority.low;
                      });
                    },
                    label: 'Low',
                    color: Color(0xff3BE1F1),
                    isSelected: widget.task.priority == Priority.low,
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(label: Text('Add a task for today')),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final GestureTapCallback onTap;
  const PriorityCheckBox({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
            color: Color(0xffAFBED0).withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            Center(child: Text(label)),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: PriortyCheckBox(value: isSelected, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriortyCheckBox extends StatelessWidget {
  final bool value;
  final Color color;

  const PriortyCheckBox({super.key, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      // padding: EdgeInsets.only(left: 16, right: 16),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: !value ? Border.all(color: Color(0xffAFBED0), width: 2) : null,
        color: color,
      ),
      child:
          value
              ? Icon(
                CupertinoIcons.check_mark,
                size: 12,
                color: themeData.colorScheme.onPrimary,
              )
              : null,
    );
  }
}



class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}