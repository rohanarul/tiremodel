%% Step 1: User Input for All Data
% Ask the user for the necessary inputs with input validation
while true
    avg_speed = input('Enter the average speed of the car (in km/h, range 0-200): ');
    if avg_speed >= 0 && avg_speed <= 200
        break;
    else
        disp('Invalid input. Please enter a speed between 0 and 200 km/h.');
    end
end

while true
    distance_traveled = input('Enter the total distance traveled (in meters, range 0-100000): ');
    if distance_traveled >= 0 && distance_traveled <= 100000
        break;
    else
        disp('Invalid input. Please enter a distance between 0 and 100000 meters.');
    end
end

while true
    avg_load = input('Enter the average load on the tire (in Newtons, range 0-10000): ');
    if avg_load >= 0 && avg_load <= 10000
        break;
    else
        disp('Invalid input. Please enter a load between 0 and 10000 Newtons.');
    end
end

while true
    tire_temperature = input('Enter the average temperature of the tire (in Celsius, range 0-100): ');
    if tire_temperature >= 0 && tire_temperature <= 100
        break;
    else
        disp('Invalid input. Please enter a temperature between 0 and 100 Celsius.');
    end
end

while true
    simulation_time = input('Enter the total simulation time (in seconds, range 0-3600): ');
    if simulation_time >= 0 && simulation_time <= 3600
        break;
    else
        disp('Invalid input. Please enter a simulation time between 0 and 3600 seconds.');
    end
end

% Convert speed to meters per second (m/s)
speed_mps = avg_speed * 1000 / 3600;

% Define time vector (assuming simulation runs in steps of 1 second)
time = linspace(0, simulation_time, simulation_time);

%% Step 2: Define Tire Degradation Phases
% Early Phase (Lap 1–Few Laps In)
early_phase_duration = 0.1 * simulation_time; % First 10% of simulation time
early_phase_wear_rate = 0.00001; % Minimal wear as tires warm up

% Mid-Life Phase (Most of the Stint)
mid_life_duration = 0.7 * simulation_time; % Next 70% of simulation time
mid_life_wear_rate = 0.0001; % Gradual wear as tires stabilize

% Late Phase (Heavy Wear & Drop-off)
late_phase_duration = 0.2 * simulation_time; % Last 20% of simulation time
late_phase_wear_rate = 0.001; % Sharp increase in wear as tires degrade

%% Step 3: Simulate Tire Degradation Over Time
wear_over_time = zeros(1, simulation_time);

% Early Phase: Minimal wear, potential performance improvement
for t = 1:early_phase_duration
    wear_over_time(t) = early_phase_wear_rate * t;
end

% Mid-Life Phase: Gradual wear
for t = early_phase_duration+1:early_phase_duration+mid_life_duration
    wear_over_time(t) = wear_over_time(early_phase_duration) + mid_life_wear_rate * (t - early_phase_duration);
end

% Late Phase: Sharp increase in wear
for t = early_phase_duration+mid_life_duration+1:simulation_time
    wear_over_time(t) = wear_over_time(early_phase_duration+mid_life_duration) + late_phase_wear_rate * (t - (early_phase_duration+mid_life_duration));
end

% Simulate tire performance degradation (e.g., reduced traction over time)
initial_traction = 1.0; % Initial traction (normalized)
traction_loss = initial_traction - wear_over_time; % Traction reduces as tire degrades

%% Step 4: Plot the Results
figure;
subplot(2,1,1);
plot(time, wear_over_time, 'r-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Cumulative Wear');
title('Tire Wear Over Time');
grid on;

subplot(2,1,2);
plot(time, traction_loss, 'b-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Traction (normalized)');
title('Tire Traction Degradation Over Time');
grid on;

%% Step 5: Display Results
fprintf('After %.2f meters of travel, the tire has degraded by %.4f units.\n', ...
    distance_traveled, wear_over_time(end));
fprintf('Final traction level: %.4f (relative to initial)\n', traction_loss(end));