import 'package:flutter/material.dart';

class CardSlideShow extends StatelessWidget {
  final String header;
  final String description;
  final String label;
  final String imageUrl;
  const CardSlideShow(
      {super.key,
      required this.header,
      required this.description,
      required this.label,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: FractionalOffset.centerRight,
                end: FractionalOffset.centerLeft,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black,
                ],
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        color: Color.fromRGBO(190, 190, 190, 1)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )),
                      onPressed: () {},
                      child: Text(
                        label,
                        style: const TextStyle(fontSize: 16),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
