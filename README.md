## TireDegredationModel
# Version 1
I created a simple tire degradation that can calculate the degradation in arbitrary units and the final traction loss also in arbitrary units
The way the model work is the user inputs the average speed, average tyre load in Newtons, distance travelled, temperature of the tyre. The model uses Pajceka's Magic Tyre Formula and the exponential nature that tyre degredation has to find both the degredation and traction loss

The code was done in MATLAB and I encourage improvements of this simple model. 

#Version 2
The code has been updated to allow the simulation of tire degradation across multiple track segments, including both straights and corners, instead of a single run. It now collects inputs for each segment’s speed, distance, load, and tire temperature, allowing for a more detailed and accurate simulation of real-world track conditions. The time taken for each segment is calculated, and cumulative wear and traction loss are determined over the entire track.
