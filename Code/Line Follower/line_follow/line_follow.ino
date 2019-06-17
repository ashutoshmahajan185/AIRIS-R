#include <Servo.h>

#define RS 9      //left sensor
#define LS 8      //right sensor

#define S 12       //servo motor
#define M1 10      //DC motor
#define M2 11      //DC motor

const int angle = 90;
Servo servo;

void setup() {
  Serial.begin(9600);
  pinMode(LS, INPUT);
  pinMode(RS, INPUT);
  
  pinMode(M1, OUTPUT);
  pinMode(M2, OUTPUT);
  
  servo.attach(S);

}

void loop() {
  //turning angle
  int degree = 10;
  //straighten axel
  servo.write(angle);
  digitalWrite(M2, HIGH);
  digitalWrite(M1, LOW);
  
  //Move forward, both sensors on white lines
  while((digitalRead(LS)) && (digitalRead(RS))) {
    Serial.println("White detected");
    servo.write(angle);
    startMotors();
  }
  stopMotors();

  //left sensor has detected black; right turn detected
  while(!digitalRead(LS) && digitalRead(RS)) {
      servo.write(angle + degree);
      delay(1500);
      startMotors();
  }
  stopMotors();
  //servo.write(angle);

  //right sensor detects black; left turn detected
  while(!digitalRead(RS) && digitalRead(LS)) {
    servo.write(angle - degree);
    delay(1000);
    startMotors();
  }
  stopMotors();
  //servo.write(angle);
}

void stopMotors() {
  digitalWrite(M1, LOW);
  digitalWrite(M2, LOW);
  delay(1500);
}

void startMotors() {
  digitalWrite(M1, HIGH);
  digitalWrite(M2, LOW);
}
