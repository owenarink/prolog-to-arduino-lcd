# prolog-to-arduino-lcd
Displaying a Prolog query on LCD connected to an Arduino, which estimates the straight line distance between cities which don't have a direct connection with eachother (with the A-Star Algorithm).

To display the result of the  Prolog query to the LCD connected to the Arduino, the C++ code picks up the result of the query from the serial port and writes result to the Arduino.
