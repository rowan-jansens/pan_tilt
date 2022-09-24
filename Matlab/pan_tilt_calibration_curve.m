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
plot(data.measured, data.command, "linewidth", 2)
plot(data.measured, fit, "linewidth", 1)
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
figure()
clf
hold on

plot(data.measured, data.command, ".", "linewidth", 2)
plot(tilt_angle, fit, "linewidth", 1)
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


