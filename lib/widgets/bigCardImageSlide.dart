import 'package:flutter/material.dart';

class BigCardImageSlide extends StatefulWidget {
  const BigCardImageSlide({
    super.key,
    required this.images,
  });

  final List images;

  @override
  State<BigCardImageSlide> createState() => _BigCardImageSlideState();
}

class _BigCardImageSlideState extends State<BigCardImageSlide> {
  int intialIndex = 0;

  @override
  initState() {
    super.initState();
    timer();
  }

  PageController pageController = PageController();

  timer() {
    Future.delayed(const Duration(seconds: 2), () {
      print(pageController.page!.toInt());
      if (pageController.page!.toInt() < widget.images.length - 1) {
        pageController.animateToPage(pageController.page!.toInt() + 1,
            duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      } else {
        pageController.animateToPage(0,
            duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      }
      setState(() {});
      timer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.81,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                intialIndex = value;
              });
            },
            controller: pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) =>
                BigCardImage(image: widget.images[index]),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: List.generate(
                widget.images.length,
                (index) => DotIndicator(
                  isActive: intialIndex == index,
                  activeColor: Colors.white,
                  inActiveColor: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: BoxFit.fitHeight,
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = const Color(0xFF22A45D),
    this.inActiveColor = const Color(0xFF868686),
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 5,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
