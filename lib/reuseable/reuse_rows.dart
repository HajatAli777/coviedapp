import 'package:flutter/material.dart';

class ReuseRows extends StatelessWidget {
  String title;
  String value;
  ReuseRows({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(
            
          ),
          
        ],
      ),
    );
  }
}