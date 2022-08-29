import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget items(item, context, index) => Container(
      color: NewsApp.get(context).selectedItem == index &&
              NewsApp.get(context).isDesktop
          ? Colors.grey[200]
          : null,
      child: InkWell(
        onTap: () {
          //for mobile

          //navigation(context, WebViewScreen(item['url']));

          //for desktop

          NewsApp.get(context).changeSelectedItem(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      '${item['urlToImage']}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${item['title']}',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${item['publishedAt']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildConBilder(List list, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (BuildContext context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return items(list[index], context, index);
        },
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              width: double.infinity,
              height: 1.5,
              color: Colors.grey,
            ),
          );
        },
        itemCount: list.length,
      ),
      fallback: (context) => Center(
        child: (isSearch) ? Container() : CircularProgressIndicator(),
      ),
    );

Widget defultTextFormFeild({
  required String? Function(String?) validate,
  required TextEditingController control,
  required TextInputType type,
  bool obscure = false,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? show,
  VoidCallback? tap,
  VoidCallback? submit(String)?,
  VoidCallback? change(String)?,
}) =>
    TextFormField(
      validator: validate,
      controller: control,
      keyboardType: type,
      obscureText: obscure,
      onTap: tap,
      onChanged: change,
      onFieldSubmitted: submit,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: (suffix == null)
            ? null
            : IconButton(
                onPressed: show,
                icon: Icon(suffix),
              ),
        border: OutlineInputBorder(),
      ),
    );

Future navigation(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
