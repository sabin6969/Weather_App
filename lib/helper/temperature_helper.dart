class TemperatureHelper {
  static String kelvinToCelsius(double kelvin) {
    var celsius = kelvin - 273.15;
    return celsius.toStringAsFixed(1);
  }
}
