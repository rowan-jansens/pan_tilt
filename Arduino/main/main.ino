
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

  
  pan_servo.attach(6);
  tilt_servo.attach(9);
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
  

  servo_calibration(pan_servo);
    
  }


void loop() {


  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023)
  val = map(val, 0, 1023, -35, 35);     // scale it for use with the servo (value between 0 and 180)
  move_servos(val, val);              // sets the servo position according to the scaled value
  //tilt_servo.write(val);
  delay(15); 


  

  xyzFloat angle = myMPU9250.getAngles();

  //double plot_val;

  Serial.print(val);
  Serial.print("\t ");
//  Serial.print(angle.x);
//  Serial.print("\t ");
//  Serial.print(angle.y);
//  Serial.print("\t ");
  Serial.println(angle.x);


 
  
}
