//#include <Servo.h>
//
//// SERVO INITIALIZIATION
//Servo pan_servo; 
//Servo tilt_servo;
//
//// DISTANCE SENSOR PIN
//const int dist_pin = A0;
//
//// STARTING SERVO POSITION INITIALIZATION
//int pos = 0;
//int start_psweep = -35;                               // - 35 degrees
//int start_tsweep = -15;                               // -15 degrees
//int dp = 2;                                           // change in the pan servo position at a time 
//
//void setup() {
//  // SERVO PINS  
//  pan_servo.attach(9);
//  tilt_servo.attach(10);
//
//  // SERIAL 
//  Serial.begin(9600);
//}
//
//void loop() {
//  // Moves servo into scanning position
//  pan_servo.write(pos);                               // initialize position of pan servo
//  tilt_servo.write(pos);
//  pan_servo.write(start_psweep);                      // moves to left side to begin the sweep
//  tilt_servo.write(start_tsweep);                     // initialize position of tilt servo
//
//
//  // Variables for calculating avg dist points
//  int store;
//  int avg;
//  int dist;
//  int i;
//
//
//  // Looping sweep
//  for (start_tsweep = -15; start_tsweep <= 35; start_tsweep += 5) {           // looping the tilt servo 
//      for (start_psweep = -40; start_psweep <= 40; start_psweep += dp) {      // looping the pan servo
//          avg = 0;
//          store = 0;
//
//          // pans then mini tilts 
//          pan_servo.write(start_psweep);
//          delay(100);
//          tilt_servo.write(start_tsweep+5);
//
//          // takes data at the mini tilts peak
//          for (i = 0; i <= 10; i++) {
//            dist = analogRead(dist_pin);
//            store = store + dist;
//          }
//          // takes the average of ten data pts and prints to serial
//          avg = store/10;
//          Serial.print("serial = ");
//          Serial.println(avg);
//
//          // mini delay before tilts back down then loops again
//          delay(100);
//          tilt_servo.write(start_tsweep-5);
//      }
//      dp = dp * -1;                       // switches direction of panning 
//  }
//
//}
//
//
////}
