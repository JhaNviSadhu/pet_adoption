import 'dart:async';
import 'package:pet_adoption/model/model_animal.dart';

enum PetAction { fetch, adopted, search }

class PetBloc {
  final _stateStreamController = StreamController<List<Animal>>();

  StreamSink<List<Animal>> get _petSink => _stateStreamController.sink;
  Stream<List<Animal>> get petStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<PetAction>();
  StreamSink<PetAction> get eventSink => _eventStreamController.sink;
  Stream<PetAction> get _eventStream => _eventStreamController.stream;

  PetBloc() {
    _eventStream.listen((event) async {
      if (event == PetAction.fetch) {
        try {
          var data = await loadPetList();
          if (data != null) {
            _petSink.add(data);
          } else {
            _petSink.addError("somthing went worng");
          }
        } on Exception catch (e) {
          _petSink.addError("somthing went worng");
        }
      }
      if (event == PetAction.search) {
        List<Animal> data = await loadPetList();
        List<Animal>? arrSearch;
        arrSearch?.addAll(data);
        //   if (query.isNotEmpty) {
        //   _competitonsController.arrFilteredCompetitions.value =
        //       _competitonsController.arrCompetitions;
        //   _competitonsController.arrFilteredCompetitions.value =
        //       _competitonsController.arrFilteredCompetitions
        //           .where((p0) => p0.name?.toLowerCase().contains(query) ?? false)
        //           .toList();
        //   setState(() {});

        //   _competitonsController.arrFilteredCompetitions.refresh();
        // }
      }
    });
  }
}
