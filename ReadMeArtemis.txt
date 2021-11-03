Download both Research2 and Rea2

Research2 opens the serial port and callbacks Rea2
Rea2 is the code to obtain the opelog information and run calculations

Issues: once the loop in Rea2 is started it needs to be manually terminated with Ctrl+C or break
In order to get around this I was trying to make it so that you can have a GUI toggle but 
did not get it to work yet.

How to use:

to start: Run Research2

6-axis(default)

When the program is started it sets the reference point at the position that the code is started. Resetted everytime you restart (n==4)

9-axis

When the data starts logging the Artemis needs to be calibrated. This is done by moving the device in all 6 directions (pos & neg roll for exp)
You must do this in order to calibrate the artemis to magnetic North. If you want to make a reference point instead and base off of that the Artemis code needs to be reconfigured (n==5)

When ending use fclose(serialObject) in command prompt 

The only math that needs to be tweeked is the angular momentum values. The moment of Inertia might not be correct.