ProcessingKinectOSC
===================

**Either this code can be added to the directory of the sketch, or the
[OSCeletonWrapper](http://skyra.github.io/blog/OSCeletonWrapper/) library
can be installed for processing.**

This processing sketch can be used to read osc data coming from [OSCeleton](https://github.com/Sensebloom/OSCeleton).
It creates Skeleton objects from the data from the kinect which can be used during the draw loop.
The idea behind this base sketch is that it should be easy and fast to see where each joint is for
each user while drawing without having to deal with osc messages.
