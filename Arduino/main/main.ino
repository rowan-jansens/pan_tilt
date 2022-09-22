
#include <Servo.h>

Servo pan_servo;  // create servo object to control a servo
Servo tilt_servo;


int potpin = A0;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin

#include <MPU9250_WE.h>
#include <Wire.h>
#define MPU9250_ADDR 0x68
MPU9250_WE myMPU9250 = MPU9250_WE(MPU9250_ADDR);

void setup() {
  Serial.begin(115200);
  Wire.begin();

  
  pan_servo.attach(5);
  tilt_servo.attach(6);
  move_servos(0, 0);
  delay(1000);
  

  //=======IMU stuff=============
  if(!myMPU9250.init()){
    Serial.println("MPU9250 does not respond");
  }
  else{
    Serial.println("MPU9250 is connected");
  }
  myMPU9250.setAccRange(MPU9250_ACC_RANGE_2G);
  myMPU9250.enableAccDLPF(true);
  myMPU9250.setAccDLPF(MPU9250_DLPF_6);  

  myMPU9250.autoOffsets();
  
  
//  servo_calibration(pan_servo);
//  delay(1000);
    // servo_calibration(tilt_servo);
    
  }


void loop() {


  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023)
  double pan_angle = map(val, 0, 1023, -35, 35);     
  double tilt_angle = map(val, 0, 1023, -15, 35);   
  move_servos(0, tilt_angle);  

  delay(15); 


  xyzFloat angle = myMPU9250.getAngles();

  Serial.print(pan_angle);
  Serial.print("\t ");
  Serial.print(tilt_angle);
  Serial.print("\t ");
  Serial.println(angle.x);


 
  
}
