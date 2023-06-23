import 'package:drift/drift.dart' show Value; // drift와 플루터 모두 Column이 있어 충돌남
  // 따라서 drift는 Value만 사용하도록 show 키워드 붙여줌
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:study/screen/schedule_app/component/custom_text_field.dart';
import 'package:study/screen/schedule_app/constant/color.dart';
import 'package:study/screen/schedule_app/database/drift_database.dart';
import 'package:study/screen/schedule_app/model/category_color.dart';

class NewScheduleBtnSheet extends StatefulWidget {

  final DateTime selectedDate;

  final int? scheduleId;

  const NewScheduleBtnSheet({required this.selectedDate, this.scheduleId, super.key});

  @override
  State<NewScheduleBtnSheet> createState() => _NewScheduleBtnSheetState();
}

class _NewScheduleBtnSheetState extends State<NewScheduleBtnSheet> {

  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    // 입력상자가 있어 키보드가 올라오면 올라온만큼 모달이 올라가줘야 사용자가 볼 수 있음(패딩)
    // 키보드 높이정보 가져와야함
    final bottomInset = MediaQuery.of(context)
        .viewInsets
        .bottom; // 시스템적인 부분이 차지하는 정보를 가져올 수 있음 : viewInsets

    return GestureDetector(
      onTap: () {
        // 빈곳 클릭시 포커스를 잃게해서 키보드를 사라지게 하는 방법
        // requestFocus에 아무것도 아닌 FocusNode전달시 포커스 상실됨
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<ScheduleData>(
        future: widget.scheduleId == null ? null : GetIt.I<LocalDatabase>().selectScheduleById(widget.scheduleId!),
        builder: (context, snapshot) {

          if(snapshot.hasError) {
            return Center(
              child: Text('스케줄을 불러올 수 없습니다.',),
            );
          }

          // FutureBuilder가 처음 실행됐고 로딩중일 때
          if(snapshot.connectionState != ConnectionState.none && !snapshot.hasData) {

            return Center(
              child: CircularProgressIndicator(),
            );

          }

          // Future가 실행이 되고 값이 있는데 단 한번도 startTime이 세팅되지 않았을 때
          if(snapshot.hasData && startTime == null) {

            startTime = snapshot.data!.startTime;
            endTime = snapshot.data!.endTime;
            content = snapshot.data!.content;
            selectedColorId = snapshot.data!.colorId;

          }

          return SafeArea(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 2 + bottomInset,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: Form(
                    // CustomField 안에 TextFormField를 관리하기 위해 추가
                    key: formKey,
                    autovalidateMode: AutovalidateMode.always, // 글자 입력할 때마다 validation 수행
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Time(
                          startInitialValue: startTime?.toString() ?? '',
                          endInitialValue: endTime?.toString() ?? '',
                          onStartTimeSaved: (newValue) {
                            startTime = int.parse(newValue!);
                          },
                          onEndTimeSaved: (newValue) {
                            endTime = int.parse(newValue!);
                          },
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        _Content(
                          initialValue: content ?? '',
                          onContentSaved: (newValue) {
                            content = newValue;
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        FutureBuilder<List<CategoryColor>>(
                            future: GetIt.I<LocalDatabase>().getCategoryColors(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                // 최초 선택값 세팅
                                if (selectedColorId == null) {
                                  selectedColorId = snapshot.data![0].id;
                                }

                                List<CategoryColor>? colorList = snapshot.data;

                                return _ColorPicker(
                                  colors: colorList!,
                                  selectedColorId: selectedColorId,
                                  colorIdSetter: (id) {
                                    setState(() {
                                      selectedColorId = id;
                                    });
                                  },
                                );
                              }
                              return Container();
                            }),
                        _SaveButton(
                          onPressed: onSaveBtnPressed,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void onSaveBtnPressed() async {
    // formKey는 생성을 했는대 Form 위젯과 결합을 안했을 때
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      // Form 하위 validator 함수 결과
      print('에러가 없습니다.');

      // save를 호출해주어야 onSaved 가 호출되게 됨.
      formKey.currentState!.save();

      if(widget.scheduleId == null) { // insert
        final key = await GetIt.I<LocalDatabase>().createSchedule(ScheduleCompanion(
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          colorId: Value(selectedColorId!),
        ));
      } else { // update
        await GetIt.I<LocalDatabase>().updateScheduleById(widget.scheduleId!, ScheduleCompanion(
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          colorId: Value(selectedColorId!),
        ));
      }

      Navigator.of(context).pop();

    } else {
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartTimeSaved;
  final FormFieldSetter<String> onEndTimeSaved;
  final String startInitialValue;
  final String endInitialValue;

  const _Time(
      {required this.onStartTimeSaved,
      required this.onEndTimeSaved,
        required this.startInitialValue,
        required this.endInitialValue,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              initialValue: startInitialValue,
          label: '시작 시간',
          isTime: true,
          onSaved: onStartTimeSaved,
        )),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: CustomTextField(
            initialValue: endInitialValue,
            label: '마감 시간',
            isTime: true,
            onSaved: onEndTimeSaved,
          ),
        )
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onContentSaved;
  final String initialValue;

  const _Content({required this.onContentSaved, required this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        initialValue: initialValue,
        label: '내용',
        isTime: false,
        onSaved: onContentSaved,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;

  final int? selectedColorId;

  final ColorIdSetter colorIdSetter;

  const _ColorPicker(
      {required this.colors, required this.selectedColorId, required this.colorIdSetter, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // Row는 갯수가 넘어가면 오류가 나지만 wrap은 자동개행됨
      spacing: 10, // 좌우 간격
      runSpacing: 10, // 위아래 간격
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(e, selectedColorId == e.id),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor colorVal, bool isSelectedId) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(int.parse('FF${colorVal.hexCode}', radix: 16)),
          border: isSelectedId
              ? Border.all(
                  color: Colors.black,
                  width: 4.0,
                )
              : null),
      width: 32.0,
      height: 32.0,
      // color: colorVal,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_SCHEDULE_COLOR,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
