clc;

global pivot servo_center link servo_arm tilt_arm plate_angle

pivot = [0 0];
servo_center = [0 -17];
link = 23;
servo_arm = 7.5;
tilt_arm = 15;

plate_angle = 70;



angle = linspace(-90, 90, 180);

mod_angle = zeros(size(angle));

for i = 1:length(angle)
    mod_angle(i) = ((angle_model(angle(i) + 180)) - 90) - plate_angle;



end

figure(1)
plot(angle, mod_angle)
axis equal
grid on
xlabel("Servo Angle")
ylabel("Pan angle")
title("Linkage Angle Transfer Function")