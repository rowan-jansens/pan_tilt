data = readtable("pan_calib_data.csv");
data.measured  = data.Var2;
data.command  = data.Var1;

clean_range = [10:170]

my_green = [73 201 14] ./ 255;
my_blue = [14 142 201] ./ 255;


A = [data.measured(clean_range)  ones(size(data.measured(clean_range)))];
b = [data.command(clean_range) ];
x = A\b


A_all = [data.measured ones(size(data.measured))];
pan_angle = linspace(-45, 45, 100);
fit = pan_angle .* x(1) + x(2);


figure()
clf
subplot(1,2,1)
hold on
scatter(data.measured, data.command, 30, "filled", 'MarkerFaceColor', my_blue)
plot(pan_angle, fit, ":k","linewidth", 2)
legend("Data", "Fit", "Location", "northwest")
grid on
title("Pan")
ylim([0 180])
grid minor
ylabel("Servo Angle (deg)")
xlabel("Pan Angle (deg)")
xticks([-40 : 20 : 40])

data = readtable("tilt_calib_data.csv")
data.measured  = data.Var2;
data.command  = data.Var1;

p1 = 2.443e-06;
p2 = -9.927e-05;
p3 = 0.0005171;
p4 = 0.02832;
p5 = 2.231;
p6 = 51.82;

tilt_angle = linspace(-20, 38, 100);

fit = (p1 * tilt_angle.^5) + (p2 * tilt_angle.^4) +(p3 * tilt_angle.^3) +(p4 * tilt_angle.^2) +(p5 * tilt_angle) + p6;





% x = data.Var1(10:100);
% y = data.Var2(10:100);

my_green = [73 201 14] ./ 255;
my_blue = [14 142 201] ./ 255;

subplot(1,2,2)
hold on
scatter(data.measured, data.command, 30, "filled", 'MarkerFaceColor', my_blue)
plot(tilt_angle, fit, ":k", "linewidth", 2)

grid on
ylabel("Servo Angle (deg)")
xlabel("Tilt Angle (deg)")
title("Tilt")
ylim([0 180])
grid minor



sgtitle("Servo Calibration")
%%


%transformation to get position of sensor in global reference frame

theta = 30;
phi = 15;

origin2tilt = [1 1.5 0.5];              %distance from origin to tilt axis in "pan" cooridinate frame
tilt2sensor = [0 2.5 1]*rotx(-phi);     %distance from tilt axis to sensor rotated to "pan" cooridinate frame
origin2sensor = (origin2tilt + tilt2sensor)*rotz(-theta)    %add the two and rotate into the global frame

global_measurement = measurement + origin2sensor;

%%

x = [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85];
sen_val = [573 650 601 540 475 410 365 330 295 270 250 230 212 200 183 170];

% test_x = [20, 30, 50, 65, 75, 90, 110, 130, 150];
% test_y = [502, 392, 239, 178, 163, 137, 113, 106, 89];


test_x = [544 430 330 266 220 192 169 149 ]

test_y = [20 30 40 50 60 70 80 90]

fit_x = linspace(150, 650, 100);
p1 =      -28.73;
p2 =    2.99e+04;
q1 =       125.6;
y_inv =  (p1.*fit_x + p2) ./ (fit_x + q1);

real_y = (p1.*test_x + p2) ./ (test_x + q1);

my_green = [73 201 14] ./ 255;
my_blue = [14 142 201] ./ 255;

%plotting distance and sensor value
figure()
clf


%plot(x, sen_val);

subplot(1,2,1)
hold on
scatter(sen_val, x, 50, "filled", "MarkerFaceColor", my_blue)
plot(fit_x, y_inv, ":k", "linewidth", 2);
title("Transfer Function Fit")

ylabel("True Distance (cm)");
xlabel("Analog Sensor Value");
legend("Training Data", "Fit", "location", "northwest");
sgtitle("IR Distance Sensor Calibration");
grid on
grid minor
ax = gca; 
ax.FontSize = 12;

ylim([0 180])

subplot(1,2,2)
hold on
title("Distance Test")
scatter(real_y, test_y, 50, "filled", "MarkerFaceColor", my_green)
ylabel("True Distance (cm)")
xlabel("Reported Distance (cm)")
xticks([20 : 20 : 80])
grid on
grid minor
x = linspace(0,95,2);
y = x;
plot(x,y)

legend("Test Data", "y=x", "location", "northwest")
ax = gca; 
ax.FontSize = 12;

%%


