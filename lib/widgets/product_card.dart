import 'package:flutter/material.dart';
import '../pages/pages.dart';
import '../models/models.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product)),
        );
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(right: defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffECEDEF),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            product.galleries!.isNotEmpty
                ? Image.network(
                    product.galleries![0].url!,
                    height: 150,
                    width: 215,
                    loadingBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          final totalBytes =
                              loadingProgress?.expectedTotalBytes;
                          final bytesLoaded =
                              loadingProgress?.cumulativeBytesLoaded;
                          if (totalBytes != null && bytesLoaded != null) {
                            return SizedBox(
                              height: 150,
                              width: 215,
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                  value: bytesLoaded / totalBytes,
                                  color: Colors.blue[900],
                                  strokeWidth: 5.0,
                                ),
                              ),
                            );
                          } else {
                            return child;
                          }
                        },
                    frameBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          int? frame,
                          bool wasSynchronouslyLoaded,
                        ) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          BuildContext context,
                          Object exception,
                          StackTrace? stackTrace,
                        ) {
                          return SizedBox(
                            height: 150,
                            width: 215,
                            child: Center(child: const Text('😢')),
                          );
                        },
                  )
                : Image.asset(
                    'assets/no_image_available.jpg',
                    width: 215,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category!.name!,
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Text(
                    product.name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 6),
                  Text(
                    '\$${product.price}',
                    style: priceTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
