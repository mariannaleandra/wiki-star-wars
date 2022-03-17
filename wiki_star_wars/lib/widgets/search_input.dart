import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final void Function(String)? onSearch;

  const SearchInput({
    final Key? key,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: onSearch,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onSearch,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColorLight,
            width: 3.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 3.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        hintText: 'Search...',
        hintStyle: theme.textTheme.headline2!.apply(
          color: theme.primaryColorDark,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        suffixIcon: Icon(
          Icons.search,
          size: theme.iconTheme.size,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
