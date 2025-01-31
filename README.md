# Tire Degredation Model
## Version 1
I created a simple tire degradation that can calculate the degradation in arbitrary units and the final traction loss also in arbitrary units
The way the model work is the user inputs the average speed, average tyre load in Newtons, distance travelled, temperature of the tyre. The model uses Pajceka's Magic Tyre Formula and the exponential nature that tyre degredation has to find both the degredation and traction loss

The code was done in MATLAB and I encourage improvements of this simple model. 

## Version 2
The code has been updated to allow the simulation of tire degradation across multiple track segments, including both straights and corners, instead of a single run. It now collects inputs for each segment’s speed, distance, load, and tire temperature, allowing for a more detailed and accurate simulation of real-world track conditions. The time taken for each segment is calculated, and cumulative wear and traction loss are determined over the entire track.

## Version 3
I’m excited to share some major updates to the TriPhase Tire Wear Simulator, a tool I’ve been developing to model tire degradation in real-world driving conditions. Based on feedback and further research, I’ve made significant improvements to make the simulation more accurate, user-friendly, and reflective of real-world tire behavior.

What’s New in the TriPhase Tire Wear Simulator?
1. Three-Phase Degradation Model
The biggest change is the introduction of a three-phase degradation model, which mirrors how tires wear in real life:

Early Phase (Lap 1–Few Laps In): Fresh tires warm up, offering maximum grip with minimal wear.

Mid-Life Phase (Most of the Stint): Gradual wear sets in as tires stabilize, with a steady decline in performance.

Late Phase (Heavy Wear & Drop-off): A sharp drop in grip as tires overheat and tread depth decreases, leading to significant performance loss.

This phased approach provides a more realistic representation of tire behavior over time, making it invaluable for motorsport strategy and vehicle dynamics analysis.

2. Dynamic Wear Rates
Each phase now has its own dynamic wear rate:

Early Phase: Low wear rate as tires warm up.

Mid-Life Phase: Moderate wear rate as tires stabilize.

Late Phase: High wear rate as tires degrade rapidly.

These rates are influenced by factors like speed, load, and temperature, ensuring the simulation adapts to different driving conditions.

3. Improved Traction Loss Calculation
Traction loss is now calculated as a function of cumulative wear, with an initial traction value normalized to 1.0. This allows users to see how grip decreases over time, providing clear insights into performance degradation.


