import 'package:api_implementation/Data%20Provider/data_provider.dart';
import 'package:api_implementation/Model%20Classes/Engadget/Content.dart';
import 'package:flutter/material.dart';

class AppleNewsScreen extends StatefulWidget {
  const AppleNewsScreen({super.key});

  @override
  State<AppleNewsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AppleNewsScreen> {
  Autogenerated? news;
  static const String applenewslink =
      "https://newsapi.org/v2/everything?q=apple&from=2023-08-09&to=2023-08-09&sortBy=popularity&apiKey=f62ad3fc4a9244909065a931c8680bb5";
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final data = await DataProvider.getNews(applenewslink);
    setState(() {
      news = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text("Apple News")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: news == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...news!.articles!.map(
                      (article) => ListTile(
                        title: Text(article.title ?? ""),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(article.author ?? ""),
                            const SizedBox(height: 10),
                            Text(article.description ?? ""),
                            const SizedBox(height: 15),
                            article.urlToImage != null
                                ? Image.network(
                                    article.urlToImage!,
                                    width: 400,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                            const SizedBox(height: 10),
                            const Divider(
                              thickness: 3.0,
                              color: Colors.yellowAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
