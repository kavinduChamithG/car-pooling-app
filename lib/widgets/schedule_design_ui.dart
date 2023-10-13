import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Scheduled_Ride_model.dart';

class ScheduleDesignUIWidget extends StatefulWidget {

  ScheduledRideModel? scheduledRideModel;

  ScheduleDesignUIWidget({this.scheduledRideModel});

  @override
  State<ScheduleDesignUIWidget> createState() => _ScheduleDesignUIWidgetState();
}

class _ScheduleDesignUIWidgetState extends State<ScheduleDesignUIWidget> {
  // String formatDateAndTime(String dateTimeFromDB)
  // {
  //   DateTime dateTime = DateTime.parse(dateTimeFromDB);
  //
  //   // Dec 10                            //2022                         //1:12 pm
  //   String formattedDatetime = "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";
  //
  //   return formattedDatetime;
  // }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                const Icon(
                  Icons.account_box,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 12,),

                Text(
                  widget.scheduledRideModel!.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Icon(
                  Icons.date_range,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 12,),

                Text(
                  widget.scheduledRideModel!.date!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            //driver name + Fare Amount
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 6.0),
            //       child: Text(
            //         "Start Location : " + widget.scheduledRideModel!.driverName!,
            //         style: const TextStyle(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //
            //     const SizedBox(width: 12,),
            //
            //     Text(
            //       "\$ " + widget.scheduledRideModel!.fareAmount!,
            //       style: const TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 2,),

            // seat details
            Row(
              children: [
                const Icon(
                  Icons.event_seat_rounded,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 12,),

                Text(
                  widget.scheduledRideModel!.seats_available!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),

            //icon + pickup
            Row(
              children: [

                Image.asset(
                  "images/origin.png",
                  height: 26,
                  width: 26,
                ),

                const SizedBox(width: 12,),

                Expanded(
                  child: Container(
                    child: Text(
                      widget.scheduledRideModel!.start_location!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 14,),

            //icon + dropOff
            Row(
              children: [

                Image.asset(
                  "images/destination.png",
                  height: 24,
                  width: 24,
                ),

                const SizedBox(width: 12,),

                Expanded(
                  child: Container(
                    child: Text(
                      widget.scheduledRideModel!.end_location!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 14,),

            //trip time and date
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(""),
            //     Text(
            //       //formatDateAndTime(widget.scheduledRideModel!.time!),
            //       widget.scheduledRideModel!.time!,
            //       style: const TextStyle(
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 2,),

          ],
        ),
      ),
    );
  }
}
