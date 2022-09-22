void move_servos(double pan_angle, double tilt_angle, Servo pan_servo, Servo tilt_servo) {

  //Angle Ranges
  // pan = -35 to 35 deg
  //tilt = -15 to 35 deg

  //tranfer function for pan angle
  //linear fit
  double pan_servo_angle = (pan_angle + 42.9390) / 0.4771;

  //Write to servo
  pan_servo.write(pan_servo_angle);



  //tranfer function for tilt angle
  //N5 polynomial fit
  double p1, p2, p3, p4, p5, p6, tilt_servo_angle;
  p1 = 2.778e-6;
  p2 = -1.304e-4;
  p3 = 0.001307;
  p4 = 0.01635;
  p5 = 2.391;
  p6 = 60.68;
  tilt_servo_angle = (p1 * pow(pan_angle, 5)) +
                     (p2 * pow(pan_angle, 4)) +
                     (p3 * pow(pan_angle, 3)) +
                     (p4 * pow(pan_angle, 2)) +
                     (p5 * pan_angle) + p6;


  //Write to servo
  tilt_servo.write(tilt_servo_angle);

}
