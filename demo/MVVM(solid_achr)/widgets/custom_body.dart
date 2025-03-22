import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_admin/controllers/controllers.dart' as drawer_controller;
import 'package:zero_admin/data/data.dart';
import 'package:zero_admin/res/res.dart';
import 'package:zero_admin/utils/utils.dart';
import 'package:zero_admin/widgets/widgets.dart';

class CustomBody extends StatelessWidget {
  final Widget Function(
          BuildContext context, bool isMobile, bool isTablet, bool isDesktop)
      bodyBuilder;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottomAppBar;
  final Widget? bottomNavigationBar;

  const CustomBody({
    super.key,
    required this.bodyBuilder,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.bottomAppBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<drawer_controller.DrawerController>();

    return Scaffold(
      drawer: MediaQuery.of(context).size.width < 1200
          ? drawerController.drawer
          : null,
      backgroundColor: backgroundColor ?? Colors.grey[100],
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1200;
          final isTablet =
              constraints.maxWidth >= 600 && constraints.maxWidth < 1200;
          final isMobile = constraints.maxWidth < 600;

          return Column(
            children: [
              _buildTopBar(context, isMobile),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show drawer permanently only on desktop
                    if (isDesktop) drawerController.drawer,

                    // Main Content Area - Pass responsive flags to the builder
                    Expanded(
                      child:
                          bodyBuilder(context, isMobile, isTablet, isDesktop),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isMobile) {
    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          // Hamburger menu for mobile/tablet or back button
          if (MediaQuery.of(context).size.width < 1200)
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              )
            else
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),

          // Logo
          if (!isMobile)
            Padding(
              padding: Dimens.edgeInsets4,
              child: Image.asset(
                AssetConstants.loginLogo,
                height: 40,
              ),
            ),

          // Search Bar
          // Expanded(
          //   child: Container(
          //     height: 50,
          //     width: Get.width * 0.2,
          //     margin: EdgeInsets.symmetric(
          //       horizontal: isMobile ? 8 : 16,
          //     ),
          //     child: CustomTextfield(
          //       onChange: (value) {},
          //       hintText: 'Search...',
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: Colors.grey[600],
          //         size: 18,
          //       ),
          //       hintStyle: Styles.grey11.copyWith(
          //         fontSize: 15,
          //       ),
          //       contentPadding: EdgeInsets.zero,
          //     ),
          //   ),
          // ),
          // Dimens.boxWidth16,
          const Spacer(),
          // Custom actions
          if (actions != null && actions!.isNotEmpty) ...actions!,

          // Default Right Side Icons - Responsive
          if (!isMobile && (actions == null || actions!.isEmpty)) ...[
            IconButton(
              icon: const Icon(Icons.grid_view_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.fullscreen_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.dark_mode_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
          ],

          // Profile Section
          Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  showProfileMenu(context, isMobile);
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        child: Padding(
                          padding: Dimens.edgeInsets4,
                          child: Image.asset(
                            AssetConstants.profileUser,
                          ),
                        ),
                      ),
                      if (!isMobile) ...[
                        Dimens.boxWidth8,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rasmiranjan',
                              style: Styles.black12.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Founder',
                              style: Styles.grey11.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Dimens.boxWidth4,
                        Icon(
                          Icons.arrow_drop_down,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void showProfileMenu(BuildContext context, bool isMobile) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final buttonPosition = button.localToGlobal(Offset.zero);
    final buttonSize = button.size;

    final overlaySize = overlay.size;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              right: isMobile
                  ? overlaySize.width - buttonPosition.dx - 40
                  : overlaySize.width - buttonPosition.dx - buttonSize.width,
              top: buttonPosition.dy + buttonSize.height + 8,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // User info section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Padding(
                                padding: Dimens.edgeInsets4,
                                child: Image.asset(
                                  AssetConstants.profileUser,
                                ),
                              ),
                            ),
                            Dimens.boxWidth12,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rasmiranjan',
                                    style: Styles.black14w500.copyWith(
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Founder',
                                    style: Styles.grey11.copyWith(
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Menu items
                      InkWell(
                        onTap: () {
                          Get.back();
                          // Navigate to profile
                          // Get.toNamed(Routes.profile);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Colors.grey[700],
                                size: 20,
                              ),
                              Dimens.boxWidth12,
                              Text(
                                'Profile',
                                style: Styles.black14.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),

                      InkWell(
                        onTap: () {
                          Get.back();
                          _showLogoutConfirmationDialog(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_outlined,
                                color: Colors.red[700],
                                size: 20,
                              ),
                              Dimens.boxWidth12,
                              Text(
                                'Log Out',
                                style: Styles.black14.copyWith(
                                  color: Colors.red[700],
                                  fontSize: 14,
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
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: Get.width * 0.3,
            padding: Dimens.edgeInsets16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: Colors.red[400],
                  size: 48,
                ),
                Dimens.boxHeight16,
                Text(
                  'Log Out',
                  style: Styles.black16w600.copyWith(
                    fontSize: 16,
                  ),
                ),
                Dimens.boxHeight8,
                Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: Styles.grey11.copyWith(
                    fontSize: 14,
                  ),
                ),
                Dimens.boxHeight24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 50,
                        title: 'Cancel',
                        buttonType: ButtonType.secondary,
                        style: Styles.black12w500.copyWith(
                          fontSize: 13,
                        ),
                        onTap: Get.back,
                      ),
                    ),
                    Dimens.boxWidth16,
                    Expanded(
                      child: CustomButton(
                        height: 50,
                        title: 'Log Out',
                        style: Styles.black12w500.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        onTap: () {
                          final dbWrapper = Get.find<DBWrapper>();
                          Get.back();
                          dbWrapper.clearAll();
                          RouteManagement.goOfAllSplash();
                          Get.offAllNamed(Routes.login);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
