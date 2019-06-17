
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  //Green Signal
  digitalWrite(11, LOW);
  digitalWrite(13, HIGH);  
  delay(2000); 
  //Red Signal
  digitalWrite(12, HIGH);
  digitalWrite(13, LOW);
  delay(4000);   
  //Green Signal again
  digitalWrite(13, HIGH);
  digitalWrite(12, LOW);
}
