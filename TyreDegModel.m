%% Step 1: User Input for All Data
% Ask user for number of corners and straights
num_straights = input('Enter the number of straights in the track: ');
num_corners = input('Enter the number of corners in the track: ');

% Initialize arrays for each segment's input
segment_speeds = zeros(1, num_straights + num_corners);
segment_distances = zeros(1, num_straights + num_corners);
segment_loads = zeros(1, num_straights + num_corners);
segment_temperatures = zeros(1, num_straights + num_corners);
segment_times = zeros(1, num_straights + num_corners); % For storing time taken for each segment
segment_traction_loss = zeros(1, num_straights + num_corners); % Store traction loss for each segment

% Collect inputs for each straight
for i = 1:num_straights
    fprintf('Straight %d:\n', i);
    segment_speeds(i) = input('Enter the speed in km/h: ');
    segment_distances(i) = input('Enter the distance in meters: ');
    segment_loads(i) = input('Enter the load on the tire (in Newtons): ');
    segment_temperatures(i) = input('Enter the tire temperature (in Celsius): ');
end

% Collect inputs for each corner
for i = 1:num_corners
    fprintf('Corner %d:\n', i);
    segment_speeds(num_straights + i) = input('Enter the speed in km/h: ');
    segment_distances(num_straights + i) = input('Enter the distance in meters: ');
    segment_loads(num_straights + i) = input('Enter the load on the tire (in Newtons): ');
    segment_temperatures(num_straights + i) = input('Enter the tire temperature (in Celsius): ');
end

%% Step 2: Tire Degradation Model for Each Segment
base_wear_rate = 0.0001; % Base wear rate
decay_constant = 0.0005;  % Constant to control exponential degradation

total_wear = 0;
total_distance = 0;
total_time = 0;
total_traction_loss = 0;

cumulative_time = zeros(1, num_straights + num_corners); % Track cumulative time

for i = 1:(num_straights + num_corners)
    % Convert speed to meters per second
    speed_mps = segment_speeds(i) * 1000 / 3600;

    % Calculate time taken for this segment
    segment_times(i) = segment_distances(i) / speed_mps;
    
    % Cumulative time
    if i == 1
        cumulative_time(i) = segment_times(i);
    else
        cumulative_time(i) = cumulative_time(i-1) + segment_times(i);
    end
    
    % Degradation effects for each segment
    temperature_effect = 0.01 * (segment_temperatures(i) - 20); 
    load_effect = 0.008 * segment_loads(i); 
    speed_effect = 0.004 * segment_speeds(i); 
    
    % Calculate the wear rate for this segment
    wear_rate = base_wear_rate + temperature_effect + load_effect + speed_effect;
    
    % Calculate wear for this segment
    distance_covered = segment_distances(i);
    segment_wear = wear_rate * (exp(decay_constant * distance_covered) - 1);
    
    % Sum up total wear and total time
    total_wear = total_wear + segment_wear;
    total_distance = total_distance + distance_covered;
    total_time = total_time + segment_times(i); 
    
    % Calculate traction loss for each segment
    segment_traction_loss(i) = 1 - segment_wear; % Assuming initial traction = 1
    total_traction_loss = total_traction_loss + segment_traction_loss(i);
end

% Calculate average traction loss over the circuit
avg_traction_loss = total_traction_loss / (num_straights + num_corners);

%% Step 5: Plot the Results
figure;
subplot(2,1,1);
plot(cumulative_time, segment_traction_loss, 'b-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Traction (normalized)');
title('Tire Traction Degradation Over Time');
grid on;

subplot(2,1,2);
plot(cumulative_time, cumsum(segment_distances), 'r-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Cumulative Distance (m)');
title('Cumulative Distance Over Time');
grid on;

%% Step 6: Display Results

fprintf('Average traction loss: %.4f (relative to initial)\n', min(avg_traction_loss));
