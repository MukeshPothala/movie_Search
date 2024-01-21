import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_search_app/components/input_text_field.dart';
import 'package:movie_search_app/components/movie_card.dart';
import 'package:movie_search_app/contants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieCard> display_list = List.from(movies_list);
  void upDateList(String val) {
    // this function will filter out our list
    setState(() {
      display_list = movies_list
          .where((element) =>
              element.movieTitle!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Movie Search"),
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: Icon(Icons.logout_sharp))
        ],
        backgroundColor: Colors.grey.shade300,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              onChanged: (value) => upDateList(value),
              placeHolder: "Enter movie name",
              obscureText: false,
              prefixIcon: const Icon(Icons.search),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: display_list.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Center(child: Text("Movie not found ")),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 25.0),
                          title: Text(
                            display_list[index].movieTitle!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '${display_list[index].releaseYear!}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Text('${display_list[index].rating}'),
                          leading: Image.network(
                            display_list[index].posterURL!,
                            height: 300,
                          ),
                        );
                      }),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
