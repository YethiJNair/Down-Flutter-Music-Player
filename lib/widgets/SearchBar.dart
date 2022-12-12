import 'package:flutter/material.dart';
import 'package:down/screens/search_screen.dart';

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
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: TextFormField(
          // autofocus: false,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenSearch(),
            ));
          },
          decoration: InputDecoration(
            filled: true,
            isDense: false,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
            prefixIcon: const Icon(Icons.search),
            hintText: "Search",
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1, color: Color.fromARGB(255, 255, 255, 255)),
                borderRadius: BorderRadius.circular(8) //<-- SEE HERE
                ),
          ),
        ),
      ),
    );
  }
}
