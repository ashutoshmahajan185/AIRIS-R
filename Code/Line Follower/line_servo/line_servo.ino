#include <Servo.h>
//HCSR04 trigger and echo pins
#define RHT 5   
#define RHE 4
#define LHT 3
#define LHE 2
#define FHT 7
#define FHE 6

#define RS 9      //left sensor
#define LS 8      //right sensor

#define S 12       //servo motor
#define M1 10      //DC motor
#define M2 11      //DC motor

int matlabData;

Servo servo;

void setup() {
  
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

  long rDistance, lDistance, fDistance;
  boolean obstaclePassed = false;
   
  servo.write(85);
  if(Serial.available() > 0) {
  Serial.println("Motor running in reverse for 3 secs\n");
  digitalWrite(M1, LOW);
  digitalWrite(M2, HIGH);
  servo.write(85);
  delay(3000);
  
  Serial.println("Motor stopped for 5 secs\n");
  stopMotors();
  delay(5000);
  
  //Move forward; both white lines
  while((digitalRead(LS)) && (digitalRead(RS))) {
    Serial.println("White detected\n");
    servo.write(85);
    startMotors();
  }
  Serial.println("While end\n");
 
  //obstacle detected from matlab
  matlabData = 1;
  
  //stop motor
  stopMotors();
  Serial.println("Matlab data is now 1; motors stopped\n");
  if(matlabData == 1) {
    
    Serial.println("Inside matlabData = 1 \n");
    
    startMotors();
    servo.write(65); //turn left for 1.5 seconds
    Serial.println("Step 1: Motor is turning left");
    delay(1500);

    while(!digitalRead(RS)) {
        servo.write(85); //go straight until right sensor senses left white line
        Serial.println("Step 2: Right sensor finding left white line");
    }

    //stop motor
    stopMotors();

    if((digitalRead(RS))) {
      servo.write(105); //turn right for 1.5 seconds
      delay(2000);  
      Serial.println("Step 3: Tuning right when left white line is found by right sensor");
      startMotors();
      delay(2500);
     
      servo.write(85);
      Serial.println("Step 4: Go straight");
      delay(500);
      stopMotors();
    }
    Serial.println("Step 5: Go straight until obstacle has passed");
    Serial.println("Avoiding obstacle right now");   
    /*
     Enter HCSR04 code here to check
     that car has cleared the obstacle
     then initiate turning procedure to bring the car on track
     */
    
    
    
    
    
    stopMotors();
     
    
    //initiate right turning sequence after the obstacle has passed
    Serial.println("Step 6: Turning right");
    servo.write(105);
    startMotors();
    delay(2000);
    
    Serial.println("Step 7: Go straight till left sensor detects left white line");
    while(!digitalRead(LS)){
       servo.write(85);
    }
    Serial.println("Left sensor has found left white line");
    stopMotors();
    
    Serial.println("Go straight till right sensor finds the right white line");
    while(!digitalRead(RS)) {
      startMotors();  
    }
    stopMotors();

    Serial.println("Step 8: Turn left to align to the white lines");
    servo.write(65);
    startMotors();
    delay(1500);

    Serial.println("Step 9: Go straight on the line path");
    servo.write(85);
    delay(4000);
    stopMotors();
    Serial.println("Ideally bot should have been straight now");
    
    //no sensor is detecting any white line
    while(!(digitalRead(RS)) && !(digitalRead(LS))) {
      servo.write(85); 
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

long hcsr04_distance(int triggerPin, int echoPin) {

  long duration;
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  long distance = (duration / 2) / 29.1;
  return distance;
  
}

