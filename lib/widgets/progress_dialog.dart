import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget
{
  String message;
  ProgressDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        child: Container(
          margin: const EdgeInsets.all(7.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 59, 55, 55),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [

                const SizedBox(width: 6.0,),

                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 219, 136, 12)),
                ),

                const SizedBox(width: 26.0,),

                Text(
                  message!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

        )
    );
  }
}





