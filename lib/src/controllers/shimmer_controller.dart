import 'package:flutter/material.dart';

/// Controller for managing shimmer animation playback
class ShimmerController extends ChangeNotifier {
  /// Current state of the animation
  ShimmerState _state = ShimmerState.playing;

  ShimmerState get state => _state;

  bool get isPlaying => _state == ShimmerState.playing;
  bool get isPaused => _state == ShimmerState.paused;
  bool get isStopped => _state == ShimmerState.stopped;

  /// Pause the shimmer animation
  void pause() {
    if (_state != ShimmerState.paused) {
      _state = ShimmerState.paused;
      notifyListeners();
    }
  }

  /// Resume the shimmer animation
  void resume() {
    if (_state != ShimmerState.playing) {
      _state = ShimmerState.playing;
      notifyListeners();
    }
  }

  /// Stop and reset the shimmer animation
  void stop() {
    if (_state != ShimmerState.stopped) {
      _state = ShimmerState.stopped;
      notifyListeners();
    }
  }

  /// Toggle between play and pause
  void toggle() {
    if (_state == ShimmerState.playing) {
      pause();
    } else {
      resume();
    }
  }
}

/// Animation state enum
enum ShimmerState {
  /// Animation is playing
  playing,

  /// Animation is paused
  paused,

  /// Animation is stopped and reset
  stopped,
}
