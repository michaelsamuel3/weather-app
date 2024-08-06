//         Container(
//   height: 50,
//   width: double.infinity,
//   child: Consumer<LocationProvider>(
//     builder: (context, locationProvider, child) {
//       var locationcity;
//       if (locationProvider.currentLocationName != null) {
//         locationcity = locationProvider
//             .currentLocationName!.administrativeArea;
//       } else {
//         locationcity = "Unknown location";
//       }

//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             Icons.location_pin,
//             color: Colors.red,
//             size: 40,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppText(
//                 data: locationcity.isEmpty
//                     ? "Unknown location"
//                     : locationcity,
//                 color: Colors.black,
//                 fw: FontWeight.bold,
//                 size: 25,
//               ),
//               AppText(
//                   data: "good morning",
//                   color: Colors.black,
//                   fw: FontWeight.bold,
//                   size: 18)
//             ],
//           ),
//           SizedBox(
//             width: 150,
//             height: 20,
//           ),
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   clicked = !clicked;
//                 });
//               },
//               icon: Icon(
//                 Icons.search,
//                 size: 30,
//                 color: Colors.black,
//               ))
//         ],
//       );
//     },
//   ),
// ),
