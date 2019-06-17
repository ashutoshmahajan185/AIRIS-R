const int ledpin=13;
int triggerValue; //record value for reading the serial input from matlab
//Motor A
const int motorPin1  = 5;  // Pin 14 of L293d A1 of module
const int motorPin2  = 6;  // Pin 10 of L293d A2 of module
//Motor B
const int motorPin3  = 10; // Pin  7 of L293d B1 of module
const int motorPin4  = 9;  // Pin  2 of L293d B2 of module

const int triggerPin = 13; //Red signal Triggger
int flag = 1; // Flag for monitoring the motor driver according to the traffic signal status
void setup() {
  
  Serial.begin(9600);
  pinMode(triggerPin, OUTPUT);
  pinMode(motorPin1, OUTPUT);
  pinMode(motorPin2, OUTPUT);
  pinMode(motorPin3, OUTPUT);
  pinMode(motorPin4, OUTPUT);
  
}

void loop() {
  
  if(Serial.available() > 0) { //if serial input from matlab is available
    flag == 1; //drive the car by default (for this phase only)
    triggerValue = Serial.read();  
    if (triggerValue == 100) { // If use will send value 100 from MATLAB then LED will turn ON
      digitalWrite(triggerPin, HIGH);  
       flag = 0; //stop if red signal is seen
    }  
    if(triggerValue == 101) { // If use will send value 101 from MATLAB then LED will turn OFF
      digitalWrite(triggerPin, LOW);
      flag = 1; //start if green signal/no red signal is seen
    }
    if(flag == 1) {
      digitalWrite(motorPin1, HIGH);
      digitalWrite(motorPin2, LOW);
      digitalWrite(motorPin3, LOW);
      digitalWrite(motorPin4, HIGH);
    }
    if(flag == 0) {
      digitalWrite(motorPin1, LOW);
     // digitalWrite(motorPin2, LOW);
     // digitalWrite(motorPin3, LOW);
      digitalWrite(motorPin4, LOW);
    }
  
  }

}
