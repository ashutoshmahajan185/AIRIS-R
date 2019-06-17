#include <Servo.h>
//HCSR04 trigger and echo pins
#define RHT 3
#define RHE 2
#define LHT 5
#define LHE 4
#define FHT 7
#define FHE 6

//IR sensors
#define RS 8      //left sensor
#define LS 9      //right sensor

#define S 12       //servo motor
#define M1 10      //DC motor
#define M2 11      //DC motor

int matlabData;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(LS, INPUT);
  pinMode(RS, INPUT);

  pinMode(M1, OUTPUT);
  pinMode(M2, OUTPUT);

  servo.attach(S);

  pinMode(RHT, OUTPUT);
  pinMode(RHE, INPUT);

  pinMode(LHT, OUTPUT);
  pinMode(LHE, INPUT);

  pinMode(FHT, OUTPUT);
  pinMode(FHE, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:

  servo.write(85);
  startMotors();
  delay(2000);
  stopMotors();
  if(Serial.available()>0) // if there is data to read
   {
      matlabData=Serial.read(); // read data
      if (matlabData == 1) {
        stopMotors();
      }
   }
}
void stopMotors() {
  digitalWrite(M1, LOW);
  digitalWrite(M2, LOW);
  delay(3000);
}
