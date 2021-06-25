// import 'package:flutter/material.dart';
// import "package:hackathon2021/utilities/colors.dart";
// class InputFile extends StatelessWidget {
//   InputFile({required this.label , this.obscureText});
//   final String label,
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:getField(),
//
//     );
//   }
//
//   Widget getField({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87
//           ),
//
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//               contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               fillColor: Colors.grey,
//
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color:kPrimaryColor,
//                   width: 2,
//
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//
//               ),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color:kPrimaryColor,width: 2),
//                 borderRadius: BorderRadius.circular(20),
//               )
//           ),
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }
