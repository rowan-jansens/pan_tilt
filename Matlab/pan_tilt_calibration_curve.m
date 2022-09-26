data = readtable("pan_calib_data.csv");
data.measured  = data.Var2;
data.command  = data.Var1;

clean_range = [10:170]




A = [data.measured(clean_range)  ones(size(data.measured(clean_range)))];
b = [data.command(clean_range) ];
x = A\b


A_all = [data.measured ones(size(data.measured))];
fit = A_all * x;


figure()
clf
hold on
scatter(data.measured, data.command, 30, "filled", 'MarkerFaceColor', my_blue)
plot(pan_angle, fit, "linewidth", 2, "Color", my_green)
legend("Data", "Fit")
grid on
ylabel("Servo Angle")
xlabel("Pan Angle")

%%
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

figure()
clf
hold on

scatter(data.measured, data.command, 30, "filled", 'MarkerFaceColor', my_blue)
plot(tilt_angle, fit, "linewidth", 2, "Color", my_green)
legend("Data", "Fit")
grid on
ylabel("Servo Angle")
xlabel("Pan Angle")


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



fit_x = linspace(89, 502, 100);
y_inv = 1.4e4./fit_x -9.129;



my_green = [73 201 14] ./ 255;
my_blue = [14 142 201] ./ 255;

%plotting distance and sensor value
figure()
clf
hold on

%plot(x, sen_val);



plot(fit_x, y_inv);

scatter(sen_val, x, 30, "filled", "MarkerFaceColor", my_blue)
xlabel("Distance(cm)");
ylabel("Sensor Value");
legend("Poly", "Inv", "Data");
title("Sensor Value over Distance(cm)");




