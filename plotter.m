% distance 
dist = [20, 30, 50, 65, 75, 90, 110, 130, 150];
% senser value
sen_val = [502, 392, 239, 178, 163, 137, 113, 106, 89];

% dividing the vectors
X = dist ./ sen_val; 

y = 2.76*exp(-0.6)x.^4 - 0.001376x.^3 + 0.2563x.^2 -21.86x + 848.7;

xlabel("Distance(cm)");
ylabel("Sensor Value");

title("Sensor Value over Distance(cm)");

%plotting distance and sensor value
clf
hold on
plot(dist, sen_val);

plot(X, y);

% legend("");