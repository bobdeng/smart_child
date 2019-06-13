class GameCounter {
  Timer start;
  Timer end;

  GameCounter.start(DateTime dateTime) {
    start = new Timer(dateTime);
  }

  void finishGame() {
    end = new Timer(DateTime.now());
  }

  int score() {
    if (end == null) return 0;
    return end.minus(start);
  }
}

class Timer {
  DateTime time;

  Timer(DateTime dateTime) {
    time = dateTime;
  }

  int minus(Timer start) {
    return time.millisecondsSinceEpoch - start.time.millisecondsSinceEpoch;
  }
}
