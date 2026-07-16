/// Direction of shimmer effect
enum ShimmerDirection {
  /// Left to right
  ltr,

  /// Right to left
  rtl,

  /// Top to bottom
  ttb,

  /// Bottom to top
  btt,

  /// Diagonal from top-left to bottom-right
  diagonalLTR,

  /// Diagonal from top-right to bottom-left
  diagonalRTL,

  /// Diagonal from bottom-left to top-right
  diagonalBLTR,

  /// Wave pattern (smooth oscillating)
  wave,
}

/// Wave type for wave direction shimmer
enum WaveType {
  /// Sine wave pattern
  sine,

  /// Square wave pattern
  square,

  /// Triangle wave pattern
  triangle,
}
