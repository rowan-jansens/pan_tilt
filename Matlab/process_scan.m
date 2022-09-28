

data = arduino.UserData.Data;
% data = data_raw;



%apply sensor transfer function to raw sensor data to get distance
p1 =      -28.73
p2 =    2.99e+04
q1 =       125.6
data(:,3) =  (p1.*data(:,3) + p2) ./ (data(:,3) + q1)


%filter out data that is too far or too close
% valid_idx = (data(:,3) > 30) & (data(:,3) < 40);
% data = data(valid_idx, :);


%transformation to get position of sensor in global reference frame
sensor_offset = zeros(size(data));
theta = data(:,1);
phi = data(:,2);


for i=1:length(theta)
    origin2tilt = [1 1.5 0.5];              %distance from origin to tilt axis in "pan" coordinate  frame
    tilt2sensor = [0 2.5 1]*rotx(-phi(i));     %distance from tilt axis to sensor rotated to "pan" coordinate  frame
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
plot3(sensor_offset(:,1), sensor_offset(:,2), sensor_offset(:,3))




c = int16(data(:,3));
scatter3(x, y, z, 70, c, "filled")
colormap parula

title("3D Scan Plot")
xlabel("X (cm)")
ylabel("Y (cm)")
zlabel('Z (cm)')
ax = gca; 
ax.FontSize = 20; 
axis equal

gcf().set("position", [0 0 1000 700]);
a = colorbar('east');
a.Label.String = "\fontsize{20}Distance (cm)"
view(2.71745452045097, 0.721104144663705);
%%




line = data(:,2) == 0;
line = data(line,1:3)

figure()
clf
hold on
plot(line(:,1), line(:,3), "linewidth", 3)
title("2D Scan")
xlabel("X (cm)")
ylabel("Y (cm)")

ax = gca; 
ax.FontSize = 16; 
