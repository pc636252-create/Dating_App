import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/user_profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../routes/app_routes.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserDetailController>();
    final user = controller.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: Get.height*0.4,
            pinned: false,
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.photoViewer, arguments: user),
                    child: Obx(() => CachedNetworkImage(
                      imageUrl: user.photos[controller.selectedPhotoIndex.value],
                      fit: BoxFit.cover,
                    )),
                  ),
                  Row(
                    children: List.generate(user.photos.length, (i) {
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => controller.selectPhoto(i),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 12,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _roundBtn(Icons.close, Colors.orange, () => Get.back()),
                        const SizedBox(width: 20),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color:  Color(0xFFD60101),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            color:  Color(0xFFEDEBEB),
                            size: 30,
                          ),
                        ),
                      ),
                        const SizedBox(width: 20),
                        _roundBtn(Icons.star, const Color(0xFF7C4DFF), () => Get.back(result: true)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('${user.name}, ${user.age}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            ),
                            if (user.isOnline)
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.black.withOpacity(0.03),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.send_outlined,
                                  color: Colors.redAccent,
                                  size: 19,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(user.profession, style: const TextStyle(color: AppColors.textGrey, fontSize: 15)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            Expanded(child: Text(user.location, style: const TextStyle(color: AppColors.textGrey))),
                            SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.08),
                                borderRadius:
                                BorderRadius.circular(7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.redAccent,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${user.distanceKm.toString()}',
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                        const Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        Obx(() => Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.about,
                                maxLines:
                                controller.aboutExpanded.value
                                    ? null
                                    : 3,
                                overflow:
                                controller.aboutExpanded.value
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  height: 1.55,
                                ),
                              ),
                              const SizedBox(height: 4),

                              GestureDetector(
                                onTap: controller.toggleAbout,

                                child: Text(
                                  controller.aboutExpanded.value
                                      ? "Read less"
                                      : "Read more",

                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text('Interests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 7,
                          runSpacing: 8,
                          children: user.interests.map(
                                (interest) {

                              final bool selected =
                                  interest == "Traveling" ||
                                      interest == "Books";
                              return _buildInterestChip(
                                interest,
                                selected,
                              );
                            },
                          ).toList(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            TextButton(
                              onPressed: () {},
                              child: const Text('See all', style: TextStyle(color: Colors.redAccent)),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: Get.height*0.4,
                          width: Get.width,
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: user.photos.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 7,
                              crossAxisSpacing: 7,
                            ),
                            itemBuilder: (context, i) => GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.photoViewer, arguments: user),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: CachedNetworkImage(
                                  imageUrl: user.photos[i],
                                  width: 85,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )

                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundBtn(
      IconData icon,
      Color color,
      VoidCallback onTap,
      {bool big = false}) {
    final size = big ? 64.0 : 52.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 10)],
        ),
        child: Icon(icon, color: color, size: big ? 30 : 24),
      ),
    );
  }

  Widget _buildInterestChip(
      String label,
      bool highlighted,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: highlighted
            ? Colors.redAccent.withOpacity(0.03)
            : Colors.white,

        borderRadius: BorderRadius.circular(6),

        border: Border.all(
          color: highlighted
              ? Colors.redAccent.withOpacity(0.45)
              : Colors.grey.shade200,
        ),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [

          if (highlighted) ...[
            const Icon(
              Icons.check,
              color: Colors.redAccent,
              size: 11,
            ),

            const SizedBox(width: 3),
          ],

          Text(
            label,

            style: TextStyle(
              color: highlighted
                  ? Colors.redAccent
                  : Colors.grey.shade700,

              fontSize: 11,

              fontWeight: highlighted
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
