import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_monetering/model/model.dart';


// Events
abstract class TankEvent {
 @override
  List<Object> get props => [];

}

class LoadTanks extends TankEvent {}

class FilterTanks extends TankEvent {
   final String query;
  final String tab;
  FilterTanks({required this.query, required this.tab});
   @override
  List<Object> get props => [query, tab];
}

// States
abstract class TankState {
    @override
  List<Object> get props => [];
}

class TankLoading extends TankState {}

class TankLoaded extends TankState {
  final List<Tank> tanks;
  TankLoaded(this.tanks);
   @override
  List<Object> get props => [tanks];
}

// Bloc Implementation
class TankBloc extends Bloc<TankEvent, TankState> {
  final List<Tank> allTanks = [
    Tank(name: "Tank 1", capacity: 10),
    Tank(name: "Tank 2", capacity: 30),
    Tank(name: "Tank 3", capacity: 50),
    Tank(name: "Tank 4", capacity: 70),
    Tank(name: "Tank 5", capacity: 100),
    Tank(name: "Tank 6", capacity: 5),
    Tank(name: "Tank 7", capacity: 60),
    Tank(name: "Tank 8", capacity: 80),
  ];

  TankBloc() : super(TankLoading()) {
    on<LoadTanks>((event, emit) {
      emit(TankLoaded(allTanks));
    });

    on<FilterTanks>((event, emit) {
      List<Tank> filteredTanks = allTanks.where((tank) {
        bool matchesQuery = tank.name.toLowerCase().contains(event.query.toLowerCase());

        bool matchesTab = false;
        if (event.tab == "0-25") {
          matchesTab = tank.capacity >= 0 && tank.capacity <= 25;
        } else if (event.tab == "25-60") {
          matchesTab = tank.capacity > 25 && tank.capacity <= 60;
        } else if (event.tab == "60-100") {
          matchesTab = tank.capacity > 60 && tank.capacity <= 100;
        } else {
          matchesTab = true; // "All" tab
        }

        return matchesQuery && matchesTab;
      }).toList();

      emit(TankLoaded(filteredTanks));
    });
  }
}
