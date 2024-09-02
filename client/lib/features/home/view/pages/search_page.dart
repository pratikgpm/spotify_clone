import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/home/view/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
            body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CircleAvatar(
                  child: Text('P',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  backgroundColor: Colors.deepOrangeAccent,
                  radius: 18,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Search',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Pallete.whiteColor,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SearchField(),
          ],
        )),
      ),
    );
  }
}
