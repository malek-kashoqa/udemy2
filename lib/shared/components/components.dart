import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy2/shared/cubit/cubit.dart';
import 'package:udemy2/shared/cubit/states.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color backgroundColor = Colors.blue,
  required Function function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget DefaultFormField({
  required TextEditingController controller,
  required String text,
  required String? Function(String?)? validate,
  bool isPassword = false,
  bool isReadOnly = false,
  Widget? suffixIcon,
  Widget? prefixIcon,
  TextInputType? keyboardType,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
}) =>
    TextFormField(
      validator: validate,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: isReadOnly,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );

Widget BuildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: model['id']);
  },
  background: Container(color: Colors.red,),
  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Text("${model['time']}"),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model['title']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('${model['date']}'),
                  ],
                ),
              ),
              IconButton(onPressed: (){
                AppCubit.get(context).updateDatabase(id: model['id'], status: 'done');
              }, icon: Icon(Icons.check_box),color: Colors.green,),
              IconButton(onPressed: (){
                AppCubit.get(context).updateDatabase(id: model['id'], status: 'archived');
              }, icon: Icon(Icons.archive_outlined),color: Colors.black45,),
            ],
          ),
        ),
      ),
);

Widget ListSeparator() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );


Widget tasksBuilder({required List tasks}) => BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) {},
    builder: (context, state) => ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => BuildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => ListSeparator(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("No tasks available please add a new task.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),),
          ],
        ),
      ),
    ),
  );
