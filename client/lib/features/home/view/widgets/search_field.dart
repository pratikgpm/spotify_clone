import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const SearchField({super.key, this.onTap, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: Pallete.transparentColor)),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: const Icon(
          Icons.search_sharp,
          color: Colors.black,
        ),
        hintText: "What do you want to listen to?",
        hintStyle: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 17,
            fontWeight: FontWeight.w500),
        filled: true,
        fillColor: Pallete.whiteColor,
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

}
Widget CircularNameIcon(String letter )
{
  return    CircleAvatar(
    child: Text(letter,
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20),
    ),
    backgroundColor: Colors.deepOrangeAccent,
    radius: 18,
  );
}

Widget topicContainer(String topic, [bool isSelected = false]){
  return Flexible(
    child: Container(
      margin: const EdgeInsets.only(left: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
        child: Text(topic,style: TextStyle(color: isSelected ? Pallete.backgroundColor: Pallete.whiteColor,fontSize: 12),),
      ),
      decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.green : Color(0xff212121),
      ),
    ),
  );
}