#include <Servo.h>
#define S 12
#define M1 8      //DC motor
#define M2 9     //DC motor
Servo servo;
void setup() {
  // put your setup code here, to run once:
   servo.attach(S); 
   pinMode(M1, OUTPUT);
   pinMode(M2, OUTPUT);
   
}

void loop() {
  // put your main code here, to run repeatedly:
  servo.write(64);
 // digitalWrite(M1, HIGH);
  //digitalWrite(M2, LOW);
  
}
