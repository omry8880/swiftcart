import 'package:flutter/material.dart';

import '../utils/colors_util.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtil().backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Username',
                        style: TextStyle(
                          color: ColorsUtil().greyTextColor,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Table(
                        children: [
                          const TableRow(children: [
                            Center(
                              child: Text(
                                '20',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                '13',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                              child: Text(
                                '31',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Center(
                              child: Text(
                                'Orders',
                                style: TextStyle(
                                    color: ColorsUtil().greyTextColor,
                                    fontSize: 15),
                              ),
                            ),
                            Center(
                              child: Text(
                                'In Cart',
                                style: TextStyle(
                                    color: ColorsUtil().greyTextColor,
                                    fontSize: 15),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Wishes',
                                style: TextStyle(
                                    color: ColorsUtil().greyTextColor,
                                    fontSize: 15),
                              ),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              indent: 50,
              endIndent: 50,
              thickness: 2,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 70,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Change Password',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Settings',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Delete Accound',
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.redAccent,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
