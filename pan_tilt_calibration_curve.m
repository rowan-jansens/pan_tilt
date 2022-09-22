data = readtable("pan_callib.csv");
data.measuerd  = data.measuerd - 90;


xlabel("Command")
ylabel("measured")


A = [data.command  ones(size(data.command))];
b = [data.measuerd];

x = A\b


fit = A * x;


figure()
clf
hold on
plot(data.command, data.measuerd, "linewidth", 2)
plot(data.command, fit, "linewidth", 1)
legend("Data", "Fit")

%%
data = readtable("tilt_callib.csv")
plot(data.Var1, data.Var2)