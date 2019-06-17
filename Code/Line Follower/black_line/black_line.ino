#include <Servo.h>
//HCSR04 trigger and echo pins
#define RHT 3   
#define RHE 2
#define LHT 1
#define LHE 0
#define FHT 5
#define FHE 4

#define LS 6      //left sensor
#define RS 7      //right sensor

#define S 10       //servo motor
#define M1 8      //DC motor
#define M2 9      //DC motor

int matlabData;

Servo servo;

void setup() {
  
  pinMode(LS, INPUT);
  pinMode(RS, INPUT);
  pinMode(M1, OUTPUT);
  pinMode(M2, OUTPUT);
  servo.attach(S);
  Serial.begin(9600);
  
}
void loop() {

  if(Serial.available() > 0) {
    Serial.println("Motor running in reverse for 3 secs\n");
  digitalWrite(M1, LOW);
  digitalWrite(M2, HIGH);
  servo.write(90);
  delay(3000);
  Serial.println("Motor stopped for 5 secs\n");
  stopMotors();
  delay(5000);
  //Move forward; both Black lines
  while(!(digitalRead(LS)) && !(digitalRead(RS))) {
    Serial.println("Black detected\n");
    servo.write(100);
   // startMotors();
    digitalWrite(M1, LOW);
    digitalWrite(M2, HIGH);
    //digitalWrite(M1, HIGH);
    //digitalWrite(M2, LOW);
  }
  Serial.println("While end\n");
 
  //obstacle detected from matlab
  matlabData = 1;
  
  //stop motor
  //digitalWrite(M1, LOW);
  //digitalWrite(M2, LOW);
  stopMotors();
  Serial.println("matlab data is now 1; motors stopped\n");
  if(matlabData == 1) {
    
    Serial.println("Inside matlabData = 1 \n");
    servo.write(65); //turn left for 1.5 seconds
        Serial.println("Motor is turning left");

    startMotors();
    //digitalWrite(M1, HIGH);
    //digitalWrite(M2, LOW);
    delay(1500);

    while(digitalRead(RS)) {
        servo.write(85); //go straight until right sensor senses left Black line
        Serial.println("Right sensor finding left Black line");
    }

    //stop motor
    stopMotors();

    if((!digitalRead(RS))) {
      servo.write(105); //turn right for 1.5 seconds
      startMotors();
      delay(2500);
      servo.write(85);
      delay(3000);
      stopMotors();
    }
    Serial.println("Avoiding obstacle right now");
    /*
     Enter HCSR04 code here to check
     that car has cleared the obstacle
     then initiate turning procedure to bring the car on track
     */
    //without HCSR04 let the car drive itself for 2 second
    
    //initiate right turning sequence
    servo.write(105);
    Serial.println("now 105 right turn");
    startMotors();
    delay(4000);
    while(digitalRead(LS)){
       servo.write(85);
       Serial.println("Left sensor finding left Black line");
    }
    Serial.println("Left sensor has found left Black line");
    stopMotors();
    servo.write(65);
    startMotors();
    delay(1500);
    servo.write(85);
    stopMotors();
    Serial.println("Ideally bot should have been straight now");
    while((digitalRead(RS)) && (digitalRead(LS))) {
      servo.write(85); //turn left for 0.5 seconds
      startMotors();
      servo.write(85);
    }
  }

  //matlabData = 0;
  }
  
}

void stopMotors() {
  digitalWrite(M1, LOW);
  digitalWrite(M2, LOW);
  delay(3000);
}

void startMotors() {
  digitalWrite(M1, HIGH);
  digitalWrite(M2, LOW);
}

