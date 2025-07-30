import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dimens.dart';
import '../providers/providers.dart';
import '../theme.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({
    Key? key,
    required this.list,
    required TabController tabController,
    this.isScrollable = false,
  }) : _tabController = tabController,
       super(key: key);

  final List<String> list;
  final TabController _tabController;
  final bool isScrollable;

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  int? _cachedFromIdx;
  int? _cachedToIdx;
  @override
  Widget build(BuildContext context) {
    CustomProvider customProvider = Provider.of<CustomProvider>(context);
    return Container(
      // width: double.infinity,
      decoration: BoxDecoration(
        color: widget.isScrollable ? Colors.transparent : Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(Spacing.dp * 5),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        tabs: widget.list
            .asMap()
            .entries
            .map(
              (entry) => AnimatedBuilder(
                animation: widget._tabController.animation as Animation<double>,
                builder: (ctx, snapshot) {
                  final forward = widget._tabController.offset > 0;
                  final backward = widget._tabController.offset < 0;
                  int _fromIndex;
                  int _toIndex;
                  double progress;

                  // This value is true during the [animateTo] animation that's triggered when the user taps a [TabBar] tab.
                  // It is false when [offset] is changing as a consequence of the user dragging the [TabBarView].
                  if (widget._tabController.indexIsChanging) {
                    _fromIndex = widget._tabController.previousIndex;
                    _toIndex = widget._tabController.index;
                    _cachedFromIdx = widget._tabController.previousIndex;
                    _cachedToIdx = widget._tabController.index;
                    progress =
                        (widget._tabController.animation!.value - _fromIndex)
                            .abs() /
                        (_toIndex - _fromIndex).abs();
                  } else {
                    if (_cachedFromIdx == widget._tabController.previousIndex &&
                        _cachedToIdx == widget._tabController.index) {
                      // When user tap on a tab bar and the animation is completed, it will execute this block
                      // This block will not be called when user draging the TabBarView
                      _fromIndex = _cachedFromIdx!;
                      _toIndex = _cachedToIdx!;
                      progress = 1;
                      _cachedToIdx = null;
                      _cachedFromIdx = null;
                    } else {
                      _cachedToIdx = null;
                      _cachedFromIdx = null;
                      _fromIndex = widget._tabController.index;
                      _toIndex = forward
                          ? _fromIndex + 1
                          : backward
                          ? _fromIndex - 1
                          : _fromIndex;
                      progress =
                          (widget._tabController.animation!.value - _fromIndex)
                              .abs();
                    }
                  }

                  return Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: entry.key == _fromIndex
                          ? Color.lerp(
                              primaryColor,
                              widget.isScrollable
                                  ? primaryColor
                                  : Colors.transparent,
                              progress,
                            )
                          : entry.key == _toIndex
                          ? Color.lerp(
                              widget.isScrollable
                                  ? primaryColor
                                  : Colors.transparent,
                              primaryColor,
                              progress,
                            )
                          : Color.lerp(
                              widget.isScrollable
                                  ? Colors.transparent
                                  : Colors.transparent,
                              widget.isScrollable
                                  ? Colors.transparent
                                  : Colors.transparent,
                              progress,
                            ),
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: subtitleColor),
                    ),
                    child: Center(
                      child: Text(
                        entry.value,
                        style: subtitleTextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: medium,
                          color: entry.key == _fromIndex
                              ? Colors.white
                              : entry.key == _toIndex
                              ? Colors.white
                              : subtitleColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // child: CustomText.smRegular(
                      //   entry.value,
                      //   textAlign: TextAlign.center,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      // child: Text(
                      //   entry.value,
                      //   style: const TextStyle(
                      //     fontFamily: FontFamily.lato,
                      //     fontSize: 16- 1,
                      //   ),
                      //   textAlign: TextAlign.center,
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                    ),
                  );
                },
              ),
            )
            .toList(),
        controller: widget._tabController,
        isScrollable: widget.isScrollable,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 0,
        indicator: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        physics: const BouncingScrollPhysics(),
        unselectedLabelColor: Colors.blueGrey[400],
        labelColor: Colors.white,
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        labelPadding: EdgeInsets.symmetric(
          horizontal: widget.isScrollable ? 5 : Spacing.xs,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.isScrollable
              ? Spacing.lg - 5
              : EdgeInsets.zero.horizontal,
          vertical: widget.isScrollable ? Spacing.dp + 2 : Spacing.xs,
        ),
        onTap: (int index) {
          customProvider.currentIndex == index;
          // context.read<CustomNavCubit>().updateIndex(index);
          setState(() {});
        },
      ),
    );
  }
}
