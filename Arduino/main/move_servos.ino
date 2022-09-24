void move_servos(double pan_angle, double tilt_angle) {

  //Angle Ranges
  // pan = -35 to 35 deg
  //tilt = -15 to 35 deg

  //tranfer function for pan angle
  //linear fit

  double pan_servo_angle = (-1 * pan_angle * 2.1469) + 89.9460;

  //Write to servo
  pan_servo.write(pan_servo_angle);



  //tranfer function for tilt angle
  //N5 polynomial fit
  double p1, p2, p3, p4, p5, p6, tilt_servo_angle;
  p1 = 2.443e-06;
  p2 = -9.927e-05;
  p3 = 0.0005171;
  p4 = 0.02832;
  p5 = 2.231;
  p6 = 51.82;
  tilt_servo_angle = (p1 * pow(tilt_angle, 5)) +
                     (p2 * pow(tilt_angle, 4)) +
                     (p3 * pow(tilt_angle, 3)) +
                     (p4 * pow(tilt_angle, 2)) +
                     (p5 * tilt_angle) + p6;


  //Write to servo
  tilt_servo.write(tilt_servo_angle);

}
