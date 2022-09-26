

data = arduino.UserData.Data;
% data = data_raw;



%apply sensor transfer function to raw sensor data to get distance
p1 =      -28.73
p2 =    2.99e+04
q1 =       125.6
data(:,3) =  (p1.*data(:,3) + p2) ./ (data(:,3) + q1)


%filter out data that is too far or too close
valid_idx = (data(:,3) > 20) & (data(:,3) < 100);
data = data(valid_idx, :);


%transformation to get position of sensor in global reference frame
sensor_offset = zeros(size(data));
theta = data(:,1);
phi = data(:,2);


for i=1:length(theta)
    origin2tilt = [1 1.5 0.5];              %distance from origin to tilt axis in "pan" cooridinate frame
    tilt2sensor = [0 2.5 1]*rotx(-phi(i));     %distance from tilt axis to sensor rotated to "pan" cooridinate frame
    origin2sensor = (origin2tilt + tilt2sensor)*rotz(-theta(i));   %add the two and rotate into the global frame
    sensor_offset(i,:) = origin2sensor;
end


%convert from spherical coords to cartesian
[x, y, z] = sph2cart(deg2rad(data(:,1)+90), deg2rad(data(:,2)), data(:,3))

%add sensor offset
x = x + sensor_offset(:,1);
y = y + sensor_offset(:,2);
z = z + sensor_offset(:,3);

%plot
figure()
clf
hold on
% plot3(sensor_offset(:,1), sensor_offset(:,2), sensor_offset(:,3))

scatter3(x, y, z, 10,"filled", "MarkerFaceColor", [0.1 0.9 0.2])
axis equal
title("3D Scanner Plot")
xlabel("X (cm)")
ylabel("Y (cm)")
zlabel("Z (cm)")
