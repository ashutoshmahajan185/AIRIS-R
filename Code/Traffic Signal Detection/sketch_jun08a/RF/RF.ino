/*
Welcome to my code for a rangefinder with an 20x4 LCD screen,

Photos at: https://github.com/Jan--Henrik/Arduino-ultrasonic-rangefinder

Parts: HC-SR04  ,  Arduino/clone  ,  a 20x4 display  ,  wires/breadboard , IC/I2C/TWI/SP​​I Serial Interface Board Module

Pin 11 to ECHO
pin 12 to TRIG

A5 to SCL
A4 to SDA

*/
//Libraries

#include <Wire.h>                
#include <LiquidCrystal_I2C.h>   //Display Library
#include <NewPing.h>             //Sensor Library

//Display

LiquidCrystal_I2C lcd(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);  // Set the LCD I2C address

// for a 16x02 display use: LiquidCrystal_I2C lcd(0x20, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);

//Sensor

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.


//variables

int val1 = 0;
int analog1 = 0;
int val2 = 0;
int analog2 = 0;

//setup

void setup()   
{
 
   // LCD Size

  lcd.begin(20,4);        
  
  //In/Outputs
  
  /* not needed */


  //Private Message

  lcd.setCursor(1,0); 
  lcd.print("Ultrasonic Sensor");
  delay(1);
  lcd.setCursor(3,1);
  lcd.print("By Jan Henrik!");
  delay(1);  
  lcd.setCursor(1,2);
  lcd.print("www.janhenrik.org");
  lcd.setCursor(5,3);
  delay(1);   
  lcd.print("");

  delay(2000);   //delay of the message

}

void loop()   //main loop
{


  
  delay(50);     // Wait 50ms between pings, 29ms should be the shortest delay between pings.


  unsigned int uS = sonar.ping();  // Send ping, get ping time in microseconds (uS).
  
  lcd.clear();                     // Clear screen
  
  lcd.setCursor(4,0);              // Set Cursor
  lcd.print("Rangefinder");        // text
  
  lcd.setCursor(2,2);              // move Cursor
  lcd.print("Distance: ");         // Print "Distance"
  lcd.setCursor(12,2);             // move Cursor
  lcd.print(uS / US_ROUNDTRIP_CM); // Convert ping time to distance in cm and print result (0 = outside set distance range)
  lcd.setCursor(15,2);             // move Cursor
  lcd.print("cm");                 // print Something
  

  


}

