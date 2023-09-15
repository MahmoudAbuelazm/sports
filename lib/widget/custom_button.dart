import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromARGB(255, 42, 2, 95), width: 2.0),
            borderRadius: BorderRadius.circular(50.0)),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Skip",
                style: GoogleFonts.allerta(fontSize: 16.0, color: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.arrow_forward_sharp,
                color: Colors.white,
              )
            ]),
      ),
    );
  }
}
