function angle = angle_model(theta)

global pivot servo_center link servo_arm tilt_arm plate_angle




servo_end = [servo_arm*cosd(theta)+servo_center(1) servo_arm*sind(theta)+servo_center(2)];

x1  = pivot(1);
x2 = servo_end(1);
y1 = pivot(2);
y2 = servo_end(2);
r1 = tilt_arm;
r2 = link;

d = sqrt((x1-x2)^2 + (y1-y2)^2);
l = (r1^2 - r2^2 + d^2) / (2*d);
h = sqrt(r1^2 - l^2);

x = (l/d) * (x2-x1) + (h/d)*(y2-y1) + x1;
y = (l/d) * (y2-y1) - (h/d)*(x2-x1) + y1;

angle = atan2d(y, x);
angle = mod(angle, 360)


figure(2)

P = [pivot ; servo_center ; servo_end ; [x y] ; pivot ; [10*cosd(angle-plate_angle) 10*sind(angle-plate_angle)]];

plot(P(:,1), P(:,2), ".-", "linewidth", 2, "markersize", 30)
axis equal
axis([-30 20 -30 20])


end