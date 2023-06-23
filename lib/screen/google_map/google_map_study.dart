import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapStudy extends StatefulWidget {
  const GoogleMapStudy({super.key});

  @override
  State<GoogleMapStudy> createState() => _GoogleMapStudyState();
}

/*
* GoogleMap(구글맵), Geolocator(내 위치 가져오는 라이브러리) 사용
* */
class _GoogleMapStudyState extends State<GoogleMapStudy> {
  // latitude - 위도, longitude - 경도
  static final LatLng companyLatLng = LatLng(
    37.5233273,
    126.921252,
  );

  // 확대(zoom) level => CameraPosition : 위성이 위에서 내려다보는 시점
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLatLng,
    zoom: 15, // 확대정도 설정
  );

  static final double okDistance = 100; // m

  static final Circle withInDistanceCircle = Circle(
    circleId: CircleId('withInDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  static final Circle notWithInDistanceCircle = Circle(
    circleId: CircleId('notWithInDistanceCircle'),
    center: companyLatLng,
    fillColor: Colors.red.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.red,
    strokeWidth: 1,
  );

  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    center: companyLatLng,
    fillColor: Colors.green.withOpacity(0.5),
    radius: okDistance,
    strokeColor: Colors.green,
    strokeWidth: 1,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('markerId'),
    position: companyLatLng,
  );

  bool choolCheckDone = false;

  GoogleMapController? mapController;

  Future<String> checkPermission() async {
    // 핸드폰 자체의 위치서비스가 켜져있는지 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) return '위치 서비스를 활성화 해주세요.';

    // 현재 앱에 대한 위치권한 설정정보
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if (checkedPermission == LocationPermission.denied) {
      // default상태
      checkedPermission = await Geolocator.requestPermission(); // 권한 요청버튼을 띄움

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }

    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 세팅해서 허가해주세요.';
    }

    return '위치 권한이 허가 되었습니다.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘도 출근'),
        actions: [
          IconButton(onPressed: () async { // 현재 위치로 맵 이동

            if(mapController == null) return;

            final location = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)));

          }, icon: Icon(Icons.my_location)),
        ],
      ),
      body: FutureBuilder<String>(
        // snapshot.data의 타입
        // async의 결과가 리턴되면 반영됨
        future: checkPermission(),
        builder: (context, snapshot) {
          print(snapshot.data); // future의 결과값을 받아옴

          // async니까 connection state(waiting, done)
          print(snapshot.connectionState);

          if(!snapshot.hasData) return CircularProgressIndicator();
          
          // 캐싱되기 때문에 아래처럼 안하는게 좋음
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CircularProgressIndicator();
          // }

          if (snapshot.data == '위치 권한이 허가 되었습니다.') {
            return StreamBuilder<Position>(
              // getPositionStream에서 리턴하는 반환형
                stream: Geolocator.getPositionStream(), // 현재위치가 변경될 때마다 가져옴
                builder: (context, snapshot) {
                  bool isWithinRange = false;

                  if (snapshot.hasData) {
                    // 현재 내 위치
                    final start = snapshot.data!;
                    final end = companyLatLng; // 회사의 위치

                    final distance = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );

                    if (distance < okDistance) {
                      // 반경 안에 있는 경우
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        circleArea: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                            ? withInDistanceCircle
                            : notWithInDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _ChoolCheckBtn(
                          isWithinRange: isWithinRange,
                          onPressed: onChoolCheckPressed,
                          choolCheckDone: choolCheckDone),
                    ],
                  );
                });
          }

          return Center(
            child: Text(snapshot!.data!),
          );
        },
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onChoolCheckPressed() async {
    // MaterialDialog
    final result = await showDialog(
      // 다이얼로그도 새 화면이라 생각하면 됨(Navigator)
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('출근하기'),
            )
          ],
        );
      },
    );

    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circleArea;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap({required this.initialPosition,
    required this.circleArea,
    required this.marker,
    required this.onMapCreated,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2, // 차지하는 비율 지정
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circleArea]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
    );
  }
}

class _ChoolCheckBtn extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckBtn({required this.isWithinRange,
    required this.onPressed,
    required this.choolCheckDone,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timelapse_outlined,
              size: 50.0,
              color: choolCheckDone
                  ? Colors.green
                  : isWithinRange
                  ? Colors.blue
                  : Colors.red,
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (!choolCheckDone && isWithinRange)
              ElevatedButton(
                onPressed: onPressed,
                child: Text('출근하기'),
              )
          ],
        ));
  }
}
