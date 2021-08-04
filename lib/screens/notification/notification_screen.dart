import 'package:at_wavi_app/common_components/contact_initial.dart';
import 'package:at_wavi_app/utils/colors.dart';
import 'package:at_wavi_app/utils/text_styles.dart';
import 'package:at_wavi_app/view_models/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<NotificationProvider>(builder: (context, _provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification',
                style: CustomTextStyles.blackBold(size: 18),
              ),
              SizedBox(
                height: 15,
              ),
              _provider.notifications.isEmpty
                  ? Text('No notifications')
                  : Expanded(
                      child: ListView.separated(
                        itemCount: _provider.notifications.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _provider.notifications[index].image != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      child: Image.memory(
                                        _provider.notifications[index].image!,
                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : ContactInitial(
                                      initials: _provider
                                          .notifications[index].fromAtsign,
                                      size: 55,
                                    ),
                              SizedBox(width: 12),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _provider.notifications[index].message,
                                        style: CustomTextStyles.black(size: 14),
                                        maxLines: 3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      DateTime.now()
                                              .difference(_provider
                                                  .notifications[index]
                                                  .dateTime)
                                              .inMinutes
                                              .toString() +
                                          ' mins ago',
                                      style: CustomTextStyles.customTextStyle(
                                          ColorConstants.LIGHT_GREY,
                                          size: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                      ),
                    )
            ],
          ),
        );
      }),
    );
  }
}
