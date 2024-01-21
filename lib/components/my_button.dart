import "package:flutter/material.dart";

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String? imagePath;
  const MyButton(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.textColor,
      required this.text,
      this.imagePath});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: imagePath != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagePath!,
                      height: 36,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
