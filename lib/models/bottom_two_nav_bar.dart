import 'package:flutter/material.dart';

class BottomTwoNavBar extends StatelessWidget {
  final IconData headingIcon;
  final VoidCallback headerOnPressed;
  final String trailingLabel;
  final VoidCallback? trailingOnPressed;
  const BottomTwoNavBar(
      {super.key,
      required this.headingIcon,
      required this.headerOnPressed,
      required this.trailingLabel,
      required this.trailingOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      color: Colors.white,
      transformAlignment: AlignmentDirectional.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color.fromRGBO(220, 220, 220, 1)),
              child: IconButton(
                icon: Icon(
                  headingIcon,
                  color: Colors.black,
                ),
                splashColor: Colors.transparent,
                splashRadius: 1,
                onPressed: headerOnPressed,
              ),
            ),
            SizedBox(
              width: 0.8 * MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
                onPressed: trailingOnPressed,
                child: Text(
                  trailingLabel,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
