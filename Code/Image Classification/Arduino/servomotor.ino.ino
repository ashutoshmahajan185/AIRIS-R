// Include the Servo library 
#include <Servo.h> 
// Declare the Servo pin 
int servoPin = 2; 
//int angle = 90;
// Create a servo object 
Servo Servo1; 
void setup() { 
   // We need to attach the servo to the used pin number 
   Servo1.attach(servoPin); 
}
void loop(){ 
   // Make servo go to 85 degrees; centre of the turning, Go straight. 
   Servo1.write(85); 
   delay(1000); 
   Servo1.write(55); 
   delay(1000); 
  // Servo1.write(85); 
  // delay(1000); 
   Servo1.write(115); 
   delay(2000); 
   Servo1.write(55); 
   delay(1000);
   Servo1.write(85); 
   delay(1000); 

  /* while(true) {
    if(angle > 90 && angle < 120)
   }
*/   
}
