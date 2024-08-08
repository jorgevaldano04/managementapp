import 'package:flutter/material.dart';
import 'package:task_management_app/app/utils/style/AppColors.dart';
import 'package:get/get.dart';

class ProfileW extends StatelessWidget {
  const ProfileW({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: !context.isPhone
          ? const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 150,
                      foregroundImage: NetworkImage('url'),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jorge Valdano',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 40),
                      ),
                      Text(
                        'Jorgevaldano04@gmail.com',
                        style: TextStyle(
                            color: AppColors.primaryText, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 150,
                        foregroundImage: NetworkImage('url'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Jorge Valdano',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 40),
                  ),
                  Text(
                    'Jorgevaldano04@gmail.com',
                    style:
                        TextStyle(color: AppColors.primaryText, fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
