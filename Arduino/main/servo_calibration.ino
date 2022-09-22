void servo_calibration(Servo servo){

  
    servo.write(0); 
    myMPU9250.autoOffsets();
    delay(1000);
  
    for (int i = 0 ; i<180 ; i+=10){
    servo.write(i); 
    delay(50);
    double cur_sum = 0;
    for (int j = 0; j < 10 ; j++){
      xyzFloat angle = myMPU9250.getAngles();
      cur_sum += angle.x;
      delay(10);
    }
    Serial.print(i);
    Serial.print(",");
    Serial.println(cur_sum / 10);
  }

}
