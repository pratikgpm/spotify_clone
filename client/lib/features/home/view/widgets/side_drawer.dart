import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
class SliderDrawer extends ConsumerWidget {
  const SliderDrawer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundColor: Colors.deepOrange,radius: 40,),
              SizedBox(height: 10,),
              Divider(height: 10,),
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
                  onPressed: () {

              }, child: Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
