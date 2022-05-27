
import 'package:flutter/material.dart';
import 'package:flutter_test_app/components/NavigationService.dart';
import 'package:flutter_test_app/screens/AdvertismentScreen.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewPhotoWidget extends StatefulWidget {
  int currentImageNumber;
  final imagesList;

  ViewPhotoWidget({Key? key, required this.currentImageNumber, required this.imagesList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewPhotoWidgetState();
}

class _ViewPhotoWidgetState extends State<ViewPhotoWidget> {
  late PageController _pageController;
  bool arrowBackIsHidden = true;

  var titleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    color: Colors.white,
    fontFamily: 'SF Pro Display',
  );

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentImageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Colors.black,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: (!arrowBackIsHidden) ? 0.0 : 1.0,
              child: AppBar(
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(
                    "${widget.currentImageNumber + 1}" + " из " + "${widget.imagesList.length}",
                    style: titleStyle,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: (!arrowBackIsHidden) ? null : () => NavigationService.instance.goback(),
                  ),
                ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => setState(() {
            arrowBackIsHidden = !arrowBackIsHidden;
          }),
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(bottom: 100),
            child: PhotoViewGallery.builder(
              itemCount: widget.imagesList.length,
              pageController: _pageController,
              builder: (context, index) {
                final urlImage = widget.imagesList[index];
								
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(urlImage),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              onPageChanged: (index) => setState(() {
                widget.currentImageNumber = index;
								AdvertismentScreen.buttonCarouselController.animateToPage(index);
              }),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      );
}

