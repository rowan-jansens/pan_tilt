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


%%
% distance
x = [20, 30, 50, 65, 75, 90, 110, 130, 150];
% senser value
sen_val = [502, 392, 239, 178, 163, 137, 113, 106, 89];

% dividing the vectors
%X = dist ./ sen_val;

fit_x = linspace(89, 502, 100);

y_inv = 1.4e4./fit_x -9.129;
% y_poly = 2.76e-6*fit_x.^4 - (0.001376*fit_x.^3) + (0.2563*fit_x.^2) - (21.86*fit_x) + 848.7;
%
%
% y_poly = 1./y_poly;


my_green = [73 201 14] ./ 255;
my_blue = [14 142 201] ./ 255;

%plotting distance and sensor value
figure()
clf
hold on

%plot(x, sen_val);

plot(fit_x, y_poly, "-");

plot(fit_x, y_inv);

scatter(sen_val, x, 30, "filled", "MarkerFaceColor", my_blue)
xlabel("Distance(cm)");
ylabel("Sensor Value");
legend("Poly", "Inv", "Data");
title("Sensor Value over Distance(cm)");
%%

data = arduino.UserData.Data;

p1 =      -28.73
p2 =    2.99e+04
q1 =       125.6
data(:,3) =  (p1.*data(:,3) + p2) ./ (data(:,3) + q1)

valid_idx = (data(:,3) > 20) & (data(:,3) < 50);
data = data(valid_idx, :);

global_measurement = zeros(size(data));

%transformation to get position of sensor in global reference frame

theta = data(:,1);
phi = data(:,2);


for i=1:length(theta)
    origin2tilt = [1 1.5 0.5];              %distance from origin to tilt axis in "pan" cooridinate frame
    tilt2sensor = [0 2.5 1]*rotx(-phi(i));     %distance from tilt axis to sensor rotated to "pan" cooridinate frame
    origin2sensor = (origin2tilt + tilt2sensor)*rotz(-theta(i));   %add the two and rotate into the global frame

    global_measurement(i,:) = [origin2sensor];





end






[x, y, z] = sph2cart(deg2rad(data(:,1) + 90), deg2rad(data(:,2)), data(:,3))

x = x + global_measurement(:,1);
y = y + global_measurement(:,2);
z = z + global_measurement(:,3);

figure()
clf
hold on
plot3(global_measurement(:,1), global_measurement(:,2), global_measurement(:,3))

scatter3(x, y, z, 10,"filled")
%%




