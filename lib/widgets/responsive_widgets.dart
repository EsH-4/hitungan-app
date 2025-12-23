import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';
import '../config/app_colors.dart';
import '../config/app_dimensions.dart';
import '../styles/app_text_styles.dart';
import '../styles/app_decorations.dart';

/// Widget untuk responsive container
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final double? maxWidth;
  final bool centerContent;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.maxWidth,
    this.centerContent = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    final responsiveMargin = margin ?? ResponsiveUtils.getResponsiveMargin(context);


    return Container(
      padding: responsivePadding,
      margin: responsiveMargin,
      decoration: decoration,
      child: child,
    );
  }
}

/// Widget untuk responsive grid
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveSpacing = ResponsiveUtils.getResponsiveSpacing(context, spacing);
    final responsiveRunSpacing = ResponsiveUtils.getResponsiveSpacing(context, runSpacing);

    return Wrap(
      spacing: responsiveSpacing,
      runSpacing: responsiveRunSpacing,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: children,
    );
  }
}

/// Widget untuk responsive card
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  const ResponsiveCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(context);
    final responsiveMargin = margin ?? EdgeInsets.zero;
    final responsiveDecoration = decoration ?? AppDecorations.card;

    Widget card = Container(
      padding: responsivePadding,
      margin: responsiveMargin,
      decoration: responsiveDecoration,
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsiveBorderRadius(context, AppDimensions.radiusL),
          ),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// Widget untuk responsive text
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? responsiveStyle = style;
    
    if (style != null && style!.fontSize != null) {
      final responsiveFontSize = ResponsiveUtils.getResponsiveFontSize(context, style!.fontSize!);
      responsiveStyle = style!.copyWith(
        fontSize: responsiveFontSize > 0 ? responsiveFontSize : 14.0,
      );
    }

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Widget untuk responsive icon
class ResponsiveIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const ResponsiveIcon(
    this.icon, {
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveSize = size != null 
        ? ResponsiveUtils.getResponsiveIconSize(context, size!)
        : ResponsiveUtils.getResponsiveIconSize(context, AppDimensions.iconM);

    return Icon(
      icon,
      color: color,
      size: responsiveSize > 0 ? responsiveSize : 24.0,
    );
  }
}

/// Widget untuk responsive button
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonStyle? style;
  final bool isFullWidth;

  const ResponsiveButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.style,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsivePadding = ResponsiveUtils.getResponsiveSpacing(context, 16.0);
    
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: responsivePadding,
          vertical: ResponsiveUtils.getResponsiveSpacing(context, 12.0),
        ),
      ),
      child: Row(
        mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            ResponsiveIcon(icon!),
            SizedBox(width: ResponsiveUtils.getResponsiveSpacing(context, 8.0)),
          ],
          ResponsiveText(
            text,
            style: AppTextStyles.buttonMedium,
          ),
        ],
      ),
    );

    if (isFullWidth) {
      button = SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }
}

/// Widget untuk responsive app bar
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  const ResponsiveAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ResponsiveText(
        title,
        style: AppTextStyles.header3,
      ),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      elevation: ResponsiveUtils.getResponsiveElevation(context, 0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Widget untuk responsive floating action button
class ResponsiveFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const ResponsiveFloatingActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsiveSize = ResponsiveUtils.getResponsiveIconSize(context, 28.0);
    
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: foregroundColor ?? AppColors.textWhite,
      child: ResponsiveIcon(
        icon,
        size: responsiveSize,
      ),
    );
  }
}
