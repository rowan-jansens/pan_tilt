 
#include <Servo.h>

Servo pan_servo;  // create servo object to control a servo
Servo tilt_servo;




int potpin = A1;  // analog pin used to connect the potentiometer
int val;    // variable to read the value from the analog pin
const int dist_pin = A0; // distance sensor pin
int j = 0;

#include <MPU9250_WE.h>
#include <Wire.h>
#define MPU9250_ADDR 0x68
MPU9250_WE myMPU9250 = MPU9250_WE(MPU9250_ADDR);

// STARTING SERVO POSITION INITIALIZATION
int pos = 0;
int start_psweep = -35;                               // - 35 degrees
int start_tsweep = -10;                               // -10 degrees
int dp = 1;                                           // change in the pan servo position at a time 

void setup() {
  Serial.begin(115200);
  Wire.begin();

  
  pan_servo.attach(5);
  tilt_servo.attach(6);
  move_servos(0, 0);
  delay(5000);
  

  //=======IMU stuff=============
//  if(!myMPU9250.init()){
//    Serial.println("MPU9250 does not respond");
//  }
//  else{
//    Serial.println("MPU9250 is connected");
//  }
  myMPU9250.setAccRange(MPU9250_ACC_RANGE_2G);
  myMPU9250.enableAccDLPF(true);
  myMPU9250.setAccDLPF(MPU9250_DLPF_6);  

  myMPU9250.autoOffsets();
  
  
//    servo_calibration(pan_servo);
//    delay(1000);
//     servo_calibration(tilt_servo);
    
  }


void loop() {





  // Moves servo into scanning position
//  pan_servo.write(pos);                               // initialize position of pan servo
//  tilt_servo.write(pos);
//  pan_servo.write(start_psweep);                      // moves to left side to begin the sweep
//  tilt_servo.write(start_tsweep);                     // initialize position of tilt servo


  // Variables for calculating avg dist points
  int store;
  int avg;
  int dist;
  int i;
  


  while(j == 0){
  // Looping sweep
  for (start_tsweep = -15; start_tsweep <= 35; start_tsweep += 1) {           // looping the tilt servo 
      while (start_psweep >= -35 && start_psweep < 35) {      // looping the pan servo
          avg = 0;
          store = 0;

          // pans then mini tilts 
          move_servos(start_psweep, start_tsweep);

          delay(15);

          // takes data at the mini tilts peak
          for (i = 0; i <= 10; i++) {
            dist = analogRead(dist_pin);
            store = store + dist;
 
          }
          // takes the average of ten data pts and prints to serial
          avg = store/10;
          Serial.print(start_psweep);
          Serial.print(",");
          Serial.print(start_tsweep);
          Serial.print(",");
          Serial.print(avg);
          Serial.write(10);

      start_psweep += dp;
      }

      dp = dp * -1;    
      start_psweep = start_psweep + dp;

                         // switches direction of panning 
  }
  j = 1;
  }

  



//  val = analogRead(potpin);            // reads the value of the potentiometer (value between 0 and 1023)
//  double pan_angle = map(val, 0, 1023, -35, 35);     
//  double tilt_angle = map(val, 0, 1023, -15, 35);  
//  double raw_angle = map(val, 0, 1023, 0, 180);
//  move_servos(0, tilt_angle);  
//  delay(15); 
//  xyzFloat angle = myMPU9250.getAngles();
//  Serial.print(pan_angle);
//  Serial.print("\t ");
//  Serial.print(tilt_angle);
//  Serial.print("\t ");
//  Serial.print(raw_angle);
//  Serial.print("\t ");
//  Serial.println(angle.x * -1);


 
  
}
