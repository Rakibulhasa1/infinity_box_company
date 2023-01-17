import 'package:flutter/material.dart';

class addProduct extends StatelessWidget {
  final IconData icon;
  const addProduct({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 18,
      ),
    );
  }
}
