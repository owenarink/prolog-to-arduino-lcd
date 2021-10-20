
#include <LiquidCrystal.h>

// This is where the pins set up on the Arduino
LiquidCrystal lcd(7,8,9,10,11,12);

void setup() {
  lcd.begin(16, 2);
  Serial.begin(9600); 
}

void loop() {
// receive message from Prolog
  if(Serial.available()) {
    lcd.setCursor(0, 1);
// print message with a delay
    lcd.print("                    ");
    delay(100); 
    lcd.setCursor(0, 1);
// sends the message from Prolog to the LCD
    while(Serial.available() > 0){
      lcd.write(Serial.read());
    }
  }
}
