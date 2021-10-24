# Displaying A Prolog Query (Using the A-star Algorithm) onto an LCD connected to an Arduino
Displaying a Prolog query on LCD connected to an Arduino, which estimates the straight line distance between cities which don't have a direct connection with eachother (with the A-Star Algorithm).

To display the result of the  Prolog query to the LCD connected to the Arduino, the C++ code picks up the result of the query from the serial port and writes result to the Arduino.

There is a possibility you have to change the permissions in ubuntu for /dev/ttyACM0.
you can do this by adding yourself to the dialout group (which sometimes permanently solves the issue): 

```
sudo usermod -a -G dialout $USER
```

and this might also help:

```
sudo chmod 666 /dev/ttyACM0
```
