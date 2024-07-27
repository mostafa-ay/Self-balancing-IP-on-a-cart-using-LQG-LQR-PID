# Self-balancing-IP-on-a-cart-using-LQG-LQR-PID
This whole projec was based on a paper that was published somewhere idk
The mathematical model of the system dynamics was derived with the help of this paper

A multibody model was made to mimic the actual system

After a very long time of tinkering with this project i wasn't getting the results i wanted, and this is probably because there was a mismatch between the mathemtical model and the mutibody model. So the LQG and LQR weren't giving a satisfying result since they both depends on the mathematical model to calculate their gains. There was a lot of overshooting.

The best result i got was by using the PID because it was tuned using PID autotuner, so there was no need for the mathemtical model.

I worked on this project for quite a while, I learned some stuff but all in all i'm not satisifed with the results so i'm not gonna share it anywhere :((
