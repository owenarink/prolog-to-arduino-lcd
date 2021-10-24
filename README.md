# Displaying A Prolog Query (Using the A-star Algorithm) onto an LCD connected to an Arduino
Displaying a Prolog query on LCD connected to an Arduino, which estimates the straight line distance between cities which don't have a direct connection with eachother (with the A-Star Algorithm).

To display the result of the  Prolog query to the LCD connected to the Arduino, the C++ code picks up the result of the query from the serial port and writes the result to the LCD connected to the Arduino.
Click the GIF below:
[![Arduino LCD from Prolog](https://i.ytimg.com/an_webp/efBbUspbV2c/mqdefault_6s.webp?du=3000&sqp=CN_g1YsG&rs=AOn4CLCn83hRZSQDBmCfBswQaXWnemEfzg)](https://www.youtube.com/embed/efBbUspbV2c) </br>
link: https://www.youtube.com/watch?v=efBbUspbV2c

There is a possibility you have to change the permissions in ubuntu for /dev/ttyACM0.
you can do this by adding yourself to the dialout group (which sometimes permanently solves the issue): 

```
sudo usermod -a -G dialout $USER
```

and this might also help:

```
sudo chmod 666 /dev/ttyACM0
```
