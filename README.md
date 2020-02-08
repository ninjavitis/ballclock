OVERVIEW

This is a simulation of a rolling ball clock simulator, built for a job interview assignment.  Per the test instructions it does not use LCM or permutations, but rather simulates the movement of a set of balls across multiple tracks.



THE TEST SETUP

Every minute, the least recently used ball is removed from the queue of balls at the bottom of the clock, elevated, then deposited on the minute indicator track, which is able to hold four balls. When a fifth ball rolls on to the minute indicator track, its weight causes the track to tilt. The four balls already on the track run back down to join the queue of balls waiting at the bottom in reverse order of their original addition to the minutes track. The fifth ball, which caused the tilt,rolls on down to the five-minute indicator track. This track holds eleven balls. The twelfth ball carried over from the minutes causes the five-minute track to tilt, returning the eleven balls to the queue, again in reverse order of their addition. The twelfth ball rolls down to the hour indicator.  The twelfth ball carried over from the five-minute indicator causes the hour indicator to tilt, returning the eleven free balls to the queue, in reverse order, before the twelfth ball itself also returns to the queue.



RUNNING THE CLOCK

Valid numbers are in the range 27 to 127.
The ball clock has two possible modes: 

1. Takes a single argument specifying the number of balls and reports the number of balls given in the input and the number of days (24-hour periods) which elapse before the clock returns to its initial ordering.

2. Takes two parameters, the number of balls and the number of minutes to run for.  If the number of minutes is specified, the clock will run to the number of minutes and report the state of the tracks at that point in a JSON format.

Usage:

    ruby ball_clock.rb
    
    After running the script you will be prompted for the number of balls to use.
    After entering a valid number of balls you can:
        1. run clock mode 1 by pressing enter.
        2. run clock mode 2 by entering the number of days you would like to run the clock.

Output 1:

    30 balls cycle after 15 days
    
Output 2:

    {"Main"=>[11, 5, 26, 18, 2, 30, 19, 8, 24, 10, 29, 20, 16, 21, 28, 1, 23, 14, 27, 9]}
    {"Min"=>[]}
    {"FiveMin"=>[22, 13, 25, 3, 7]}
    {"Hour"=>[6, 12, 17, 4, 15]}



