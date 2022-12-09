import 'package:down/colors/colors.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * .055,
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, right: 15, top: 8, bottom: 8),
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            isDense: false,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            fillColor: cyan,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: cyan),
                borderRadius: BorderRadius.circular(8) //<-- SEE HERE
                ),
          ),
        ),
      ),
    );
  }
}
